import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pix_flutter/pix_flutter.dart';
import 'package:vexa_rifas/controller/BuildWidgets.dart';
import 'package:vexa_rifas/controller/MercadoPagoController.dart';
import 'package:vexa_rifas/controller/Routes.dart';

// ignore: must_be_immutable
class SelectCreditsScreen extends StatefulWidget {
  // const SelectCreditsScreen({ Key key }) : super(key: key);
  
  String email;
  String tipo;
  SelectCreditsScreen(this.email, this.tipo);

  @override
  _SelectCreditsScreenState createState() => _SelectCreditsScreenState();
}

class _SelectCreditsScreenState extends State<SelectCreditsScreen> {
  List numberAsList = [];

  String money = '0';

  PixFlutter pixFlutter = PixFlutter(
      api: Api(
          baseUrl: 'SEU_BASE_URL',
          authUrl: 'SEU_AUTH_URL',
          certificate: 'SEU_CODIGO_BASIC',
          appKey: 'SEU_APP_KEY',
          permissions: [], // Lista das permissoes, use PixPermissions,
          isBancoDoBrasil: false // Use true se estiver usando API do BB,
          // Se voce estiver usando um certificado P12, utilize desta forma:
          // certificatePath:
          // e inclua o destino pishara o arquivo ;)
          ),

      // Essas informações a seguir somente são necessárias se você deseja utilizar o QR Code Estático
      payload: Payload(
          pixKey: '81995076740',
          /// Há um erro no API que impede o uso de descrição, ela não será inserida. Assim que o bug for consertado, o código voltará ao funcionamento completo.
          description: 'DESCRIÇÃO_DA_COMPRA',
          merchantName: 'MERCHANT_NAME',
          merchantCity: 'CITY_NAME',
          txid: 'TXID', // Até 25 caracteres para o QR Code estático
          amount: '2'));

  
  @override
  Widget build(BuildContext context) {

  
    
    return Scaffold(
      appBar: appBar(),
      backgroundColor: aplicativoCollor,
      body: body(widget.email, widget.tipo),
    );
  }

  PreferredSizeWidget? appBar() {
    return AppBar(
      leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios)),
      elevation: 0,
      title: Text("Compras de Créditos"),
      backgroundColor: aplicativoCollor,
    );
  }

  Widget body(email, tipo) {
    return Column(
      children: [
        userTile(email, tipo),
        moneyWidget(),
        keypadWidget(),
        button(email),
      ],
    );
  }

  Widget userTile(email, tipo) {

    return ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_bag, color: Colors.white, size: 25),
        ],
      ),
      title: BuildWidgets().buildTextFont(context, 13, FontWeight.w700,
          email, Colors.white),
      subtitle: BuildWidgets().buildTextFont(
          context, 12, FontWeight.w700, tipo, Colors.white),
      // trailing: IconButton(
      //   icon: Icon(Icons.arrow_forward_ios,color: Colors.white, size: 18),
      //   onPressed: (){

      //   }
      // ),
    );
  }

  Widget moneyWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 28),
      child: RichText(
//$
          text: TextSpan(
        text: 'R\$',
        style: TextStyle(
          fontSize: 60,
          color: Colors.grey.withOpacity(0.5),
          fontWeight: FontWeight.w300,
        ),
        children: [
//20
          TextSpan(
            text: money,
            style: TextStyle(
              fontSize: 60,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
//.0
          if (money != '')
            TextSpan(
                text: ',00',
                style: TextStyle(
                  fontSize: 60,
                  color: Colors.grey.withOpacity(0.5),
                  fontWeight: FontWeight.w300,
                )),
        ],
      )),
    );
  }

  Widget keypadWidget() {
    return Flexible(
      child: GridView.builder(
        padding: EdgeInsets.symmetric(
          horizontal: 40,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1.5,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: numbers.length,
        itemBuilder: (BuildContext context, int index) {
          int number = numbers[index];
          if (index == 9) return Container(height: 0, width: 0);
          return InkWell(
            borderRadius: BorderRadius.circular(360),
            onTap: () {
              if (index == 11) {
                try {
                  setState(() => money =
                      money.replaceRange(money.length - 1, money.length, ''));
                  if (money.length == 0) {
                    setState(() => money = "0");
                  }
                } catch (e) {
                  AlertsDialogValidate().erroAlert(
                      context,
                      "Não é permitido um valor abaixo de R\$0,00",
                      5,
                      () {},
                      "Fechar",
                      true);
                }
              } else {
                if (money.length >= 4) {
                  AlertsDialogValidate().erroAlert(
                      context,
                      "Não é permitido valores maiores ou igual a R\$10.000,00",
                      5,
                      () {},
                      "Fechar",
                      true);
                } else {
                  if (money == "0") {
                    setState(() => money = '$number');
                  } else {
                    setState(() => money = '$money$number');
                  }
                }
              }
            },
            child: Container(
              child: index == 11
                  ? Icon(Icons.backspace, color: Colors.white)
                  : BuildWidgets().buildTextFont(context, 22, FontWeight.w500, "$number", Colors.white),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.black38,
                shape: BoxShape.circle,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget button(email) {
    return GestureDetector(
      onTap: () async{
        MercadoPago().getMercadoPago(email, double.parse(money), context);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
        child: Container(
          height: 55,
          width: double.maxFinite,
          alignment: Alignment.center,
          child: BuildWidgets().buildTextFont(context, 15, FontWeight.w600, "Ir para o pagamento", Colors.white),
          decoration: BoxDecoration(
            color: aplicativoCollor600,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  static List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, -1, 0, -1];
}