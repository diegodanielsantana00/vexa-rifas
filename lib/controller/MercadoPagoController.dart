import 'package:mercado_pago_mobile_checkout/mercado_pago_mobile_checkout.dart';
import 'package:mercadopago_sdk/mercadopago_sdk.dart';
import 'package:vexa_rifas/controller/Routes.dart';

class MercadoPago {
  Future<Map<String, dynamic>> getToken(String email, double value) async {
    var mp = MP.fromAccessToken(
        "APP_USR-5019733561106715-080922-51c3e08ae8ac42cbbc2a657c966c7665-621322987");
    var preference = {
      "items": [
        {
          "title": "Compra de Créditos",
          "description": "Vocé solicitou $value créditos vexa que equivale a ${value.toString().replaceAll('.', ',')}0 BRL",
          "quantity": 1,
          "currency_id": "BRL",
          "unit_price": value
        }
      ],
      "payer": {"email": email}
    };

    var result = await mp.createPreference(preference);
    return result;
  }

  Future<void> getMercadoPago(String email, double value) async {
    // ignore: unnecessary_null_comparison
    if (getToken(email, value) != null) {
      getToken(email, value).then((result) async {
        dynamic id = result['response']['id'];
        dynamic result1 = await MercadoPagoMobileCheckout.startCheckout(
          publicKeyMercadoPago,
          id,
        );
        if (result1.status == "approved") {
          print("Aprovaded");
        } else {
          print("Reprovado");
        }
      });
    }
  }
}
