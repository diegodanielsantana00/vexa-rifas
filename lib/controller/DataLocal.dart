import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';


class DataLocal {
  void addDadosList(String name, String token, dynamic dados, dynamic context) {
    // ignore: invalid_use_of_protected_member
    (context as Element).reassemble();
    Map<String, dynamic> newDadosList = Map();
    newDadosList["TokenAuth"] = token;
    newDadosList["Name"] = name;
    dados = [];
    dados.add(newDadosList);
  }


  Future<File> _getData() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  // ignore: unused_element
  Future<File> _saveData(List dados) async {
    String data = json.encode(dados);
    final file = await _getData();
    return file.writeAsString(data);
  }

  // ignore: unused_element
  Future<String?> _readData() async {
    final file = await _getData();
    return file.readAsString();
  }
}
