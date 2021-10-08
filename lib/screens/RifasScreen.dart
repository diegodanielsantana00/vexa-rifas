import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vexa_rifas/controller/BuildWidgets.dart';
import 'package:vexa_rifas/controller/Routes.dart';
import 'package:vexa_rifas/controller/ultis.dart';
import 'package:vexa_rifas/screens/ShopRifaScreen.dart';

// ignore: must_be_immutable
class RifasScreen extends StatefulWidget {
  String nameRifa;
  dynamic priceRifa;
  int countRifas;
  int idRifa;
  RifasScreen(this.nameRifa, this.priceRifa, this.countRifas, this.idRifa);
  @override
  _RifasScreenState createState() => _RifasScreenState();
}

class _RifasScreenState extends State<RifasScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () => Utils().navigatorBack(context),
        ),
        backgroundColor: aplicativoCollor,
        shadowColor: Colors.transparent,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BuildWidgets().buildTextFont(
                context, 15, FontWeight.w700, widget.nameRifa, Colors.white)
          ],
        ),
      ),
      backgroundColor: Colors.brown[50],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        label: Row(
          children: [
            Icon(Icons.shop_2_outlined),
            BuildWidgets().buildTextFont(
                context, 15, FontWeight.w700, " Comprar Rifa", Colors.white)
          ],
        ),
        onPressed: () {
          Utils().navigatorToReturn(context, ShopRifaScreen(widget.nameRifa, widget.countRifas,widget.priceRifa, widget.idRifa));
        },
        backgroundColor: aplicativoCollor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Container(
                      color: Colors.green[300],
                      height: BuildWidgets().getSize(context).width * 0.5,
                      width: BuildWidgets().getSize(context).width * 0.9,
                      child: Image.network(
                        'https://picsum.photos/250?image=9',
                        height: BuildWidgets().getSize(context).width * 0.5,
                        width: BuildWidgets().getSize(context).width * 0.9,
                      ))),
            ],
          ),
          Expanded(
            child: Column(
            children: [
              buildDescrition(context, widget.nameRifa, "Produto da Rifa", 18),
              buildDescrition(context, "R\$${Utils().moneyTransform(widget.priceRifa)}", "Valor da Rifa", 18),
              buildDescrition(context, "A asopdnpaosdifn apsdoif naspodfin pasodifn pasodifnpasodif npasdoifn psaodifnapsodifnapsodifnapodifnaksdm;l ,zmxc;l aknvjnpoiuenvpwupwornpou npruo nepwourn pwoerunf [pkmadf", "Descrição", 14),
            ],
          ))
        ],
      ),
    );
  }
}


Widget buildDescrition(dynamic context,String body, String type, double fontSizedDesc) {
  return Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  BuildWidgets().buildTextFont(context, 14, FontWeight.w500,
                      "$type:", Colors.black),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(child: BuildWidgets().buildTextFont(context, fontSizedDesc, FontWeight.w700,
                      body, Colors.black),)
                ],
              ),
            ],
          );
}
