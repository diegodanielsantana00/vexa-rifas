import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:vexa_rifas/controller/BuildWidgets.dart';
import 'package:vexa_rifas/controller/DataLocal.dart';
import 'package:vexa_rifas/controller/Routes.dart';
import 'package:vexa_rifas/controller/SingController.dart';
import 'package:vexa_rifas/screens/HomeScreen.dart';

List dadosLocal = [];

int timeSend = 70;
int timeReference = 1;
bool awaitValidation = false;


// ignore: must_be_immutable
class ValidationScreen extends StatefulWidget {
  String email;
  String idToken;
  ValidationScreen(this.idToken, this.email);

  @override
  _ValidationScreenState createState() => _ValidationScreenState();
}

class _ValidationScreenState extends State<ValidationScreen> {
  void initState() {
    super.initState();
    for (var i = timeSend; i >= 1; i--) {
      Timer(Duration(seconds: timeReference), () {
        setState(() {
          timeSend = i;
        });
      });
      timeReference++;
    }
  }

  @override
  Widget build(BuildContext context) {
    refresh() => setState(() {});
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.1,
              ),
              Container(
                width: size.width * 0.8,
                child: Column(
                  children: [
                    BuildWidgets().buildTextFont(context, 30, FontWeight.w700,
                        "Confirme seu email ", Colors.white),
                    BuildWidgets().buildTextFont(context, 15, FontWeight.w500,
                        widget.email, Colors.white),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.06,
              ),
              BuildWidgets().buildTextFont(context, 14, FontWeight.w500,
                  "Renviar email em $timeSend s", Colors.white),
              SizedBox(
                height: size.height * 0.06,
              ),
              Container(
                width: size.width * 0.8,
                child: Divider(
                  color: Colors.white,
                ),
              ),
              BuildWidgets()
                  .buildButton(context, "Já confirmei meu email", () async{
                    awaitValidation = true;
                   refresh();
                    dynamic boolEmailVerification = await RegisterController().getUserFireBase(widget.idToken);
                     if (boolEmailVerification["users"][0]["emailVerified"] == false) {
                      AlertsDialogValidate().erroAlert(context, 'Email não validado, Por favor valide');
                      awaitValidation = false;
                      refresh();
                     } else {
                       dadosLocal = DataLocal().addDadosList(boolEmailVerification["email"], widget.idToken, dadosLocal, context);
                       DataLocal().saveData(dadosLocal);
                       Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                        (Route<dynamic> route) => false);
                     }
                    
                    
                  }, awaitValidation),
            ],
          ),
        ));
  }
}
