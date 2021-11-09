import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:vexa_rifas/controller/BuildWidgets.dart';
import 'package:vexa_rifas/controller/DataLocal.dart';
import 'package:vexa_rifas/controller/Routes.dart';
import 'package:vexa_rifas/controller/ultis.dart';
import 'package:vexa_rifas/screens/AccountScreen.dart';
import 'package:vexa_rifas/screens/HomeScreen.dart';
import 'package:vexa_rifas/screens/SelectCreditsScreen.dart';

class BuyCreditsScreen extends StatefulWidget {
  // const BuyCreditsScreen({Key? key}) : super(key: key);

  BuyCreditsScreen();

  @override
  _BuyCreditsScreenState createState() => _BuyCreditsScreenState();
}

class _BuyCreditsScreenState extends State<BuyCreditsScreen> {
  bool awaitValidation = false;

  void initState() {
    super.initState();
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
        onPressed: () {},
        backgroundColor: aplicativoCollor,
        child: Icon(
          Icons.add,
          color: Colors.white,
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
              height: BuildWidgets().getSize(context).height * 0.08,
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
                  BuildWidgets().buildTextFont(context, 20, FontWeight.w700,
                      "Adicionar credito", Colors.white),
                ],
              )),
          futureBuilderController(awaitValidation)
        ],
      ),
    );
  }
}

Widget futureBuilderController(bool awaitValidation) {
  return FutureBuilder<String?>(
    future: DataLocal().readData(),
    builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
      List<Widget> children;
      if (snapshot.hasData) {
        return Expanded(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: BuildWidgets().getSize(context).height * 0.07,
              ),
              BuildWidgets().buildTextFont(context, 14, FontWeight.w600,
                  "Escolha uma das opções de pagamento", Colors.black),
              optionsPayments(context, snapshot, "mercado-pago-logo", "Mercado Pago"),
              // optionsPayments(context, snapshot, "PayPal", "PayPal"),
              // optionsPayments(context, snapshot, "pix", "Pix"),
            ],
          ),
        ));
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

Widget optionsPayments(context, snapshot, String image, String type) {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: GestureDetector(
      onTap: () {
        Utils().navigatorToReturn(context,
            SelectCreditsScreen(json.decode(snapshot.data!)[0]["Email"], type));
      },
      child: Container(
        height: 100,
        width: BuildWidgets().getSize(context).width * 0.7,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(1, 1), // changes position of shadow
            )
          ],
        ),
        child: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: ExactAssetImage('assets/png/$image.png'))),
        ),
      ),
    ),
  );
}
