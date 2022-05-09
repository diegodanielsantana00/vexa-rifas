import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';


class DataLocal {
  List addDadosList(String email, String token, dynamic dados, dynamic context, bool validationEmail, String name) {
    // ignore: invalid_use_of_protected_member
    (context as Element).reassemble();
    Map<String, dynamic> newDadosList = Map();
    newDadosList["Email"] = email;
    newDadosList["Name"] = name;
    newDadosList["Token"] = token;
    newDadosList["Left"] = false;
    newDadosList["ValidationEmail"] = validationEmail;
    dados = [];
    dados.add(newDadosList);
    return dados;
  }

  List addDadosListLeft(dynamic dados, dynamic context) {
    // ignore: invalid_use_of_protected_member
    (context as Element).reassemble();
    Map<String, dynamic> newDadosList = Map();
    newDadosList["Left"] = true;
    dados = [];
    dados.add(newDadosList);
    return dados;
  }


  Future<File> getData() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  // ignore: unused_element
  Future<File> saveData(List dados) async {
    String data = json.encode(dados);
    final file = await getData();
    return file.writeAsString(data);
  }

  // ignore: unused_element
  Future<String?> readData() async {
    final file = await getData();
    return file.readAsString();
  }

  Future<String?> readDataImage() async {
    final file = await getData();
    return file.readAsString();
  }
}
