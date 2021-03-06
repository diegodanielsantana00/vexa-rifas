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
  String url;
  String desc;
  RifasScreen(this.nameRifa, this.priceRifa, this.countRifas, this.idRifa, this.url, this.desc);
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
                      color: Colors.transparent,
                      height: BuildWidgets().getSize(context).width * 0.5,
                      width: BuildWidgets().getSize(context).width * 0.9,
                      child: Image(image: AssetImage('assets/png/rifasImages/' + widget.url + '.png'),
                      height: BuildWidgets().getSize(context).width * 0.3,
                      width: BuildWidgets().getSize(context).width * 0.3,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return Image(
                          image: AssetImage(
                            'assets/png/rifasImages/Error.png',
                          ),
                          
                          height: BuildWidgets().getSize(context).width * 0.3,
                          width: BuildWidgets().getSize(context).width * 0.3,
                        );
                      },
                    ))),
            ],
          ),
          Divider(

          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
              children: [
                buildDescrition(context, widget.nameRifa, "Produto da Rifa", 18),
                buildDescrition(context, "R\$${Utils().moneyTransform(widget.priceRifa)}", "Valor da Rifa", 18),
                buildDescrition(context, widget.desc, "Descri????o", 14),
                
              ],
                      ),
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
              SizedBox(
                    height: 5,
                  ),
              Container(
                width: BuildWidgets().getSize(context).height *0.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(child: BuildWidgets().buildTextFont(context, fontSizedDesc, FontWeight.w700,
                        body, Colors.black),)
                  ],
                ),
              ),
            ],
          );
}
