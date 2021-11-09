import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vexa_rifas/controller/BuildWidgets.dart';
import 'package:vexa_rifas/controller/DataLocal.dart';
import 'package:vexa_rifas/controller/RealTimeFireBase.dart';
import 'package:vexa_rifas/controller/Routes.dart';
import 'package:vexa_rifas/controller/ultis.dart';
import 'package:vexa_rifas/screens/AccountScreen.dart';
import 'package:vexa_rifas/screens/BuyCreditsScreen.dart';
import 'package:vexa_rifas/screens/LoginScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

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
                onPressed: () {},
                icon: Icon(
                  Icons.home,
                  color: aplicativoCollor,
                )),
            IconButton(
                onPressed: () {
                  Utils()
                      .navigatorToNoReturnNoAnimated(context, AccountScreen());
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
              color: aplicativoCollor,
              height: BuildWidgets().getSize(context).height * 0.12,
              width: BuildWidgets().getSize(context).width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FutureBuilder<String?>(
                    future: DataLocal().readData(),
                    builder: (BuildContext context,
                        AsyncSnapshot<String?> snapshot) {
                      List<Widget> children;
                      if (snapshot.hasData) {
                        return BuildWidgets().buildTextFont(context, 22,
                            FontWeight.w600, "Olá, ${nameController(json.decode(snapshot.data!)[0]["Name"])}", Colors.white);
                      } else if (snapshot.hasError) {
                        AlertsDialogValidate().erroAlert(
                            context, 'Ocorreu um erro, faça login novamente', 1,
                            () {
                          Utils().navigatorToNoReturn(context, LoginScreen());
                        }, "Ir para login", false);
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
                  ),
                  SizedBox(
                height:9,
              ),
                  futureBuilderController(),
                  // BuildWidgets().buildTextField(
                  //     "Pesquise aqui",
                  //     false,
                  //     Icons.search_outlined,
                  //     context,
                  //     0.7,
                  //     _searchontroller,
                  //     Colors.transparent,
                  //     2,
                  //     false)
                ],
              )),
          Expanded(
            child: FutureBuilder<Map>(
              future: RealTimeFireBase()
                  .getData(), // a previously-obtained Future<String> or null
              builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
                List<Widget> children;
                if (snapshot.hasData) {
                  return new ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      if (snapshot.data!["${index}produtoRifa"]["exibir"] ==
                          true) {
                        return Column(
                          children: [
                            BuildWidgets().buildRifasShop(
                                context,
                                snapshot.data!["${index}produtoRifa"]
                                    ["nomeFantasia"],
                                snapshot.data!["${index}produtoRifa"]
                                        ["precoRifas"]
                                    .toDouble(),
                                snapshot.data!["${index}produtoRifa"]["url"],
                                snapshot.data!["${index}produtoRifa"]
                                    ["quantidadeRifas"],
                                index,
                                snapshot.data!["${index}produtoRifa"]
                                    ["desc"])
                          ],
                        );
                      } else {
                        return SizedBox();
                      }
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
                    SizedBox(
                      child: CircularProgressIndicator(
                        color: aplicativoCollor,
                      ),
                      width: 60,
                      height: 60,
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
            ),
          )
        ],
      ),
    );
  }
}


String nameController(nome) {
  if (nome.length >=13) {
    return '${nome.substring(0,13)}...';
  }else{
    return nome;
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
              return BuildWidgets().buildTextFont(context, 16, FontWeight.w500,
                  "Você possue ∆ ${snapshot.data!["creditos"].toString()} Créditos", Colors.white);
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
