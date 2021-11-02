import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:vexa_rifas/controller/BuildWidgets.dart';
import 'package:vexa_rifas/controller/DataLocal.dart';
import 'package:vexa_rifas/controller/RealTimeFireBase.dart';
import 'package:vexa_rifas/controller/SingController.dart';
import 'package:vexa_rifas/controller/Routes.dart';
import 'package:vexa_rifas/controller/Validate.dart';
import 'package:vexa_rifas/controller/ultis.dart';
import 'package:vexa_rifas/screens/ValidationScrenn.dart';

bool awaitValidation = false;
List dadosLocal = [];

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
  var maskFormatter = new MaskTextInputFormatter(mask: '(##) # ####-####', filter: { "#": RegExp(r'[0-9]') });

  @override
  Widget build(BuildContext context) {
    refresh() => setState(() {});
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          backgroundColor: aplicativoCollor,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Utils().navigatorBack(context),
            ),
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
                      BuildWidgets().buildTextFieldNoIcon(
                          "Nome",
                          false,
                          context,
                          0.33,
                          _firstnameController,
                          Colors.transparent,
                          5),
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                      BuildWidgets().buildTextFieldNoIcon(
                          "Sobrenome",
                          false,
                          context,
                          0.33,
                          _lastnameController,
                          Colors.transparent,
                          5),
                    ],
                  ),
                  BuildWidgets().buildTextField(
                      "Número",
                      false,
                      Icons.smartphone,
                      context,
                      0.7,
                      _numberController,
                      Colors.transparent,
                      5,maskFormatter),
                  BuildWidgets().buildTextField(
                      "Email",
                      false,
                      Icons.email,
                      context,
                      0.7,
                      _emailController,
                      emailValidate(_emailController.text, context),
                      5, false),
                  // emailValidate(_emailController.text, context),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BuildWidgets().buildTextFieldNoIcon(
                          "Senha",
                          true,
                          context,
                          0.33,
                          _passwordController,
                          Colors.transparent,
                          5),
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
                              _passwordConfirmController.text, context),
                          5),
                    ],
                  ),
                  BuildWidgets().buildTextFont(context, 12, FontWeight.w200,
                      MessageApp().passwordCheck, Colors.white),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  Container(
                    width: size.width * 0.8,
                    child: Divider(
                      color: Colors.white,
                    ),
                  ),
                  BuildWidgets().buildButton(context, "Proximo", () async {
                    awaitValidation = true;
                    refresh();
                    dynamic emailValidated =
                        emailValidate(_emailController.text, context);
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
                              _emailController.text.replaceAll(" ", ""),
                              _passwordConfirmController.text,
                              _firstnameController.text,
                              _lastnameController.text,
                              _numberController.text);
                      try {
                        if (validationBD["error"]["code"] == 400) {
                          AlertsDialogValidate()
                              .erroAlert(context, 'Email já cadastrado.', 5, (){}, "Fechar", true);
                          awaitValidation = false;
                          refresh();
                        }
                      } catch (e) {
                        await RealTimeFireBase().setDadosRegister(
                            _emailController.text
                                .replaceAll(".", "")
                                .replaceAll("_", "")
                                .replaceAll("/", "")
                                .replaceAll("@", "")
                                .replaceAll("\\", "")
                                .replaceAll(" ", ""),
                            _numberController.text,
                            "${_firstnameController.text} ${_lastnameController.text}");
                        dadosLocal = DataLocal().addDadosList(
                            _emailController.text,
                            validationBD["idToken"],
                            dadosLocal,
                            context,
                            false, "${_firstnameController.text} ${_lastnameController.text}");
                        DataLocal().saveData(dadosLocal);
                        await RegisterController()
                            .verifyEmailFireBaseUser(validationBD["idToken"]);
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => ValidationScreen(
                                    validationBD["idToken"],
                                    _emailController.text)),
                            (Route<dynamic> route) => false);
                      }
                      awaitValidation = false;
                      refresh();
                    }
                    awaitValidation = false;
                    refresh();
                  }, awaitValidation, 0.6, 10),
                ],
              ),
            ),
          )),
    );
  }
}
