import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {

    // iniciando lista de tarefas
    List _listTask = ["toma café", "almoço", "jantar"];


    return Scaffold(
        appBar: AppBar(
          title: Text("Lista de Tarefas"),
          backgroundColor: Colors.purple,
        ),
        // location do btn
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Colors.purple,
            onPressed: () {
              // abre janela para adc nova task
              showDialog(
                  context: context,
                builder: (context){
                    return AlertDialog(
                      title: Text("Adicionar Tarefa"),
                      content: TextField(
                        decoration: InputDecoration(
                          labelText: "Digite nova tarefa"
                        ),
                        onChanged: (text){
                          // captura texto digitado pelo usuario

                        },
                      ),
                      /*
                       * lista de widgets
                       */
                      actions: <Widget>[
                        FlatButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("Cancelar")
                        ),
                        FlatButton(
                            onPressed: (){
                              // salvar task
                              Navigator.pop(context);
                            },
                            child: Text("Salvar")
                        )
                      ],
                    );
                }
              );
            }
        ),
        body: Column(
          children: <Widget>[
            Expanded(
                child: ListView.builder(
                  // conta lista e exibe na tela
                    itemCount: _listTask.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_listTask[index]),
                      );
                    }
                )
            )
          ],
        )
    );
  }
}
