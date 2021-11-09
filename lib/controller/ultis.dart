import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  navigatorToNoReturn(context, dynamic screen) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => screen),
        (Route<dynamic> route) => false);
  }

  navigatorToReturn(context, dynamic screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  navigatorToNoReturnNoAnimated(context, dynamic screen) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => screen,
        transitionDuration: Duration.zero,
      ),
    );
  }

  navigatorBack(context) {
    Navigator.of(context).pop();
  }

  String moneyTransform(dynamic moneyRifa) {
    String money = "$moneyRifa";
    if (money.length == 4) {
      money = "${moneyRifa}0";
    } else if (money.length == 2) {
      money = "$moneyRifa,00";
    } else if (money.length == 1) {
      money = "$moneyRifa,00";
    } else {}
    money = money.replaceAll(".", ",");
    return money;
  }

  Future<void> launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
