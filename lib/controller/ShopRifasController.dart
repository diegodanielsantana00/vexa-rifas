import 'package:flutter/material.dart';
import 'package:vexa_rifas/controller/Routes.dart';

class ShopRifasController {


  Color colorController(dynamic refresh, int int, List listRifa) {
  Color controller = aplicativoCollor;
  if (listRifa.length != 0) {
    for (var i = 0; i < listRifa.length; i++) {
      if (listRifa[i] == int) {
        controller = Colors.amber;
      }
    }
  }
  return controller;
}

double calcRifaAccont(double calcValor, List<dynamic> listRifa) {
  double calcRifaPrice = calcValor * (listRifa.length);
  return calcRifaPrice;
}

List<dynamic> addRemoveListRifaNumber(List<dynamic> listRifa, int numberRifa) {
  bool validationPress = false;
  if (listRifa.length != 0) {
    for (var i = 0; i < listRifa.length; i++) {
      if (listRifa[i] == numberRifa) {
        validationPress = true;
      }
    }
  }
  if (validationPress == true) {
    listRifa.remove(numberRifa);
  } else {
    listRifa.add(numberRifa);
  }

  return listRifa;
}

}