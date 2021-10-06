import 'package:flutter/material.dart';
import 'package:vexa_rifas/controller/BuildWidgets.dart';
import 'package:vexa_rifas/controller/Routes.dart';
import 'package:vexa_rifas/controller/ShopRifasController.dart';
import 'package:vexa_rifas/controller/ultis.dart';

var listRifa = [];
double calcRifaPrice = 0;

class ShopRifaScreen extends StatefulWidget {
  // const ShopRifaScreen({Key? key}) : super(key: key);
  final String nameRifa;
  final int countRifa;
  final double priceRifa;

  ShopRifaScreen(this.nameRifa, this.countRifa, this.priceRifa);


  @override
  _ShopRifaScreenState createState() => _ShopRifaScreenState();
}

class _ShopRifaScreenState extends State<ShopRifaScreen> {

  void initState() {
    super.initState();
    listRifa = [];
    calcRifaPrice = 0;
  }

  late double _priceRifa = widget.priceRifa;

  int controllerRifaIndex = 1;
  @override
  Widget build(BuildContext context) {
    refresh() => setState(() {});
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_outlined),
            onPressed: () {
              Utils().navigatorBack(context);
              
            }),
        backgroundColor: aplicativoCollor,
        shadowColor: Colors.transparent,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BuildWidgets().buildTextFont(context, 15, FontWeight.w700,
                "Comprar - ${widget.nameRifa}", Colors.white)
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                height: BuildWidgets().getSize(context).height * 0.06,
                child: Column(
                  children: [
                    BuildWidgets().buildTextFont(
                        context, 12, FontWeight.w400, "Valor:", Colors.black),
                    BuildWidgets().buildTextFont(
                        context,
                        18,
                        FontWeight.w700,
                        "${Utils().moneyTransform(calcRifaPrice)} Créditos",
                        Colors.black),
                  ],
                )),
            Padding(
              padding: EdgeInsets.all(8),
              child: BuildWidgets()
                  .buildButton(context, "Comprar", () {
                    if (calcRifaPrice == 0) {
                      AlertsDialogValidate().erroAlert(context, "Escolha algum número para comprar");
                    }else{
                      print("passou tela de compra");
                    }
                  }, false, 0.4, 0),
            )
          ],
        ),
      ),
      backgroundColor: Colors.brown[50],
      body: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BuildWidgets().buildTextFont(context, 18, FontWeight.w700,
                  "Escolha seu número", Colors.black)
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
              child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: widget.countRifa ~/ 3 + 2,
            itemBuilder: (context, index) {
              if (index == 0) {
                return SizedBox();
              }
              int i2 = index * 3;
              int i1 = i2 - 1;
              int i = i2 - 2;


              dynamic widget = Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      listRifa = ShopRifasController().addRemoveListRifaNumber(listRifa,i);
                      calcRifaPrice = ShopRifasController().calcRifaAccont(_priceRifa, listRifa);
                      refresh();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          color: ShopRifasController().colorController(refresh, i, listRifa),
                          width: BuildWidgets().getSize(context).width * 0.2,
                          height: BuildWidgets().getSize(context).width * 0.1,
                          child: Center(
                            child: BuildWidgets().buildTextFont(context, 15,
                                FontWeight.w500, "$i", Colors.white),
                          )),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      listRifa = ShopRifasController().addRemoveListRifaNumber(listRifa,i1);
                      calcRifaPrice = ShopRifasController().calcRifaAccont(_priceRifa, listRifa);
                      refresh();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          color: ShopRifasController().colorController(refresh, i1, listRifa),
                          width: BuildWidgets().getSize(context).width * 0.2,
                          height: BuildWidgets().getSize(context).width * 0.1,
                          child: Center(
                            child: BuildWidgets().buildTextFont(context, 15,
                                FontWeight.w500, "$i1", Colors.white),
                          )),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      listRifa = ShopRifasController().addRemoveListRifaNumber(listRifa,i2);
                      calcRifaPrice = ShopRifasController().calcRifaAccont(_priceRifa, listRifa);
                      refresh();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          color: ShopRifasController().colorController(refresh, i2, listRifa),
                          width: BuildWidgets().getSize(context).width * 0.2,
                          height: BuildWidgets().getSize(context).width * 0.1,
                          child: Center(
                            child: BuildWidgets().buildTextFont(context, 15,
                                FontWeight.w500, "$i2", Colors.white),
                          )),
                    ),
                  )
                ],
              );
              return widget;
            },
          ))
        ],
      ),
    );
  }
}