import 'package:flutter/material.dart';
import 'package:vexa_rifas/controller/BuildWidgets.dart';
import 'package:vexa_rifas/controller/RealTimeFireBase.dart';
import 'package:vexa_rifas/controller/Routes.dart';
import 'package:vexa_rifas/controller/ultis.dart';
import 'package:vexa_rifas/screens/ConfigScreen.dart';
import 'package:vexa_rifas/screens/CreateRifaScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchontroller = TextEditingController();

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
          Utils().navigatorToNoReturnNoAnimated(context, CreateRifaScreen());
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
                      .navigatorToNoReturnNoAnimated(context, ConfigScreen());
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
              height: BuildWidgets().getSize(context).height * 0.15,
              width: BuildWidgets().getSize(context).width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BuildWidgets().buildTextFont(context, 22, FontWeight.w600,
                      "Olá, Diego Daniel", Colors.white),
                  BuildWidgets().buildTextField(
                      "Pesquise aqui",
                      false,
                      Icons.search_outlined,
                      context,
                      0.7,
                      _searchontroller,
                      Colors.transparent,
                      2)
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
                if (snapshot.data!["${index}produtoRifa"]["exibir"] == true) {
                  return Column(
                  children: [
                    BuildWidgets().buildRifasShop(context, snapshot.data!["${index}produtoRifa"]["nomeFantasia"], snapshot.data!["${index}produtoRifa"]["precoRifas"].toDouble() ,snapshot.data!["${index}produtoRifa"]["url"], snapshot.data!["${index}produtoRifa"]["quantidadeRifas"], index)
                  ],
                );
                }else{
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
