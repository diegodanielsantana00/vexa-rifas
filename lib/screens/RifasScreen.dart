import 'package:flutter/material.dart';
import 'package:vexa_rifas/controller/BuildWidgets.dart';
import 'package:vexa_rifas/controller/Routes.dart';
import 'package:vexa_rifas/controller/ultis.dart';

class RifasScreen extends StatefulWidget {
  // const RifasScreen({Key? key}) : super(key: key);

  String nameRifa;
  RifasScreen(this.nameRifa);
  @override
  _RifasScreenState createState() => _RifasScreenState();
}

class _RifasScreenState extends State<RifasScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios_new_outlined), onPressed: () => Utils().navigatorBack(context),),
        backgroundColor: AplicativoCollor,
        shadowColor: Colors.transparent,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BuildWidgets().buildTextFont(context, 15, FontWeight.w700, widget.nameRifa, Colors.white)
          ],
        ),
      ),
      backgroundColor: Colors.brown[50],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        label: Row(children: [
            Icon(Icons.shop_2_outlined),
            BuildWidgets().buildTextFont(context, 15, FontWeight.w700, " Comprar Rifa", Colors.white)
        ],),
        onPressed: () {
          print("Tela comprar");
        },
        backgroundColor: AplicativoCollor,
      ),
      body: Column(
        children: [
          
          
        ],
      ),
    );
  }
}
