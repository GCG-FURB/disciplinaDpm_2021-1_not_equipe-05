import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:qr_manager/gmap.dart';
import 'package:qr_flutter/qr_flutter.dart';

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

  static TextEditingController qrControllerDesc =
      new TextEditingController();

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
                        builder: (context) => GMap(lat: lat,
                          long: long)));
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
                        child:  QrImage(
                          data: "${lat},${long}",
                          gapless: true,
                          size: 250,
                          errorCorrectionLevel: QrErrorCorrectLevel.H,
                          embeddedImage: AssetImage('assets/images/flutter_logo.png'),
                          embeddedImageStyle: QrEmbeddedImageStyle(
                            size: Size(80, 80),
                          ),
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
          Padding(
              padding: EdgeInsets.all(0),

              child: Column(
                children: [
                  Card(
                    child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text("Descrição: " + desc)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      debugPrint("presisondosaid");
                      return AlertDialog(
                        title: const Text('Edição'),
                        content: Container(
                            child: _editTitleTextField(),
                        ),
                         actions: <Widget>[
                        //   TextButton(
                        //     child: const Text('Confirmar'),
                        //     onPressed: () async {
                        //       deleteQR(element.id).then((value) async {
                        //         if (value){
                        //           // debugPrint(indice.toString());
                        //           listaQr.removeAt(indice);
                        //           // context.findAncestorStateOfType().setState(() {
                        //           //   _createTable(context);
                        //           // });
                        //           Navigator.of(context).pop(true);
                        //           await _createTable(_scaffoldKey.currentContext);
                        //
                        //         } else {
                        //           Navigator.of(context).pop(false);
                        //           ScaffoldMessenger.of(context).showSnackBar(
                        //               SnackBar(
                        //                   content: Text('Falha na exclusão')));
                        //         }
                        //       });
                        //     },
                        //   ),
                          TextButton(
                            child: const Text('Cancelar'),
                            onPressed: () {
                              // context.findAncestorStateOfType().setState(() {
                              //   _createTable(context);
                              // });
                              Navigator.of(context).pop(false);
                            },
                          ),
                        ],
                      );
                    },
                    child: const Text("Editar"),
                  )
                ],
              )),

        ],
      )),
    );
  }



  Widget _editTitleTextField() {
    if (_isEditingText)
      return Center(
        child: TextField(
          onSubmitted: (newValue){
            setState(() {
              initialText = newValue;
              _isEditingText =false;
            });
          },
          autofocus: true,
          controller: qrControllerDesc,
        ),
      );
    return InkWell(
        onTap: () {
      setState(() {
        _isEditingText = true;
      });
    },
    child: Text(
    initialText,
    style: TextStyle(
    color: Colors.black,
    fontSize: 18.0,
    ),
    ));
  }
}


