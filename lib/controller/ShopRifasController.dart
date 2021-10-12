import 'package:flutter/material.dart';
import 'package:vexa_rifas/controller/Routes.dart';

class ShopRifasController {
  Color colorController(
      dynamic refresh, int int, List listRifa, List<dynamic>? rifasShop) {
    Color controller = aplicativoCollor;

    if (rifasShop?.length != 0) {
      for (var i = 0; i < rifasShop!.length; i++) {
        if (rifasShop[i] == int) {
          controller = Colors.red;
        }
      }
    }

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

  List<dynamic> addRemoveListRifaNumber(
      List<dynamic> listRifa, int numberRifa, List<dynamic>? rifasShop) {
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

    if (listRifa.length != 0 && rifasShop!.length != 0) {
      for (var i = 0; i < listRifa.length; i++) {
      for (var j = 0; j < rifasShop.length; j++) {
        if (listRifa[i] == rifasShop[j]) {
          listRifa.remove(rifasShop[j]);
        }else{

        }
      }
    }
    }



    return listRifa;
  }
}
