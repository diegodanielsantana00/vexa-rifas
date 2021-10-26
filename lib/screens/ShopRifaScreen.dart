import 'package:flutter/material.dart';
import 'package:vexa_rifas/controller/BuildWidgets.dart';
import 'package:vexa_rifas/controller/RealTimeFireBase.dart';
import 'package:vexa_rifas/controller/Routes.dart';
import 'package:vexa_rifas/controller/ShopRifasController.dart';
import 'package:vexa_rifas/controller/ultis.dart';
import 'package:vexa_rifas/screens/AwaitShopBuy.dart';

var listRifa = [];
double calcRifaPrice = 0;
bool controllerConsult = false;
List<dynamic>? controllerConsultlist = [];

class ShopRifaScreen extends StatefulWidget {
  // const ShopRifaScreen({Key? key}) : super(key: key);
  final String nameRifa;
  final int countRifa;
  final double priceRifa;
  final int idRifas;

  ShopRifaScreen(this.nameRifa, this.countRifa, this.priceRifa, this.idRifas);

  @override
  _ShopRifaScreenState createState() => _ShopRifaScreenState();
}

class _ShopRifaScreenState extends State<ShopRifaScreen> {
  void initState() {
    super.initState();
    listRifa = [];
    controllerConsult = false;
    controllerConsultlist = [];
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
              child: BuildWidgets().buildButton(context, "Comprar", () {
                if (calcRifaPrice == 0) {
                  AlertsDialogValidate().erroAlert(
                      context,
                      "Escolha algum número para comprar",
                      5,
                      () {},
                      "Fechar",
                      true);
                } else {
                  AlertsDialogValidate().infoAlert(
                      context,
                      "Confirme seu(s) número(s) abaixo",
                      'Número(s) ${listRifa.toString().replaceAll("[", "(").replaceAll("]", ")")} no valor total de $calcRifaPrice Créditos',
                      () {
                    Utils().navigatorToNoReturn(context,
                        AwaitShopBuy(calcRifaPrice, listRifa, widget.idRifas));
                  });
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
              child: futureBuilderController(
                  widget.idRifas, widget, refresh, _priceRifa))
        ],
      ),
    );
  }
}

Widget futureBuilderController(
    idRifa, dynamic widget, dynamic refresh, dynamic _priceRifa) {
  return FutureBuilder<List?>(
    future: RealTimeFireBase()
        .getRifasBuyForIDRifa(idRifa, controllerConsult, controllerConsultlist),
    builder: (BuildContext context, AsyncSnapshot<List?> snapshot) {
      List<Widget> children;
      if (snapshot.hasData) {
        controllerConsult = true;
        controllerConsultlist = snapshot.data;
        return ListView.builder(
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
                    listRifa = ShopRifasController()
                        .addRemoveListRifaNumber(listRifa, i, snapshot.data);
                    calcRifaPrice = ShopRifasController()
                        .calcRifaAccont(_priceRifa, listRifa);
                    refresh();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: BuildWidgets().getSize(context).width * 0.2,
                        height: BuildWidgets().getSize(context).width * 0.1,
                        decoration: BoxDecoration(
                          color: ShopRifasController().colorController(
                              refresh, i, listRifa, snapshot.data),
                          borderRadius: BorderRadius.all(Radius.circular(60)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 4,
                              blurRadius: 10,
                              offset:
                                  Offset(-1, 2), // changes position of shadow
                            )
                          ],
                        ),
                        child: Center(
                          child: BuildWidgets().buildTextFont(
                              context, 15, FontWeight.w500, "$i", Colors.white),
                        )),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    listRifa = ShopRifasController()
                        .addRemoveListRifaNumber(listRifa, i1, snapshot.data);
                    calcRifaPrice = ShopRifasController()
                        .calcRifaAccont(_priceRifa, listRifa);
                    refresh();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: BuildWidgets().getSize(context).width * 0.2,
                        height: BuildWidgets().getSize(context).width * 0.1,
                        decoration: BoxDecoration(
                          color: ShopRifasController().colorController(
                              refresh, i1, listRifa, snapshot.data),
                          borderRadius: BorderRadius.all(Radius.circular(60)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 4,
                              blurRadius: 10,
                              offset:
                                  Offset(-1, 2), // changes position of shadow
                            )
                          ],
                        ),
                        child: Center(
                          child: BuildWidgets().buildTextFont(context, 15,
                              FontWeight.w500, "$i1", Colors.white),
                        )),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    listRifa = ShopRifasController()
                        .addRemoveListRifaNumber(listRifa, i2, snapshot.data);
                    calcRifaPrice = ShopRifasController()
                        .calcRifaAccont(_priceRifa, listRifa);
                    refresh();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: BuildWidgets().getSize(context).width * 0.2,
                        height: BuildWidgets().getSize(context).width * 0.1,
                        decoration: BoxDecoration(
                          color: ShopRifasController().colorController(
                              refresh, i2, listRifa, snapshot.data),
                          borderRadius: BorderRadius.all(Radius.circular(60)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 4,
                              blurRadius: 10,
                              offset:
                                  Offset(-1, 2), // changes position of shadow
                            )
                          ],
                        ),
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
        );
      } else if (snapshot.hasError) {
        return Icon(
          Icons.error_outline,
          color: Colors.red,
          size: 60,
        );
      } else {
        children = <Widget>[
          Container(
            height: 60,
            width: 60,
            child: CircularProgressIndicator(
              color: aplicativoCollor,
            ),
          )
        ];
      }
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: children,
        ),
      );
    },
  );
}
