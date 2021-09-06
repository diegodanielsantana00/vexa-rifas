import 'package:flutter/material.dart';
import 'package:vexa_rifas/controller/BuildWidgets.dart';
import 'package:vexa_rifas/controller/Routes.dart';
import 'package:vexa_rifas/controller/ultis.dart';
import 'package:vexa_rifas/screens/CreateRifaScreen.dart';
import 'package:vexa_rifas/screens/HomeScreen.dart';

class ConfigScreen extends StatefulWidget {
  const ConfigScreen({Key? key}) : super(key: key);

  @override
  _ConfigScreenState createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
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
        onPressed: () {
          utils().navigatorToNoReturnNoAnimated(context, CreateRifaScreen());
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
                  utils().navigatorToNoReturnNoAnimated(context, HomeScreen());
                },
                icon: Icon(
                  Icons.home,
                  color: Colors.black,
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.settings,
                  color: AplicativoCollor,
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
                  BuildWidgets().buildTextFont(context, 12, FontWeight.w500,
                      "ICONE DE PERFIL", Colors.white),
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
                              color: AplicativoCollor,
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
                                        "Rifas Ativas",
                                        Colors.white),
                                    BuildWidgets().buildTextFont(context, 28,
                                        FontWeight.w500, "12", Colors.white)
                                  ],
                                ),
                                SizedBox(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                  ),
                                  width: 4,
                                  height:
                                      BuildWidgets().getSize(context).height *
                                          0.1,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BuildWidgets().buildTextFont(
                                        context,
                                        15,
                                        FontWeight.w500,
                                        "Rifas Fecha.",
                                        Colors.white),
                                    BuildWidgets().buildTextFont(context, 28,
                                        FontWeight.w500, "28", Colors.white)
                                  ],
                                ),
                              ],
                            )),
                        SizedBox(
                          height: 40,
                        ),
                        BuildWidgets().buildTopicsConfig(
                            context,
                            "Minhas Compras",
                            Icons.shop_2_outlined,
                            Colors.black),
                        BuildWidgets().buildTopicsConfig(context,
                            "Minhas Vendas", Icons.money, Colors.black),
                        BuildWidgets().buildTopicsConfig(context,
                            "Config. de Conta", Icons.settings, Colors.black),
                        BuildWidgets().buildTopicsConfig(
                            context, "Sair da conta", Icons.logout, Colors.red),
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
