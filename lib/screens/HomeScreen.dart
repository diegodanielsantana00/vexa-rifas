import 'package:flutter/material.dart';
import 'package:vexa_rifas/controller/BuildWidgets.dart';
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
          child: Icon(Icons.add, color: Colors.black,),
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
                    color: AplicativoCollor,
                  )),
              IconButton(
                  onPressed: () {
                    utils().navigatorToNoReturnNoAnimated(context, ConfigScreen());
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
              color: AplicativoCollor,
              height: BuildWidgets().getSize(context).height*0.15,
              width: BuildWidgets().getSize(context).width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                BuildWidgets().buildTextFont(context, 12, FontWeight.w500, "Olá, Diego Daniel", Colors.white),
              ],)
            ),
            Expanded(child: new ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: 30,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    BuildWidgets().buildRifasShop(context,"",1),
                                  ],
                                );
                              
                              },
                            ),)
          ],
        )
        ,);
  }
}
