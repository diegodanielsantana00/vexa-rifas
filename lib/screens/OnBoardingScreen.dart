import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:vexa_rifas/controller/BuildWidgets.dart';
import 'package:vexa_rifas/controller/Routes.dart';
import 'package:vexa_rifas/controller/ultis.dart';
import 'package:vexa_rifas/screens/LoginScreen.dart';


class OnBoardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SafeArea(
        child: IntroductionScreen(
          pages: [
            PageViewModel(
              title: 'Bem vindo ao Vexa Rifas',
              body: 'Vamos começar ?!, Mas antes precisamos de algumas permissão',
              image: buildImage('assets/svg/onBorScreen1.svg', context),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Muito fácil',
              body: 'A facilidade de usar nosso app é gigante, vamos entrar para conhecer',
              image: buildImage('assets/svg/onBorScreen2.svg', context),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Compre suas rifas',
              body: 'Compre suas rifas de forma SIMPLES e SEGURA',
              image: buildImage('assets/svg/onBorScreen3.svg', context),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Vamos começar a concorrer !?',
              body: 'Rápido e Prático',
              footer: BuildWidgets().buildButton(context, "Começar", (){
                Utils().navigatorToNoReturn(context, LoginScreen());
              }, awaitValidation, 4, 5),
              image: buildImage('assets/svg/onBorScreen4.svg', context),
              decoration: getPageDecoration(),
            ),
          ],
          done: Text('Ir', style: TextStyle(fontWeight: FontWeight.w600)),
          onDone: () => goToHome(context),
          showSkipButton: true,
          skip: Text('Pular'),
          color: Colors.white,
          onSkip: () => goToHome(context),
          next: Icon(Icons.arrow_forward),
          dotsDecorator: getDotDecoration(),
          globalBackgroundColor: aplicativoCollor,
          skipFlex: 0,
          nextFlex: 0,
          // isProgressTap: false,
          // isProgress: false,
          // showNextButton: false,
          // freeze: true,
          // animationDuration: 1000,
        ),
      );

  void goToHome(context) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );

  Widget buildImage(String path, context) =>
      Center(child: Container(
        width: BuildWidgets().getSize(context).width*0.7,
        height: BuildWidgets().getSize(context).width*0.7,
        child: SvgPicture.asset(
  path,
),
      ));

  DotsDecorator getDotDecoration() => DotsDecorator(
        color: Colors.white,
        activeColor: aplicativoCollor50,
        
        size: Size(10, 10),
        activeSize: Size(22, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      );

  PageDecoration getPageDecoration() => PageDecoration(
        titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
        bodyTextStyle: TextStyle(fontSize: 18, color: Colors.white),
        descriptionPadding: EdgeInsets.all(16).copyWith(bottom: 0),
        imagePadding: EdgeInsets.all(24),
        pageColor: aplicativoCollor,
        
      );
}
