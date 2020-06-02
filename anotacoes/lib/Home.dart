import 'package:anotacoes/helper/AnotacaoHelper.dart';
import 'package:anotacoes/model/Anotacao.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _controllerTitulo = TextEditingController();
  TextEditingController _controllerDescricao = TextEditingController();
  var _banco = AnotacaoHelper();

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

  _salvarAnotacao() async{
    // recupera o texto digitago
    String titulo = _controllerTitulo.text;
    String descricao = _controllerDescricao.text;

    // insere no banco
    Anotacao anotacao = Anotacao(titulo, descricao, DateTime.now().toString() );
    int resultado = await _banco.salvarAnotacao(anotacao);
     print('salvo com id: ' + resultado.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Anotações"),
        backgroundColor: Colors.lightGreen,
      ),
      body: Container(),
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
