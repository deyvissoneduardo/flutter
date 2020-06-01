import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _controllerTitulo = TextEditingController();
  TextEditingController _controllerDescricao = TextEditingController();

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
                  child: Text('Cancelar')
              ),
              FlatButton(
                  onPressed: (){
                    // salvar
                    Navigator.pop(context);
                  },
                  child: Text('Salvar')
              )
            ],
          );
        });
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
