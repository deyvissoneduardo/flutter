import 'package:anotacoes/helper/AnotacaoHelper.dart';
import 'package:anotacoes/model/Anotacao.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _controllerTitulo = TextEditingController();
  TextEditingController _controllerDescricao = TextEditingController();
  var _banco = AnotacaoHelper();
  List<Anotacao> _anotacoes = List<Anotacao>();

  _exibirTela({Anotacao anotacao}) {
    String textoSalvarAtualizar = "";
    if (anotacao == null) {
      // salvar
      _controllerTitulo.text = "";
      _controllerDescricao.text = "";
      textoSalvarAtualizar = "Salvar";
    } else {
      // atualizar
      _controllerTitulo.text = anotacao.titulo;
      _controllerDescricao.text = anotacao.descricao;
      textoSalvarAtualizar = "Atualizar";
    }

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('$textoSalvarAtualizar Anotação'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: _controllerTitulo,
                  autofocus: true,
                  decoration: InputDecoration(
                      labelText: 'Título', hintText: 'Digite o Título'),
                ),
                TextField(
                  controller: _controllerDescricao,
                  decoration: InputDecoration(
                      labelText: 'Descrição', hintText: 'Digite a Descrição'),
                )
              ],
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancelar')),
              FlatButton(
                  onPressed: () {
                    // salvar
                    _salvarAtualizarAnotacao(anotacaoSelecionada: anotacao);
                    Navigator.pop(context);
                  },
                  child: Text(textoSalvarAtualizar))
            ],
          );
        });
  }

  _recuperaAnotacao() async {
    List anotacoesRecuperados = await _banco.recuperaAnotacao();
    List<Anotacao> listaTemporaria = List<Anotacao>();

    for (var item in anotacoesRecuperados) {
      Anotacao anotacao = Anotacao.fromMap(item);
      listaTemporaria.add(anotacao);
    }

    setState(() {
      _anotacoes = listaTemporaria;
    });

    listaTemporaria = null;
    //print('lista salva: ' + anotacoesRecuperados.toString());
  }

  _salvarAtualizarAnotacao({Anotacao anotacaoSelecionada}) async {
    // recupera o texto digitago
    String titulo = _controllerTitulo.text;
    String descricao = _controllerDescricao.text;

    if (anotacaoSelecionada == null) {
      // insere no banco
      Anotacao anotacao =
      Anotacao(titulo, descricao, DateTime.now().toString());
      int resultado = await _banco.salvarAnotacao(anotacao);
      // print('salvo com id: ' + resultado.toString());
    } else {
      // atualizar
      anotacaoSelecionada.titulo = titulo;
      anotacaoSelecionada.descricao = descricao;
      anotacaoSelecionada.data = DateTime.now().toString();
      int resultado = await _banco.atulizarAnotacao(anotacaoSelecionada);
    }

    _controllerTitulo.clear();
    _controllerDescricao.clear();

    _recuperaAnotacao();
  }

  _formataData(String data) {
    // indica pais de origem para formata datas
    initializeDateFormatting("pt_BR");

    // aplicando formatacao
    //var formater = DateFormat("dd/MMM/y H:m:s");
    var formater = DateFormat.yMMMMd("pt_BR");

    DateTime dataConverte = DateTime.parse(data);
    String dataFormatada = formater.format(dataConverte);

    return dataFormatada;
  }

  _removeAnotacao(int id) async {
    await _banco.removeAnotacao(id);
    _recuperaAnotacao();
  }


  @override
  void initState() {
    super.initState();
    _recuperaAnotacao();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Anotações"),
        backgroundColor: Colors.lightGreen,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                itemCount: _anotacoes.length,
                itemBuilder: (context, index) {
                  final anotacao = _anotacoes[index];

                  return Card(
                    child: ListTile(
                      title: Text(anotacao.titulo),
                      subtitle: Text(
                          '${_formataData(anotacao.data)} - ${anotacao
                              .descricao}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              _exibirTela(anotacao: anotacao);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: Icon(
                                Icons.edit,
                                color: Colors.green,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _removeAnotacao(anotacao.id);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(right: 0),
                              child: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreen,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
        onPressed: () {
          _exibirTela();
        },
      ),
    );
  }
}
