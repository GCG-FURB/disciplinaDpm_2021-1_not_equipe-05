import 'package:flutter/material.dart';

class Configuracao extends StatefulWidget {
  int correctionLevel;

  Configuracao({Key key, correctionLevel}) : super(key: key) {
    this.correctionLevel = correctionLevel;
  }

  @override
  _ConfiguracaoState createState() => _ConfiguracaoState(
      correctionLevel: correctionLevel);
}

class _ConfiguracaoState extends State<Configuracao> {

  int correctionLevel;

  _ConfiguracaoState({int correctionLevel}) {
    this.correctionLevel = correctionLevel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Configurações"),
      ),
      floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
              child: Icon(Icons.map),
              onPressed: () {

              })),
      body: Center(
          child: ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(0),
                child: Center(
                    child: Padding(
                        padding: EdgeInsets.all(10.0),)),
              ),
              Padding(
                  padding: EdgeInsets.all(0),
                  child: Card(
                    child: Padding(
                        padding: EdgeInsets.all(10.0),),
                  )),
              Padding(
                  padding: EdgeInsets.all(0),
                  child: Card(
                    child: Padding(
                        padding: EdgeInsets.all(10.0),),
                  )),
              Padding(
                  padding: EdgeInsets.all(0),
                  child: Card(
                    child: Padding(
                        padding: EdgeInsets.all(10.0),),
                  )),

            ],
          )),
    );
  }
}
