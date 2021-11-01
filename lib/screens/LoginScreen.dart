import 'package:flutter/material.dart';
import 'package:vexa_rifas/controller/BuildWidgets.dart';
import 'package:vexa_rifas/controller/DataLocal.dart';
import 'package:vexa_rifas/controller/Routes.dart';
import 'package:vexa_rifas/controller/SingController.dart';
import 'package:vexa_rifas/controller/Validate.dart';
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

  void initState() {
    super.initState();
    awaitValidation = false;
  }

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    refresh() => setState(() {});
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
                      Colors.transparent,5,false),
                  BuildWidgets().buildTextField("Senha", true, Icons.password,
                      context, 0.7, _passwordController, Colors.transparent,5,false),
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
                          AlertsDialogValidate().erroAlert(context, 'Usuário ou senha inválido.', 5,(){}, "Fechar", true);
                        }
                      } catch (e) {
                        dynamic boolEmailVerification = await RegisterController().getUserFireBase(validationBD["idToken"]);
                         if (boolEmailVerification["users"][0]["emailVerified"] == false) {
                          await RegisterController().verifyEmailFireBaseUser(validationBD["idToken"]);
                            Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => ValidationScreen(validationBD["idToken"], validationBD["email"])),
                            (Route<dynamic> route) => false);
                         } else {
                           dadosLocal = DataLocal().addDadosList(validationBD["email"], validationBD["idToken"], dadosLocal, context, true);
                           DataLocal().saveData(dadosLocal);
                           Utils().navigatorToNoReturn(context, HomeScreen());
                         }
                        
                      }
            
                  }, awaitValidation,0.6,10),
                  GestureDetector(
                    onTap: (){
                      if (emailValidate(_emailController.text, context) == Colors.transparent) {
                          RegisterController().resetPassword(_emailController.text,context);
                          // AlertsDialogValidate().sucessAlert(context, "Email enviado com sucesso, por favor verifique na caixa de entrada do seu e-email", 5, (){}, true);
                          // AlertsDialogValidate().erroAlert(context, "Algo não deu certo, verifique o email e tente novamente.", 5, (){}, "Ok", true);
                      } else {
                        AlertsDialogValidate().erroAlert(context, "Coloque o seu email na caixa de texto de Email para resetar sua senha", 5, (){}, "Ok", true);
                      }
                    },
                    child:BuildWidgets().buildTextFont(context, 12, FontWeight.w400,
                      "Esqueci a senha", Colors.white),
                  ),
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
                  }, false, 0.6,10),
                ],
              ),
            ),
          )),
    );
  }
}
