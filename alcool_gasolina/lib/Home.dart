import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _controllerAlcool = TextEditingController();
  TextEditingController _controllerGasolina = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Álcool ou Gasolina"),
        backgroundColor: Colors.cyan,
      ),
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(32),
          child: (Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              /*** image ****/
              Padding(
                padding: EdgeInsets.only(bottom: 32),
                child: Image.asset("image/logo.png"),
              ),
              /**** texto *****/
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  "Saiba qual melhor opção de abastecimento do seu carro",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              /**** alcool*******/
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Preço Álcool:"),
                style: TextStyle(fontSize: 22),
                controller: _controllerAlcool,
              ),
              /******gasolina*******/
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Preço Gasolina:"),
                style: TextStyle(fontSize: 22),
                controller: _controllerGasolina,
              ),
              /********btn calcular ********/
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: RaisedButton(
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "Calcular",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {},
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  "Resultado: ",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}
