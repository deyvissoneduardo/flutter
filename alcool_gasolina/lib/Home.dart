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
  String _textoResultado = "";

  /****metodo que calcula qual opcao e melhor *******/
  void _calcular(){
    /**pega valor do  _controllerAlcool e transfoma em double*/
    double precoAlcool = double.tryParse( _controllerAlcool.text );
    /**pega valor do  _controllerGasolina transfoma em double*/
    double precoGasolina = double.tryParse( _controllerGasolina.text );

    if(precoAlcool == null || precoGasolina == null){
      setState(() {
        _textoResultado = "Número Invalido para o calculo, troque a (,) por (.) ";
      });
    }else {
      /**
       * Se o preço do álcool dividido pelo preço da gasolina
       * for >= 0.7 e melhor abastecer com gasolina
       * senão melhor alcoll
       * */
      if( ( precoAlcool / precoGasolina ) >= 0.7 ){
        setState(() {
          _textoResultado = "Melhor abastecer com gasolina";
        });
      }else {
        setState(() {
          _textoResultado = "Melhor abastecer com álcool";
        });
      }
      _limpaCampo();
    }
  }

  void _limpaCampo(){
    _controllerAlcool.text = "";
    _controllerGasolina.text = "";
  }

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
                  onPressed: _calcular,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  _textoResultado,
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
