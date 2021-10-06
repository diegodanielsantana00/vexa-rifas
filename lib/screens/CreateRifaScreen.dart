import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:vexa_rifas/controller/BuildWidgets.dart';
import 'package:vexa_rifas/controller/Routes.dart';
import 'package:vexa_rifas/controller/ultis.dart';
import 'package:vexa_rifas/screens/ConfigScreen.dart';
import 'package:vexa_rifas/screens/HomeScreen.dart';

class CreateRifaScreen extends StatefulWidget {
  const CreateRifaScreen({Key? key}) : super(key: key);

  @override
  _CreateRifaScreenState createState() => _CreateRifaScreenState();
}

class _CreateRifaScreenState extends State<CreateRifaScreen> {
  bool awaitValidation = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Text(""),
        backgroundColor: aplicativoCollor,
        shadowColor: Colors.transparent,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: BuildWidgets().getSize(context).height * 0.13,
              width: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: AssetImage('assets/png/LogoBranca.png'))),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.brown[50],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: aplicativoCollor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () {
                  Utils().navigatorToNoReturnNoAnimated(context, HomeScreen());
                },
                icon: Icon(
                  Icons.home,
                  color: Colors.black,
                )),
            IconButton(
                onPressed: () {
                  Utils()
                      .navigatorToNoReturnNoAnimated(context, ConfigScreen());
                },
                icon: Icon(
                  Icons.settings,
                  color: Colors.black,
                ))
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
              height: BuildWidgets().getSize(context).height * 0.08,
              width: BuildWidgets().getSize(context).width,
              decoration: BoxDecoration(
                color: aplicativoCollor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                    bottomRight: Radius.circular(60)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 4,
                    blurRadius: 10,
                    offset: Offset(-1, 2), // changes position of shadow
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BuildWidgets().buildTextFont(context, 20, FontWeight.w700,
                      "Adicionar credito", Colors.white),
                ],
              )),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: BuildWidgets().getSize(context).height*0.07,
              ),
              BuildWidgets().buildTextFont(context, 14, FontWeight.w600, "1 Real = 1 Crédito VEXA", Colors.black),
              BuildWidgets().buildButton(context, "10 Créditos", (){}, awaitValidation, 0.6, 10),
              BuildWidgets().buildButton(context, "20 Créditos", (){}, awaitValidation,0.6,10),
              BuildWidgets().buildButton(context, "40 Créditos", (){}, awaitValidation,0.6,10),
              BuildWidgets().buildButton(context, "80 Créditos", (){}, awaitValidation,0.6,10),
              BuildWidgets().buildButton(context, "100 Créditos", (){}, awaitValidation,0.6,10),
              Container(
              height: 100,
              width: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: AssetImage('assets/png/mercado-pago-logo.png'))),
            ),
            ],
          ))
        ],
      ),
    );
  }
}
