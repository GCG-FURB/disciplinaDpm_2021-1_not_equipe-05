import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

Future<CarroDTO> createCarro(CarroDTO carro) async {
  final response = await http.post(
    Uri.parse('http://localhost:8080/carro/new'),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "nome": carro.nome,
      "marca": carro.marca,
      "anoDeFabricacao": carro.anoDeFabricacao,
    }),
  );
  if (response.statusCode >= 200 && response.statusCode <= 300) {
    return CarroDTO.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load car');
  }
}

Future<List<CarroDTO>> getCarro() async {
  final response = await http.get(
    Uri.parse('http://localhost:8080/carro/all'),
    headers: {"Content-Type": "application/json"},
  );
  if (response.statusCode >= 200 && response.statusCode <= 300) {
    List<dynamic> list = jsonDecode(response.body);
    List<CarroDTO> listCarroDTO = [];
    list.forEach((dto) {
      var pessoaDTO = CarroDTO.fromJsonDecoded(dto);
      listCarroDTO.add(pessoaDTO);
    });
    return listCarroDTO;
  } else {
    throw Exception('Failed to load person');
  }
}

class CarroDTO {
  int? id;
  String nome;
  String marca;
  int anoDeFabricacao;

  CarroDTO(this.id, this.nome, this.marca, this.anoDeFabricacao);

  CarroDTO.A(this.nome, this.marca, this.anoDeFabricacao);

  factory CarroDTO.fromJson(Map<String, dynamic> json) {
    return CarroDTO(
        json['id'], json['nome'], json['marca'], json['anoDeFabricacao']);
  }

  factory CarroDTO.fromJsonDecoded(dynamic json) {
    return CarroDTO(json['id'], json['nome'], json['marca'], json['anoDeFabricacao']);
  }
}
