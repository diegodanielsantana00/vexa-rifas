import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vexa_rifas/controller/BuildWidgets.dart';
import 'package:vexa_rifas/controller/RealTimeFireBase.dart';
import 'package:vexa_rifas/controller/Routes.dart';


class AwaitShopBuy extends StatefulWidget {
  // const AwaitShopBuy({Key? key}) : super(key: key);
  final rifasBuy;
  final credit;
  final idRifa;

  AwaitShopBuy(this.credit,this.rifasBuy,this.idRifa);

  @override
  _AwaitShopBuyState createState() => _AwaitShopBuyState();
}

class _AwaitShopBuyState extends State<AwaitShopBuy> {
  void initState() {
    super.initState();
  
  }

  @override
  Widget build(BuildContext context) {
    RealTimeFireBase().buyNumberRifaCredit(widget.credit,widget.rifasBuy,context,widget.idRifa);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BuildWidgets().buildTextFont(context, 20, FontWeight.w500, "Aguarde processando...", aplicativoCollor),
              SizedBox(
                height: BuildWidgets().getSize(context).height*0.1,
              ),
              Container(
                height: size.width * 0.2,
                width: size.width * 0.2,
                child: CircularProgressIndicator(
                  color: aplicativoCollor,
                ),
              ),
            ],
          ),
        ));
  }
}
