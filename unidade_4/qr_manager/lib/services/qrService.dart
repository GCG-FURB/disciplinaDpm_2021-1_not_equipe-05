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
      debugPrint("Retornou Lista");
      return listQRDTO;

    } else {
      throw Exception('Failed to load QrCodes');
    }

  }catch(e) {
    print(e);
    return [];
  }
}

Future<QRDTO> getQRid(int id) async {
  try{
    final response = await http.get(
      Uri.parse('http://192.168.2.105:8080/location/locations/${id}'),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode >= 200 && response.statusCode <= 300) {

        var qrDTO = QRDTO.fromJsonDecoded(jsonDecode(response.body));

      debugPrint("Retornou QR");
      return qrDTO;

    } else {
      throw Exception('Failed to load QrCodes');
    }

  }catch(e) {
    print(e);
    return null;
  }
}


Future<bool> deleteQR(int id) async {
  try{
    final response = await http.delete(
      Uri.parse('http://192.168.2.105:8080/location/delete/${id}'),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode >= 200 && response.statusCode <= 300) {
      debugPrint("Retornou Lista");
      return true;
    } else {
      throw Exception('Failed to delete qrCode');
    }

  }catch(e) {
    print(e);
    return false;
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
