import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vexa_rifas/controller/Routes.dart';

class RealTimeFireBase {
  Future<Map> getData() async {
    http.Response response =
        await http.get(Uri.parse('$APIRealTime/rifas.json'));
    return jsonDecode(response.body);
  }

  Future<Map> setDadosRegister(String emailUser, String numberPhone,String name) async {
  http.Response response2 = await http.patch(Uri.parse('$APIRealTime/users/$emailUser.json'),
      body: json.encode({
        "creditos": 0.0,
        "email": emailUser,
        "nome": name,
        "numero": numberPhone
        })).catchError((onError){print(onError);});
  return jsonDecode(response2.body);
}
}
