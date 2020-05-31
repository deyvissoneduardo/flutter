import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _listaTarefas = [];
  TextEditingController _controllerTarefa = TextEditingController();

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
                itemCount: _listaTarefas.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text(_listaTarefas[index]['titulo']),
                    value: _listaTarefas[index]['realizada'],
                    onChanged: (valorAlterado) {
                      //print("valor: "+ valorAlterado.toString());
                      setState(() {
                        _listaTarefas[index]['realizada'] = valorAlterado;
                      });

                      _salvarArquivo();
                    },
                  );
                  /*return ListTile(
                    title: Text(_listaTarefas[index]['titulo']),
                  );*/
                }),
          )
        ],
      ),
    );
  }
}
