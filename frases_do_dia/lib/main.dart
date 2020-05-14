import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

/*
  Stateless = Widgets que nao podem ser alterados
  Stateful = Widgets que podem ser alterados
 */
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeStateful(),
    /*Container(
         //margin: EdgeInsets.all(0),
         margin: EdgeInsets.only(top: 40),
        // color: Colors.white,
        decoration:
            BoxDecoration(border: Border.all(width: 3, color: Colors.grey)),
        child: Image.asset(
          "images/laptop.jpg",
          fit: BoxFit.contain,
        ),
        /*Column(
          children: <Widget>[
            Text('T-1'),
            Text('T-2'),
            Text('T-3')
            /*Text(
              'Lorem ipsum',
              textAlign: TextAlign.justify,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Text("Texto 2"),
            )*/
            /* FlatButton(
              onPressed: (){
                print('btn pressionado');
              },
              child: Text(
                'Clique aqui' ,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                  decoration: TextDecoration.none
                ),
              )
          )*/
            /* Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean nec ipsum diam.",
          style: TextStyle(
            fontSize: 35,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.normal,
            letterSpacing: 0,
            wordSpacing: 0,
            decoration: TextDecoration.overline,
            decorationStyle: TextDecorationStyle.solid,
            decorationColor: Colors.black12,
            color: Colors.black87
          ),
          )*/
          ],
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ),*/
      )*/
  ));
}

class HomeStateful extends StatefulWidget {
  @override
  _HomeStatefulState createState() => _HomeStatefulState();
}

class _HomeStatefulState extends State<HomeStateful> {

  var _texto = "My App desenvolvido em Flutter";
  @override
  Widget build(BuildContext context) {
    print('Build chamado');
    return Scaffold(
      appBar: AppBar(
        title: Text( "My App" ),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: (){
                setState(() {
                  _texto = "Curso Flutter";
                });
              },
              color: Colors.blueGrey,
              child: Text("Clique aqui"),
            ),
            Text('Nome: $_texto')
          ],
        ),
      ),
    );
  }
}


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var _title = "My App";
    return Scaffold(
      appBar: AppBar(
        title: Text( _title ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Text('Conteudo Pricinpal'),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.lightBlueAccent,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: <Widget>[Text('Conteudo Botton')],
          ),
        ),
      ),
    );
  }
}
