import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<QRDTO> createQR(QRDTO qr) async {
  try {
    final response = await http.post(
      Uri.parse('http://192.168.2.105:8080/location/createOrUpdateLocation'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "latitude": qr.lat,
        "longitude": qr.long,
        "description": qr.desc,
      }),
    );

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      return QRDTO.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load qr');
    }
  }catch(e) {
    print(e);
    throw Exception('Failed to load qr');
  }

}

Future<List<QRDTO>> getQR() async {
  try{
  final response = await http.get(
    Uri.parse('http://192.168.2.105:8080/location/locations'),
    headers: {"Content-Type": "application/json"},
  );
  if (response.statusCode >= 200 && response.statusCode <= 300) {
    List<dynamic> list = jsonDecode(response.body);
    List<QRDTO> listQRDTO = [];
    list.forEach((dto) {
      var qrDTO = QRDTO.fromJsonDecoded(dto);
      listQRDTO.add(qrDTO);
    });
    debugPrint("aaaa");
    return listQRDTO;

  } else {
    throw Exception('Failed to load person');
  }
  return [];
  }catch(e) {
    print(e);
    return [];
    //throw Exception('Failed to load person');
  }
}

class QRDTO {
  int id;
  String lat;
  String long;
  String desc;

  QRDTO(this.id, this.lat, this.long, this.desc);

  QRDTO.A(this.lat, this.long, this.desc);

  factory QRDTO.fromJson(Map<String, dynamic> json) {
    return QRDTO(json['id'], json['latitude'], json['longitude'], json['description']);
  }

  factory QRDTO.fromJsonDecoded(dynamic json) {
    return QRDTO(json['id'], json['latitude'], json['longitude'], json['description']);
  }
}
