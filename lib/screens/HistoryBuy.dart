import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:vexa_rifas/controller/BuildWidgets.dart';
import 'package:vexa_rifas/controller/DataLocal.dart';
import 'package:vexa_rifas/controller/RealTimeFireBase.dart';
import 'package:vexa_rifas/controller/Routes.dart';
import 'package:vexa_rifas/controller/ultis.dart';

class HistoryBuyOrder extends StatefulWidget {
  const HistoryBuyOrder({Key? key}) : super(key: key);

  @override
  _HistoryBuyOrderState createState() => _HistoryBuyOrderState();
}

class _HistoryBuyOrderState extends State<HistoryBuyOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Utils().navigatorBack(context),
            icon: Icon(Icons.arrow_back_ios_new_outlined)),
        backgroundColor: aplicativoCollor,
        shadowColor: Colors.transparent,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BuildWidgets().buildTextFont(
                context, 15, FontWeight.w700, "Minhas compras", Colors.white)
          ],
        ),
      ),
      backgroundColor: Colors.brown[50],
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<String?>(
              future: DataLocal()
                  .readData(), // a previously-obtained Future<String> or null
              builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
                List<Widget> children;
                if (snapshot.hasData) {
                  return new FutureBuilder<Map>(
                    future: RealTimeFireBase().getDataTrasations(json
                            .decode(snapshot.data!)[0][
                        "Email"]), // a previously-obtained Future<String> or null
                    builder:
                        (BuildContext context, AsyncSnapshot<Map> snapshot2) {
                      List<Widget> children;
                      if (snapshot2.hasData) {
                        return new ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot2.data!.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                historyBuyColumns(context,
                                    snapshot2.data!.values.toList(), index),
                              ],
                            );
                          },
                        );
                      } else if (snapshot2.hasError) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  color: Colors.red,
                                  size: 60,
                                ),
                                BuildWidgets().buildTextFont(
                                    context,
                                    12,
                                    FontWeight.w700,
                                    'Nenhuma registro encontrado',
                                    Colors.black)
                              ],
                            ),
                          ],
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

Widget historyBuyColumns(context, dynamic list, int index) {
  dynamic colorCotroller50 = Colors.red[100];
  dynamic colorCotroller400 = Colors.red;
  String controllerSinal = "-";
  String controllerText = "Compras de Rifas";
  String minute =
      DateTime.parse(list[index]["dataTransacao"]).minute.toString();
  String hour = DateTime.parse(list[index]["dataTransacao"]).hour.toString();
  String day = DateTime.parse(list[index]["dataTransacao"]).day.toString();
  String month = DateTime.parse(list[index]["dataTransacao"]).month.toString();
  String year = DateTime.parse(list[index]["dataTransacao"]).year.toString();

  if (minute.length == 1) {
    minute =
        "0${DateTime.parse(list[index]["dataTransacao"]).minute.toString()}";
  }
  if (hour.length == 1) {
    hour = "0${DateTime.parse(list[index]["dataTransacao"]).hour.toString()}";
  }
  if (day.length == 1) {
    day = "0${DateTime.parse(list[index]["dataTransacao"]).day.toString()}";
  }
  if (month.length == 1) {
    month = "0${DateTime.parse(list[index]["dataTransacao"]).month.toString()}";
  }
  if (year.length == 1) {
    year = "0${DateTime.parse(list[index]["dataTransacao"]).year.toString()}";
  }

  if (list[index]["tipo"] == "UP") {
    colorCotroller50 = Colors.green[100];
    colorCotroller400 = Colors.green[600];
    controllerText = "Compras de créditos";
    controllerSinal = "+";
  }

  return Column(
    children: [
      SizedBox(height: 10),
      Container(
        height: BuildWidgets().getSize(context).width * 0.2,
        width: BuildWidgets().getSize(context).width * 0.8,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: colorCotroller50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BuildWidgets().buildTextFont(
                    context,
                    12,
                    FontWeight.w700,
                    "$controllerSinal${list[index]["valorTotalPago"]} Créditos",
                    colorCotroller400),
              ],
            ),
            SizedBox(
              width: BuildWidgets().getSize(context).width * 0.10,
            ),
            Column(
              children: [
                SizedBox(
                  height: 6,
                ),
                BuildWidgets().buildTextFont(
                    context, 12, FontWeight.w500, controllerText, Colors.black),
                SizedBox(
                  height: 6,
                ),
                BuildWidgets().buildTextFont(context, 12, FontWeight.w500,
                    "$hour:$minute h", Colors.black),
                SizedBox(
                  height: 2,
                ),
                BuildWidgets().buildTextFont(context, 15, FontWeight.w500,
                    "$day/$month/$year", Colors.black)
              ],
            ),
          ],
        ),
      ),
    ],
  );
}
