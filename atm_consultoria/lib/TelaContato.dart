import 'package:flutter/material.dart';

class TelaContato extends StatefulWidget {
  @override
  _TelaContatoState createState() => _TelaContatoState();
}

class _TelaContatoState extends State<TelaContato> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Contato"),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Image.asset("image/detalhe_contato.png"),
                    Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text("Contato",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.cyan
                          ),)
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 15),
                  child: Text("Email: consultoria@atm.com.br",
                    style: TextStyle(
                        fontSize: 20
                    ),),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 15),
                  child: Text("Celular: (61)9 9999-8888"
                      "\nTelefone: (61) 3214-5678",
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
