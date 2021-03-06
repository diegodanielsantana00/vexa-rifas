import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:vexa_rifas/controller/BuildWidgets.dart';
import 'package:vexa_rifas/controller/DataLocal.dart';
import 'package:vexa_rifas/controller/RealTimeFireBase.dart';
import 'package:vexa_rifas/controller/Routes.dart';
import 'package:vexa_rifas/controller/ultis.dart';
import 'package:vexa_rifas/screens/BuyCreditsScreen.dart';
import 'package:vexa_rifas/screens/HelpScreen.dart';
import 'package:vexa_rifas/screens/HistoryBuy.dart';
import 'package:vexa_rifas/screens/HomeScreen.dart';
import 'package:vexa_rifas/screens/LoginScreen.dart';

List dadosLocal = [];
dynamic credit = 1;
int segundsController = 0;

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  void initState() {
    super.initState();

    DataLocal().readData().then((data) async {
      dadosLocal = json.decode(data!);
    }).catchError((data) {
      AlertsDialogValidate()
          .erroAlert(context, 'Ocorreu um erro, faça login novamente', 5, () {
        Utils().navigatorToNoReturn(context, LoginScreen());
      }, "Fechar", true);
    });
    setState(() {});
    // credit = RealTimeFireBase().getDataUser(dadosLocal[0]["Email"]);
  }

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
        onPressed: () {
          Utils().navigatorToNoReturnNoAnimated(context, BuyCreditsScreen());
        },
        backgroundColor: Colors.white,
        child: Icon(
          Icons.add,
          color: Colors.black,
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
                onPressed: () {},
                icon: Icon(
                  Icons.settings,
                  color: aplicativoCollor,
                ))
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
              height: BuildWidgets().getSize(context).height * 0.15,
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
                  Icon(Icons.account_circle_rounded,
                      color: Colors.white, size: 50)
                ],
              )),
          Expanded(
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Container(
                    width: BuildWidgets().getSize(context).width * 0.7,
                    child: Column(
                      children: [
                        Container(
                            height:
                                BuildWidgets().getSize(context).height * 0.15,
                            width: BuildWidgets().getSize(context).width * 0.7,
                            decoration: BoxDecoration(
                              color: aplicativoCollor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BuildWidgets().buildTextFont(
                                        context,
                                        15,
                                        FontWeight.w500,
                                        "Seus Créditos VEXA",
                                        Colors.white),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Row(
                                      children: [
                                        futureBuilderController(),
                                        BuildWidgets().buildTextFont(
                                            context,
                                            16,
                                            FontWeight.w500,
                                            " Creditos",
                                            Colors.white)
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            )),
                        SizedBox(
                          height: 40,
                        ),
                        GestureDetector(
                          onTap: () async {
                            Utils()
                                .navigatorToReturn(context, HistoryBuyOrder());
                          },
                          child: Container(
                              color: Colors.transparent,
                              child: BuildWidgets().buildTopicsConfig(
                                  context,
                                  "Minhas compras",
                                  Icons.shop_2_outlined,
                                  Colors.black)),
                        ),
                        // Container(color: Colors.transparent, child:BuildWidgets().buildTopicsConfig(context,
                        //     "Config. de Conta", Icons.settings, Colors.black)),
                        GestureDetector(
                          onTap: () {
                            Utils().navigatorToReturn(context, HelpScreen());
                          },
                          child: Container(
                              color: Colors.transparent,
                              child: BuildWidgets().buildTopicsConfig(
                                  context,
                                  "Ajuda",
                                  Icons.info_outline_rounded,
                                  Colors.black)),
                        ),
                        GestureDetector(
                          onTap: () async {
                            final file = await DataLocal().getData();
                            await file.delete();
                            dadosLocal = DataLocal().addDadosListLeft(dadosLocal, context);
                            DataLocal().saveData(dadosLocal);
                            Utils().navigatorToNoReturn(context, LoginScreen());
                          },
                          child: Container(
                              color: Colors.transparent,
                              child: BuildWidgets().buildTopicsConfig(context,
                                  "Sair da conta", Icons.logout, Colors.red)),
                        ),
                      ],
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget futureBuilderController() {
  return FutureBuilder<String?>(
    future: DataLocal().readData(),
    builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
      List<Widget> children;
      if (snapshot.hasData) {
        return FutureBuilder<Map>(
          future: RealTimeFireBase()
              .getDataUser(json.decode(snapshot.data!)[0]["Email"]),
          builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
            List<Widget> children;
            if (snapshot.hasData) {
              return BuildWidgets().buildTextFont(context, 28, FontWeight.w500,
                  "∆ ${snapshot.data!["creditos"].toString()}", Colors.white);
            } else if (snapshot.hasError) {
              return Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 20,
              );
            } else {
              children = <Widget>[
                Container(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
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
      } else if (snapshot.hasError) {
        return Icon(
          Icons.error_outline,
          color: Colors.red,
          size: 20,
        );
      } else {
        children = <Widget>[
          Container(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
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
