import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TelaServico extends StatefulWidget {
  @override
  _TelaServicoState createState() => _TelaServicoState();
}

class _TelaServicoState extends State<TelaServico> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Serviço"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Image.asset("image/detalhe_servico.png"),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                  child: Text("Nossos Serviços",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.cyan
                  ),)
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, left: 15),
                child: Text("Consultoria",
                style: TextStyle(
                  fontSize: 20
                ),),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, left: 15),
                child: Text("Calculo de preços"
                    "\nAcompanhamentos de projetos",
                  style: TextStyle(
                      fontSize: 20
                  ),),
              )
            ],
          ),
        ),
      )
    );
  }
}
