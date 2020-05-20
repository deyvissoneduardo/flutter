import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _controllerCep = TextEditingController();
  String _resultado = "";

  _recuperaCep() async {
    String cepDigitado = _controllerCep.text;
    String url = "https://viacep.com.br/ws/${cepDigitado}/json/";
    http.Response response;
    response = await http.get(url);
    Map<String, dynamic> retorno = jsonDecode(response.body);
    String cep = retorno["cep"];
    String logradouro = retorno["logradouro"];
    String bairro = retorno["bairro"];
    String localidade = retorno["localidade"];
    setState(() {
      _resultado = "CEP: ${cep} \nLogradouro: ${logradouro},\nBairro: ${bairro},\nLocalidade: ${localidade}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consultando CEP via API"),
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Digite o CEP, sem pontos ou traços"
              ),
              style: TextStyle(
                fontSize: 20
              ),
              controller: _controllerCep,
            ),
            RaisedButton(
              child: Text("Clique aqui"),
              onPressed: _recuperaCep,
            ),
            Text(_resultado)
          ],
        ),
      ),
    );
  }
}
