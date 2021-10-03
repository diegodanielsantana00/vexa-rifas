import 'package:flutter/material.dart';
import 'package:vexa_rifas/controller/BuildWidgets.dart';
import 'package:vexa_rifas/controller/DataLocal.dart';
import 'package:vexa_rifas/controller/Routes.dart';
import 'package:vexa_rifas/controller/SingController.dart';
import 'package:vexa_rifas/controller/ultis.dart';
import 'package:vexa_rifas/screens/HomeScreen.dart';
import 'package:vexa_rifas/screens/RegisterScreen.dart';
import 'package:vexa_rifas/screens/ValidationScrenn.dart';

List dadosLocal = [];

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
    refresh() => setState(() {});
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
                  BuildWidgets().buildButton(context, "Entrar", () async{
                    awaitValidation = true;
                    // ignore: invalid_use_of_protected_member
                    (context as Element).reassemble();
                    dynamic validationBD = await RegisterController().loginFireBaseUser(_emailController.text, _passwordController.text);
                    try {
                        if (validationBD["error"]["code"] == 400) {
                          awaitValidation = false;
                          _passwordController.text = "";
                          refresh();
                          AlertsDialogValidate().erroAlert(context, 'Usuário ou senha inválido.');
                        }
                      } catch (e) {
                        dynamic boolEmailVerification = await RegisterController().getUserFireBase(validationBD["idToken"]);
                        print("boolEmailVerification" + boolEmailVerification.toString());
                         if (boolEmailVerification["users"][0]["emailVerified"] == false) {
                          await RegisterController().verifyEmailFireBaseUser(validationBD["idToken"]);
                            Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => ValidationScreen(validationBD["idToken"], validationBD["email"])),
                            (Route<dynamic> route) => false);
                         } else {
                           dadosLocal = DataLocal().addDadosList(validationBD["email"], validationBD["idToken"], dadosLocal, context);
                           DataLocal().saveData(dadosLocal);
                           Utils().navigatorToNoReturn(context, HomeScreen());
                         }
                        
                      }
            
                  }, awaitValidation),
                  BuildWidgets().buildTextFont(context, 12, FontWeight.w400,
                      "Esqueci a senha", Colors.white),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Container(
                    width: size.width * 0.8,
                    child: Divider(
                      color: Colors.white,
                    ),
                  ),
                  BuildWidgets().buildButton(context, "Criar uma conta", () {
                    Utils().navigatorToReturn(context, RegisterScreen());
                  }, false),
                ],
              ),
            ),
          )),
    );
  }
}
