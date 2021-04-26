import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

Future<PessoaDTO> createPessoa(PessoaDTO pessoa) async {
  final response = await http.post(
    Uri.parse('http://localhost:8080/pessoa/new'),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "nome": pessoa.nome,
      "idade": pessoa.idade,
      "cpf": pessoa.cpf,
    }),
  );
  if (response.statusCode >= 200 && response.statusCode <= 300) {
    return PessoaDTO.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load person');
  }
}

Future<List<PessoaDTO>> getPessoa() async {
  final response = await http.get(
    Uri.parse('http://localhost:8080/pessoa/all'),
    headers: {"Content-Type": "application/json"},
  );
  if (response.statusCode >= 200 && response.statusCode <= 300) {
    List<dynamic> list = jsonDecode(response.body);
    List<PessoaDTO> listPessoaDTO = [];
    list.forEach((dto) {
      var pessoaDTO = PessoaDTO.fromJsonDecoded(dto);
      listPessoaDTO.add(pessoaDTO);
    });
    return listPessoaDTO;
  } else {
    throw Exception('Failed to load person');
  }
}

class PessoaDTO {
  int? id;
  String nome;
  int idade;
  String cpf;

  PessoaDTO(this.id, this.nome, this.idade, this.cpf);

  PessoaDTO.A(this.nome, this.idade, this.cpf);

  factory PessoaDTO.fromJson(Map<String, dynamic> json) {
    return PessoaDTO(json['id'], json['nome'], json['idade'], json['cpf']);
  }

  factory PessoaDTO.fromJsonDecoded(dynamic json) {
    return PessoaDTO(json['id'], json['nome'], json['idade'], json['cpf']);
  }
}
