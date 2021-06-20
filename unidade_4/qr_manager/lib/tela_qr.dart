import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:qr_manager/gmap.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_manager/configuracao.dart';
import 'package:qr_manager/services/qrService.dart';

class TelaQR extends StatefulWidget {
  String lat;
  String long;
  int id;
  String desc;

  TelaQR({Key key, id, lat, long, desc}) : super(key: key) {
    this.lat = lat;
    this.long = long;
    this.id = id;
    this.desc = desc;
  }

  @override
  _TelaQRState createState() => _TelaQRState(
      lat: this.lat, long: this.long, id: this.id, desc: this.desc);
}

class _TelaQRState extends State<TelaQR> {
  String lat;
  String long;
  int id;
  String desc;

  _TelaQRState({String lat, String long, int id, String desc}) {
    this.lat = lat;
    this.long = long;
    this.id = id;
    this.desc = desc;
    initialText = desc;
  }

  @override
  void initState() {
    super.initState();
    qrControllerDesc = TextEditingController(text: initialText);
  }

  @override
  void dispose() {
    qrControllerDesc.dispose();
    super.dispose();
  }

  static TextEditingController qrControllerDesc = new TextEditingController();

  bool _isEditingText = false;
  String initialText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR - " + desc),
      ),
      floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
              child: Icon(Icons.map),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GMap(lat: lat, long: long)));
              })),
      body: Center(
          child: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(0),
            child: Center(
                child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Builder(
                      builder: (context) {
                        int qrErroCorrectLevel;
                        if (Configuracao.correctionLevel == 1) {
                          qrErroCorrectLevel = QrErrorCorrectLevel.L;
                        } else if (Configuracao.correctionLevel == 2) {
                          qrErroCorrectLevel = QrErrorCorrectLevel.M;
                        } else {
                          qrErroCorrectLevel = QrErrorCorrectLevel.H;
                        }
                        debugPrint('configuracao:');
                        debugPrint(Configuracao.correctionLevel.toString());
                        debugPrint('if');
                        debugPrint(qrErroCorrectLevel.toString());
                        return QrImage(
                          data: "${lat},${long}",
                          gapless: true,
                          size: 350,
                          errorCorrectionLevel: qrErroCorrectLevel,
                          embeddedImage:
                              AssetImage('assets/images/qr_manager_logo.png'),
                          embeddedImageStyle: QrEmbeddedImageStyle(
                            size: Size(50, 50),
                          ),
                        );
                      },
                    ))),
          ),
          Padding(
              padding: EdgeInsets.all(0),
              child: Card(
                child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text("Latitude: " + lat)),
              )),
          Padding(
              padding: EdgeInsets.all(0),
              child: Card(
                child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text("Longitude: " + long)),
              )),
          Card(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Row(children: [
                        Text("Descrição: "),
                        _editTitleTextField()
                      ],)),

                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Visibility(
                            visible: _isEditingText? false : true,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(primary: Colors.white),
                              onPressed: () {
                                setState(() {
                                  _isEditingText = true;
                                });
                              },
                              child: Icon(Icons.edit,color: Colors.grey),
                            )),
                      ),
                    ])
                ,Row(children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
                      child: Visibility(
                          visible: _isEditingText? true : false,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(primary: Colors.white),
                            onPressed: () {
                              setState(() {
                                initialText= qrControllerDesc.value.text;
                                _isEditingText = false;

                              });
                              getQRid(id).then((value) {
                                value.desc = initialText;
                                deleteQR(id);
                                createQR(value).then((value) {debugPrint(value.toString());
                                });
                              });
                            },
                            child: Icon(Icons.check,color: Colors.blue),
                          ))),
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Visibility(
                          visible: _isEditingText? true : false,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(primary: Colors.white),
                            onPressed: () {
                              setState(() {
                                qrControllerDesc.text = initialText;
                                _isEditingText = false;
                              });
                            },
                            child: Icon(Icons.clear_rounded,color: Colors.red),
                          )))
                ],)
              ],),
            ),
          )
        ],
      )),
    );
  }

  Widget _editTitleTextField() {
    if (_isEditingText)
         return Flexible(child: Padding(
             padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
             child: TextField(
           maxLength: 30,
           onSubmitted: (newValue) {
             setState(() {
               initialText = newValue;
               _isEditingText = false;
             });
           },
           autofocus: true,
           controller: qrControllerDesc,

         )));

    return InkWell(
        onTap: () {
          // setState(() {
          //   _isEditingText = true;
          // });
        },
        child: Text(
          initialText,
          style: TextStyle(
            color: Colors.black,
            fontSize: 14.0,
          ),
        ));
  }
}


