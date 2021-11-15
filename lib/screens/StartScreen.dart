import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:vexa_rifas/controller/BuildWidgets.dart';
import 'package:vexa_rifas/controller/DataLocal.dart';
import 'package:vexa_rifas/controller/Routes.dart';
import 'package:vexa_rifas/controller/ultis.dart';
import 'package:vexa_rifas/screens/HomeScreen.dart';
import 'package:vexa_rifas/screens/LoginScreen.dart';

bool awaitValidation = false;

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  void initState() {
    super.initState();
    dynamic screen = LoginScreen();
    // Se ja tem conta criada
    DataLocal().readData().then((data) async {
      dynamic dados = json.decode(data!);
      if (dados[0]["ValidationEmail"] == false) {
      } else {
        screen = HomeScreen();
      }
    }).catchError((data) {
      // AlertsDialogValidate().erroAlert(context, 'Ocorreu um erro, faça login novamente', 0, (){}, 'Fazer Login', false);
    });

    Timer(Duration(seconds: 2), () {
      Utils().navigatorToNoReturn(context, screen);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: aplicativoCollor,
        appBar: AppBar(
          backgroundColor: aplicativoCollor,
          shadowColor: Colors.transparent,
          title: Container(
            height: size.height * 0.13,
            width: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: AssetImage('assets/png/LogoBranca.png'))),
          ),
        ),
        body: Center(
          child: Container(
            height: size.width * 0.2,
            width: size.width * 0.2,
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        ));
  }
}
