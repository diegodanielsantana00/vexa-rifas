import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vexa_rifas/controller/Routes.dart';

class RealTimeFireBase {

  Future<Map> getData() async {
  http.Response response = await http.get(Uri.parse('$APIRealTime/rifas.json'));
  return jsonDecode(response.body);

}
}