import 'package:anotacoes/helper/AnotacaoHelper.dart';
import 'package:anotacoes/model/Anotacao.dart';
import 'package:flutter/material.dart';
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

  _exibirTela() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Adcionar Anotação'),
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
                    _salvarAnotacao();
                    Navigator.pop(context);
                  },
                  child: Text('Salvar'))
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

  _salvarAnotacao() async {
    // recupera o texto digitago
    String titulo = _controllerTitulo.text;
    String descricao = _controllerDescricao.text;

    // insere no banco
    Anotacao anotacao = Anotacao(titulo, descricao, DateTime.now().toString());
    int resultado = await _banco.salvarAnotacao(anotacao);
    // print('salvo com id: ' + resultado.toString());

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

    DateTime dataConverte = DateTime.parse( data );
    String dataFormatada = formater.format( dataConverte );

    return dataFormatada;
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
                  final item = _anotacoes[index];

                  return Card(
                    child: ListTile(
                      title: Text(item.titulo),
                      subtitle: Text(
                          '${_formataData(item.data)} - ${item.descricao}'),
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
