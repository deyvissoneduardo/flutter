import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart' as http;

import 'Post.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _urlBase = "https://jsonplaceholder.typicode.com";

  Future<List<Post>> _recuperarPostagens() async {
    http.Response response = await http.get(_urlBase + "/posts");
    var dadosJson = json.decode(response.body);

    List<Post> postagens = List();
    for (var post in dadosJson) {
      print("post: " + post["title"]);
      Post p = Post(post["userId"], post["id"], post["title"], post["body"]);
      postagens.add(p);
    }
    return postagens;
    //print( postagens.toString() );
  }

  _post() async {
    var corpo = json
        .encode({"userId": 1, "id": null, "title": "Title create", "body": "criado"});

    http.Response response = await http.post(_urlBase + '/posts',
        headers: {"Content-type": "application/json; charset=UTF-8"},
        body: corpo);
    print('responta: ${response.statusCode}');
    print('responta: ${response.body}');
  }

  _put() async {
    var corpo = json
        .encode({"userId": 1, "id": null, "title": null, "body": "atualizado com put"});

    http.Response response = await http.put(_urlBase + '/posts/2',
        headers: {"Content-type": "application/json; charset=UTF-8"},
        body: corpo);
    print('responta: ${response.statusCode}');
    print('responta: ${response.body}');
  }

  _path() async {
    var corpo = json
        .encode({"userId": 1, "body": "atualizado com path"});

    http.Response response = await http.patch(_urlBase + '/posts/2',
        headers: {"Content-type": "application/json; charset=UTF-8"},
        body: corpo);
    print('responta: ${response.statusCode}');
    print('responta: ${response.body}');
  }

  _delete() async {
    http.Response response = await http.delete(
      _urlBase + '/posts/3'
    );
    print('responta: ${response.statusCode}');
    print('responta: ${response.body}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo de serviço avançado"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                RaisedButton(
                  onPressed: _post,
                  child: Text('Salvar'),
                ),
                RaisedButton(
                  onPressed: _put,
                  child: Text('put'),
                ),
                RaisedButton(
                  onPressed: _path,
                  child: Text('path'),
                ),
                RaisedButton(
                  onPressed: _delete,
                  child: Text('excluir'),
                )
              ],
            ),
            Expanded(
              child: FutureBuilder<List<Post>>(
                future: _recuperarPostagens(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return CircularProgressIndicator();
                      break;
                    case ConnectionState.active:
                    case ConnectionState.done:
                      if (snapshot.hasError) {
                        print("Error");
                      } else {}
                      break;
                  }
                  return Center(
                    child: Text(""),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
