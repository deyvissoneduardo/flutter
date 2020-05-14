import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

void main() {
  runApp(MaterialApp(
      // debugShowCheckedModeBanner: false,
      title: 'Frases do dia!!',
      home: Container(
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
      )));
}
