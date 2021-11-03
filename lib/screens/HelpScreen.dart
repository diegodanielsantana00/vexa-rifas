import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:vexa_rifas/controller/BuildWidgets.dart';
import 'package:vexa_rifas/controller/Routes.dart';
import 'package:vexa_rifas/controller/ultis.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
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
                  context, 15, FontWeight.w700, "Ajuda", Colors.white)
            ],
          ),
        ),
        backgroundColor: Colors.brown[50],
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                topicsHelp(context, 'Email', Icons.mark_email_unread_outlined),
                topicsHelp(context, 'WhatsApp', Icons.message_rounded),
                topicsHelp(context, 'Instagram', Icons.message_rounded),
                topicsHelp(context, 'Celular', Icons.message_rounded),
              ],
            ),
          ),
        ));
  }
}

Widget topicsHelp(context, String type, IconData? icon) {
  return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 50,
        width: BuildWidgets().getSize(context).width * 0.7,
        decoration: BoxDecoration(
          color: aplicativoCollor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Center(
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(icon, color: Colors.white),
            SizedBox(
              width: 10,
            ),
            BuildWidgets().buildTextFont(
                context, 15, FontWeight.w500, type, Colors.white),
          ]),
        ),
      ));
}
