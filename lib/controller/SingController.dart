import 'package:http/http.dart' as http;
import 'package:vexa_rifas/controller/BuildWidgets.dart';
import 'package:vexa_rifas/controller/Routes.dart';
import 'dart:convert';

class RegisterController {
  registerFireBaseUser(String email, String password, String firstName,
      String lastname, String number) async {
    http.Response response = await http.post(Uri.parse(RegisterLink),
        body: json.encode({
          "email": email,
          "password": password,
          "returnSecureToken": true,
          "firstName": firstName,
          "lastName": lastname,
          "fullName": "$firstName $lastname",
          "federatedId": number
        }));
    return json.decode(response.body);
  }

  loginFireBaseUser(String email, String password) async {
    http.Response response = await http.post(Uri.parse(LoginLink),
        body: json.encode(
            {"email": email, "password": password, "returnSecureToken": true}));
    return json.decode(response.body);
  }

  verifyEmailFireBaseUser(String idToken) async {
    http.Response response = await http.post(Uri.parse(verifyEmailLink),
        body: json.encode({"idToken": idToken, "requestType": "VERIFY_EMAIL"}));
    return json.decode(response.body);
  }

  confirmVerifyEmailFireBaseUser(String idToken) async {
    http.Response response = await http.post(Uri.parse(confirmVerifyEmailLink),
        body: json.encode({"oobCode": ""}));
    return json.decode(response.body);
  }

  getUserFireBase(String idTtoken) async {
    http.Response response = await http.post(Uri.parse(getUserlINK),
        body: json.encode({"idToken": idTtoken}));
    return json.decode(response.body);
  }

  resetPassword(String email,context) async {
    http.Response response = await http.post(Uri.parse(resetPasswordLink),
        body: json.encode(
            {"email": email,"requestType":"PASSWORD_RESET"}));

    // print(json.decode(response.body)["error"]["message"]); //INVALID_EMAIL

    try {
      String error = json.decode(response.body)["error"]["message"];
      if (error == "INVALID_EMAIL") {
        AlertsDialogValidate().erroAlert(context, "Algo não deu certo, verifique o email e tente novamente.", 5, (){}, "Ok", true);
      } else if (error == "EMAIL_NOT_FOUND") {
        AlertsDialogValidate().erroAlert(context, "Algo não deu certo, email não encontrado verifique o email e tente novamente.", 5, (){}, "Ok", true);
      } else {
        AlertsDialogValidate().erroAlert(context, "Algo não deu certo, tente novamente", 5, (){}, "Ok", true);
      }
    } catch (e) {
     AlertsDialogValidate().sucessAlert(context, "Email enviado com sucesso, por favor verifique na caixa de entrada do seu e-email", 5, (){}, true);

    }

    return json.decode(response.body);
  }
}
