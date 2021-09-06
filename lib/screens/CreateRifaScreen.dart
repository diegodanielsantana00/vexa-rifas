import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Text(""),
        backgroundColor: AplicativoCollor,
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
        backgroundColor: AplicativoCollor,
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
                  utils().navigatorToNoReturnNoAnimated(context, HomeScreen());
                },
                icon: Icon(
                  Icons.home,
                  color: Colors.black,
                )),
            IconButton(
                onPressed: () {
                  utils().navigatorToNoReturnNoAnimated(context, ConfigScreen());
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
                color: AplicativoCollor,
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
                  BuildWidgets().buildTextFont(context, 20, FontWeight.w800,
                      "Crie uma rifa", Colors.white),
                ],
              )),
          Expanded(
              child: Column(
            children: [
              SizedBox(height: BuildWidgets().getSize(context).height*0.03,),
              Row(children: [
                BuildWidgets().buildTextFont(context, 15, FontWeight.w500, "Nome da rifa", Colors.black),
              ],),
              BuildWidgets().buildTextFont(
                  context, 20, FontWeight.w800, "Crie uma rifa", Colors.black),
            ],
          ))
        ],
      ),
    );
  }
}