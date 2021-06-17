import 'dart:collection';


import 'package:flutter/material.dart';
import 'package:qr_manager/gmap.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("QR - " + desc),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.arrow_back_sharp),
              )),
        ],
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
          Card(),
          Padding(
              padding: EdgeInsets.all(0),
              child: Card(
                child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text("id: " + id.toString())),
              )),
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
              child: Card(
                child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text("Descrição: " + desc)),
              ))
        ],
      )),
    );
  }
}
