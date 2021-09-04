import 'package:http/http.dart' as http;
import 'package:vexa_rifas/controller/Routes.dart';
import 'dart:convert';

class RegisterController {
  registerFireBaseUser(String email, String password, String firstName,
      String lastname, String Number) async {
    http.Response response = await http.post(Uri.parse(RegisterLink),
        body: json.encode({
          "email": email,
          "password": password,
          "returnSecureToken": true,
          "firstName": firstName,
          "lastName": lastname,
          "fullName": "$firstName $lastname",
          "federatedId": Number
        }));
    return json.decode(response.body);
  }

  loginFireBaseUser(String email, String password) async {
    http.Response response = await http.post(Uri.parse(LoginLink),
        body: json.encode(
            {"email": email, "password": password, "returnSecureToken": true}));
    return json.decode(response.body);
  }
  verifyEmailFireBaseUser(String idToken) async{
    http.Response response = await http.post(Uri.parse(verifyEmailLink),
        body: json.encode(
            {"idToken":idToken, "requestType":"VERIFY_EMAIL"}));
    return json.decode(response.body);
  }
  confirmVerifyEmailFireBaseUser(String idToken) async{
    http.Response response = await http.post(Uri.parse(confirmVerifyEmailLink),
        body: json.encode(
            {"oobCode":""}));
    return json.decode(response.body);
  }
  getUserFireBase(String idTtoken) async{
    http.Response response = await http.post(Uri.parse(getUserlINK),
        body: json.encode(
            {"idToken": idTtoken}));
    return json.decode(response.body);
  }
}
