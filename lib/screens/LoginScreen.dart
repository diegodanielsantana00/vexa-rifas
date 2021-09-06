import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vexa_rifas/controller/BuildWidgets.dart';
import 'package:vexa_rifas/controller/Routes.dart';
import 'package:vexa_rifas/controller/SingController.dart';
import 'package:vexa_rifas/controller/ultis.dart';
import 'package:vexa_rifas/screens/HomeScreen.dart';
import 'package:vexa_rifas/screens/RegisterScreen.dart';
import 'package:vexa_rifas/screens/ValidationScrenn.dart';
bool validation = true;
bool awaitValidation = false;
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BuildWidgets().buildErro(context, size, validation, "Usuário ou Senha inválido"),
              Container(
                height: size.height * 0.2,
                width: size.width * 0.5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: AssetImage('assets/png/MulherDeNegocios.png'))),
              ),
              BuildWidgets().buildTextField(
                  "Email",
                  false,
                  Icons.email_outlined,
                  context,
                  0.7,
                  _emailController,
                  Colors.transparent,5),
              BuildWidgets().buildTextField("Senha", true, Icons.password,
                  context, 0.7, _passwordController, Colors.transparent,5),
              BuildWidgets().buildButton(context, size, "Entrar", () async{
                awaitValidation = true;
                // ignore: invalid_use_of_protected_member
                (context as Element).reassemble();
                dynamic validationBD = await RegisterController().loginFireBaseUser(_emailController.text, _passwordController.text);
                try {
                    if (validationBD["error"]["code"] == 400) {
                      validation = false;
                      awaitValidation = false;
                      // ignore: unnecessary_cast, ignore: invalid_use_of_protected_member
                      Timer(Duration(seconds: 3), () {validation = true;(context as Element).reassemble();});
                      // ignore: unnecessary_cast
                      (context as Element).reassemble();
                    }
                  } catch (e) {
                    dynamic boolEmailVerification = await RegisterController().getUserFireBase(validationBD["idToken"]);
                    print("boolEmailVerification" + boolEmailVerification.toString());
                    print("validationBD" + validationBD.toString());
                     if (boolEmailVerification["users"][0]["emailVerified"] == false) {
                      await RegisterController().verifyEmailFireBaseUser(validationBD["idToken"]);
                        Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => ValidationScreen(validationBD["idToken"], validationBD["email"])),
                        (Route<dynamic> route) => false);
                     } else {
                       Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                        (Route<dynamic> route) => false);
                     }
                    
                  }

              }, awaitValidation),
              BuildWidgets().buildTextFont(context, 12, FontWeight.w400,
                  "Esqueci a senha", Colors.white),
              SizedBox(
                height: size.height * 0.04,
              ),
              Container(
                width: size.width * 0.8,
                child: Divider(
                  color: Colors.white,
                ),
              ),
              BuildWidgets().buildButton(context, size, "Criar uma conta", () {
                utils().navigatorToReturn(context, RegisterScreen());
              }, false),
            ],
          ),
        ));
  }
}
