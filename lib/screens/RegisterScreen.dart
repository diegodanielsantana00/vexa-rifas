import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vexa_rifas/controller/BuildWidgets.dart';
import 'package:vexa_rifas/controller/SingController.dart';
import 'package:vexa_rifas/controller/Routes.dart';
import 'package:vexa_rifas/controller/Validate.dart';
import 'package:vexa_rifas/screens/HomeScreen.dart';
import 'package:vexa_rifas/screens/ValidationScrenn.dart';

bool awaitValidation = false;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _numberController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _firstnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          backgroundColor: AplicativoCollor,
          appBar: AppBar(
            leading: Icon(Icons.arrow_back_outlined),
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
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: size.height * 0.2,
                    width: size.width * 0.5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: AssetImage('assets/png/Register.png'))),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BuildWidgets().buildTextFieldNoIcon( "Nome", false,
                          context, 0.33, _firstnameController, Colors.transparent),
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                      BuildWidgets().buildTextFieldNoIcon( "Sobrenome", false,
                          context, 0.33, _lastnameController, Colors.transparent),
                    ],
                  ),
                  BuildWidgets().buildTextField(
                      "Número",
                      false,
                      Icons.smartphone,
                      context,
                      0.7,
                      _numberController,
                      Colors.transparent,5),
                  BuildWidgets().buildTextField(
                      "Email",
                      false,
                      Icons.email,
                      context,
                      0.7,
                      _emailController,
                      emailValidate(_emailController.text, context), 5),
                  // emailValidate(_emailController.text, context),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BuildWidgets().buildTextFieldNoIcon( "Senha", true,
                          context, 0.33, _passwordController, Colors.transparent),
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                      BuildWidgets().buildTextFieldNoIcon(
                          
                          "Confirmar Senha",
                          true,
                          context,
                          0.33,
                          _passwordConfirmController,
                          passwordValidate(_passwordController.text,
                              _passwordConfirmController.text, context)),
                    ],
                  ),
                  BuildWidgets().buildTextFont(context, 12, FontWeight.w200,
                      menssagerApp().passwordCheck, Colors.white),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  Container(
                    width: size.width * 0.8,
                    child: Divider(
                      color: Colors.white,
                    ),
                  ),
                  BuildWidgets().buildButton(context, size, "Proximo", () async {
                    dynamic emailValidated = emailValidate(_emailController.text, context);
                    dynamic password2Validated = passwordValidate(
                        _passwordController.text,
                        _passwordConfirmController.text,
                        context);
            
                    if (emailValidated == Colors.transparent &&
                        _emailController.text != "" &&
                        password2Validated == Colors.transparent &&
                        _passwordConfirmController.text != "") {
                      dynamic validationBD = await RegisterController()
                          .registerFireBaseUser(
                              _emailController.text,
                              _passwordConfirmController.text,
                              _firstnameController.text,
                              _lastnameController.text,
                              _numberController.text);
                      try {
                        if (validationBD["error"]["code"] == 400) {
                          AlertsDialogValidate().erroAlert(context,'Email já cadastrado.');
                          awaitValidation = false;
                          (context as Element).reassemble();
                        }
                      } catch (e) {
                        await RegisterController().verifyEmailFireBaseUser(validationBD["idToken"]);
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => ValidationScreen(validationBD["idToken"], _emailController.text)),
                            (Route<dynamic> route) => false);
                      }
                      awaitValidation = false;
                      (context as Element).reassemble();
                    }
                    awaitValidation = false;
                    (context as Element).reassemble();
                  }, awaitValidation),
                ],
              ),
            ),
          )),
    );
  }
}
