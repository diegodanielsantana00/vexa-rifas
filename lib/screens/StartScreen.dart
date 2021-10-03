import 'dart:async';
import 'package:flutter/material.dart';
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
    DataLocal().readData().then((data) {
      screen = HomeScreen(); // RESPONSAVEL PARA VERIFICAR LOGIN
    }).catchError((data) {
      // AlertsDialogValidate().erroAlert(context, 'Ocorreu um erro, faça login novamente');
    });

    Timer(Duration(seconds: 2), () {
      Utils().navigatorToNoReturn(context, screen);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AplicativoCollor,
        appBar: AppBar(
          backgroundColor: AplicativoCollor,
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