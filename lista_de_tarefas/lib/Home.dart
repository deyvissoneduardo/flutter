import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:path_provider/path_provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _listaTarefas = [];
  TextEditingController _controllerTarefa = TextEditingController();
  Map<String, dynamic> _ultimoRemovido = Map();

  Future<File> _getFile() async {
    // caminho relativo onde esta sendo salvo
    final diretorio = await getApplicationDocumentsDirectory();
    return File("${diretorio.path}/dados.json");
  }

  /*
   * Recupera oque foi digitado
   */
  _salvarTarefa() {
    String textoDigitado = _controllerTarefa.text;

    //salvar dados
    Map<String, dynamic> tarefa = Map();
    tarefa["titulo"] = textoDigitado;
    tarefa["realizada"] = false;

    setState(() {
      _listaTarefas.add(tarefa);
    });

    _salvarArquivo();
    _controllerTarefa.text = "";
  }

  /*
  * Pega lista do metodo _salvarTarefa()
  * e salva no diretorio.path
   */
  _salvarArquivo() async {
    var arquivo = await _getFile();

    String dados = json.encode(_listaTarefas);
    arquivo.writeAsString(dados);

    //print("Caminho: " + diretorio.path );
  }

  _lerArquivo() async {
    try {
      // recupera arquivo salvo
      final arquivo = await _getFile();
      return arquivo.readAsString();
    } catch (e) {
      // caso error, recupera o script
      print(e.toString());
      return null;
    }
  }

  Widget criaItemLista(context, index) {
   // final position = _listaTarefas[index]['titulo'];

    return Dismissible(
        key: Key( DateTime.now().millisecondsSinceEpoch.toString() ),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          //recupera ultimo item excluido
          _ultimoRemovido = _listaTarefas[index];
          // remove item da lista
          _listaTarefas.removeAt(index);
          _salvarArquivo();
          //snackbar
          final snackbar = SnackBar(
            duration: Duration(seconds: 3),
            content: Text('Conteudo removido'),
            action: SnackBarAction(
                label: "Desfazer",
                onPressed: () {
                  // action desfazer
                  setState(() {
                    _listaTarefas.insert(index, _ultimoRemovido);
                  });
                  _salvarArquivo();
                }),
          );
          Scaffold.of(context).showSnackBar(snackbar);
        },
        background: Container(
            color: Colors.red,
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ],
            )),
        child: CheckboxListTile(
          title: Text(_listaTarefas[index]['titulo']),
          value: _listaTarefas[index]['realizada'],
          onChanged: (valorAlterado) {
            //print("valor: "+ valorAlterado.toString());
            setState(() {
              _listaTarefas[index]['realizada'] = valorAlterado;
            });

            _salvarArquivo();
          },
        ));
  }

  @override
  void initState() {
    // faz alteracao anted de carregar o build
    super.initState();
    _lerArquivo().then((dados) {
      setState(() {
        _listaTarefas = json.decode(dados);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //_salvarArquivo();
    //print("itens 1: " + _listaTarefas.toString());

    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de tarefas"),
        backgroundColor: Colors.purple,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.purple,
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Adicionar Tarefa"),
                    content: TextField(
                      controller: _controllerTarefa,
                      // observa oque foi digitado
                      decoration:
                          InputDecoration(labelText: "Digite sua tarefa"),
                      onChanged: (text) {},
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("Cancelar"),
                        onPressed: () => Navigator.pop(context),
                      ),
                      FlatButton(
                        child: Text("Salvar"),
                        onPressed: () {
                          //salvar
                          _salvarTarefa();
                          Navigator.pop(context);
                        },
                      )
                    ],
                  );
                });
          }),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                itemCount: _listaTarefas.length, itemBuilder: criaItemLista),
          )
        ],
      ),
    );
  }
}
