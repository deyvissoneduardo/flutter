import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp( MaterialApp(
    title: 'Frases do dia!!',
    home: Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Text(
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
          )
        ],
      ),
    )
  ));
}