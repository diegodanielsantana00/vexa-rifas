import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vexa_rifas/controller/BuildWidgets.dart';
import 'package:vexa_rifas/controller/DataLocal.dart';
import 'package:vexa_rifas/controller/Routes.dart';
import 'package:vexa_rifas/controller/ultis.dart';
import 'package:vexa_rifas/screens/ConfigScreen.dart';
import 'package:vexa_rifas/screens/CreateRifaScreen.dart';
import 'package:vexa_rifas/screens/HomeScreen.dart';

class RealTimeFireBase {
  Future<Map> getData() async {
    http.Response response =
        await http.get(Uri.parse('$APIRealTime/rifas.json'));
    return jsonDecode(response.body);
  }

  Future<Map> getDataUser(String email) async {
    http.Response response = await http.get(Uri.parse(
        '$APIRealTime/users/${email.replaceAll(".", "").replaceAll("_", "").replaceAll("/", "").replaceAll("@", "").replaceAll("\\", "").replaceAll(" ", "")}.json'));
    return jsonDecode(response.body);
  }

  Future<Map> setDadosRegister(
      String emailUser, String numberPhone, String name) async {
    http.Response response2 = await http.patch(
        Uri.parse('$APIRealTime/users/$emailUser.json'),
        body: json.encode({
          "creditos": 0.0,
          "email": emailUser,
          "nome": name,
          "numero": numberPhone
        }));
    return jsonDecode(response2.body);
  }

  Future<List?> getRifasBuyForIDRifa(int idRifa, bool controlerConsult,
      List<dynamic>? controllerConsult) async {
    List<int> rifasShopping = [];
    if (controlerConsult == false) {
      http.Response response = await http
          .get(Uri.parse('$APIRealTime/rifasPagas/${idRifa}produtoRifa.json'));

      try {
        for (var i = 0; i < jsonDecode(response.body).keys.length; i++) {
          switch (
              jsonDecode(response.body).keys.toList()[i].toString().length) {
            case 5:
              rifasShopping.add(int.parse(jsonDecode(response.body)
                  .keys
                  .toList()[i]
                  .toString()
                  .substring(0, 1)));
              break;
            case 6:
              rifasShopping.add(int.parse(jsonDecode(response.body)
                  .keys
                  .toList()[i]
                  .toString()
                  .substring(0, 2)));
              break;
            case 7:
              rifasShopping.add(int.parse(jsonDecode(response.body)
                  .keys
                  .toList()[i]
                  .toString()
                  .substring(0, 3)));
              break;
            case 8:
              rifasShopping.add(int.parse(jsonDecode(response.body)
                  .keys
                  .toList()[i]
                  .toString()
                  .substring(0, 4)));
              break;
            case 9:
              rifasShopping.add(int.parse(jsonDecode(response.body)
                  .keys
                  .toList()[i]
                  .toString()
                  .substring(0, 5)));
              break;
            case 10:
              rifasShopping.add(int.parse(jsonDecode(response.body)
                  .keys
                  .toList()[i]
                  .toString()
                  .substring(0, 6)));
              break;
            case 11:
              rifasShopping.add(int.parse(jsonDecode(response.body)
                  .keys
                  .toList()[i]
                  .toString()
                  .substring(0, 7)));
              break;
            default:
          }
        }
      } catch (e) {}
      return rifasShopping;
    } else {
      return controllerConsult;
    }
  }

  buyCredit(String email, int credit) async {
    dynamic soma;
    http.Response response = await http.get(Uri.parse(
        '$APIRealTime/users/${email.replaceAll(".", "").replaceAll("_", "").replaceAll("/", "").replaceAll("@", "").replaceAll("\\", "").replaceAll(" ", "")}.json'));
    soma = jsonDecode(response.body)["creditos"] + credit;
    await http.patch(
        Uri.parse(
            '$APIRealTime/users/${email.replaceAll(".", "").replaceAll("_", "").replaceAll("/", "").replaceAll("@", "").replaceAll("\\", "").replaceAll(" ", "")}.json'),
        body: json.encode({
          "creditos": soma,
        }));
  }

  buyNumberRifaCredit(double credit, List numberBuy, context, dynamic idRifa) async {
    DataLocal().readData().then((data) async {
      List dadosLocal = json.decode(data!);
      dynamic email = dadosLocal[0]["Email"];
      bool buyController = false;
      bool controllerAprovation = true;
      dynamic subi;

      http.Response response = await http.get(Uri.parse(
          '$APIRealTime/users/${email.replaceAll(".", "").replaceAll("_", "").replaceAll("/", "").replaceAll("@", "").replaceAll("\\", "").replaceAll(" ", "")}.json'));
      subi = jsonDecode(response.body)["creditos"] - credit;
      if (subi < 0) {
        controllerAprovation = false;
      }

      if (controllerAprovation == false) {
        AlertsDialogValidate().erroAlert(context, 'Creditos insuficientes', 0,
            () {
          Utils().navigatorToNoReturn(context, CreateRifaScreen());
        }, "Comprar mais créditos", false);
      } else {
        List<int> rifasShopping = [];

        http.Response response = await http.get(
            Uri.parse('$APIRealTime/rifasPagas/${idRifa}produtoRifa.json'));

        try {
          for (var i = 0; i < jsonDecode(response.body).keys.length; i++) {
            switch (
                jsonDecode(response.body).keys.toList()[i].toString().length) {
              case 5:
                rifasShopping.add(int.parse(jsonDecode(response.body)
                    .keys
                    .toList()[i]
                    .toString()
                    .substring(0, 1)));
                break;
              case 6:
                rifasShopping.add(int.parse(jsonDecode(response.body)
                    .keys
                    .toList()[i]
                    .toString()
                    .substring(0, 2)));
                break;
              case 7:
                rifasShopping.add(int.parse(jsonDecode(response.body)
                    .keys
                    .toList()[i]
                    .toString()
                    .substring(0, 3)));
                break;
              case 8:
                rifasShopping.add(int.parse(jsonDecode(response.body)
                    .keys
                    .toList()[i]
                    .toString()
                    .substring(0, 4)));
                break;
              case 9:
                rifasShopping.add(int.parse(jsonDecode(response.body)
                    .keys
                    .toList()[i]
                    .toString()
                    .substring(0, 5)));
                break;
              case 10:
                rifasShopping.add(int.parse(jsonDecode(response.body)
                    .keys
                    .toList()[i]
                    .toString()
                    .substring(0, 6)));
                break;
              case 11:
                rifasShopping.add(int.parse(jsonDecode(response.body)
                    .keys
                    .toList()[i]
                    .toString()
                    .substring(0, 7)));
                break;
              default:
            }
          }
        } catch (e) {}

        if (rifasShopping.length != 0) {
          for (var i = 0; i < numberBuy.length; i++) {
            for (var l = 0; l < rifasShopping.length; l++) {
              if (numberBuy[i] == rifasShopping[l]) {
                buyController = true;
              }
            }
          }
        }

        if (buyController == false) {
          await http.patch(
              Uri.parse(
                  '$APIRealTime/users/${email.replaceAll(".", "").replaceAll("_", "").replaceAll("/", "").replaceAll("@", "").replaceAll("\\", "").replaceAll(" ", "")}.json'),
              body: json.encode({
                "creditos": subi,
              }));

          for (var i = 0; i < numberBuy.length; i++) {
            await http.patch(
                Uri.parse(
                    '$APIRealTime/rifasPagas/${idRifa}produtoRifa/${numberBuy[i]}Rifa.json'),
                body: json.encode({"email": email, "valorPago": credit}));
          }
          AlertsDialogValidate().sucessAlert(context, 'Números comprados!', 0,
              () {
            Utils().navigatorToNoReturn(context, ConfigScreen());
          }, false);
        } else {
          AlertsDialogValidate().erroAlert(
              context,
              'Por favor tente novamente, Número(s) selecionado(s) já foram comprados',
              0, () {
            Utils().navigatorToNoReturn(context, HomeScreen());
          }, "Ir para o Menu", false);
        }
      }
    }).catchError((data) {
      print(data);
      AlertsDialogValidate().erroAlert(context,
          'Ocorreu algum erro, Tente novamente, se o erro retornar por favor reporte', 0, () {
            Utils().navigatorToNoReturn(context, HomeScreen());
          }, "Fechar", false);
    });
  }
}
