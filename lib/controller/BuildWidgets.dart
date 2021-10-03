import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vexa_rifas/controller/Routes.dart';
import 'package:vexa_rifas/controller/ultis.dart';
import 'package:vexa_rifas/screens/RifasScreen.dart';

class BuildWidgets {
  Size getSize(context) {
    return MediaQuery.of(context).size;
  }

  buildButton(BuildContext context, String text, dynamic ontap,
      bool awaitValidation) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: getSize(context).width * 0.6,
      // ignore: deprecated_member_use
      child: FlatButton(
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          color: AplicativoCollor600,
          onPressed: ontap,
          child: buildAwaitValidation(awaitValidation, text, context)),
    );
  }

  Widget buildTextField(
      String type,
      bool obscure,
      dynamic icon,
      dynamic context,
      double width,
      dynamic controller,
      dynamic colorBorder,
      double verticalHeigth) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: verticalHeigth),
      width: getSize(context).width * width,
      decoration: BoxDecoration(
        color: AplicativoCollor50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: colorBorder,
        ),
      ),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        textCapitalization: TextCapitalization.none,
        onChanged: (value) {
          // ignore: invalid_use_of_protected_member
          (context as Element).reassemble();
        },
        enableSuggestions: false,
        autocorrect: false,
        obscureText: obscure,
        autofillHints: [AutofillHints.email],
        cursorColor: AplicativoCollor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: AplicativoCollor,
          ),
          hintText: type,
          border: InputBorder.none,
        ),
        controller: controller,
      ),
    );
  }

  Widget buildTextFieldNoIcon(String type, bool obscure, dynamic context,
      double width, dynamic controller, dynamic colorBorder, double verticalHeight) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: verticalHeight),
      width: getSize(context).width * width,
      decoration: BoxDecoration(
        color: AplicativoCollor50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: colorBorder,
        ),
      ),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        textCapitalization: TextCapitalization.none,
        onChanged: (value) {
          // ignore: invalid_use_of_protected_member
          (context as Element).reassemble();
        },
        enableSuggestions: false,
        autocorrect: false,
        obscureText: obscure,
        autofillHints: [AutofillHints.email],
        cursorColor: AplicativoCollor,
        decoration: InputDecoration(
          hintText: type,
          border: InputBorder.none,
        ),
        controller: controller,
      ),
    );
  }

  Widget buildTextFieldNoIconNoText(
      dynamic size, bool obscure, dynamic context, double width) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      height: 55,
      width: getSize(context).width * width,
      decoration: BoxDecoration(
        color: AplicativoCollor50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        textAlign: TextAlign.center,
        textCapitalization: TextCapitalization.none,
        onChanged: (value) {
          // ignore: invalid_use_of_protected_member
          (context as Element).reassemble();
        },
        enableSuggestions: false,
        autocorrect: false,
        obscureText: obscure,
        cursorColor: AplicativoCollor,
        decoration: InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }

  buildTextFont(dynamic context, double _fontSize, dynamic _fontWeight,
      String text, dynamic colorFont) {
    return Text(
      text,
      style: GoogleFonts.inter(
          textStyle: Theme.of(context).textTheme.headline4,
          fontSize: _fontSize,
          fontWeight: _fontWeight,
          color: colorFont
          // fontStyle: FontStyle.italic,
          ),
    );
  }

  Widget buildRifasShop(
      dynamic context, String name, dynamic priceRifas, String url) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: GestureDetector(
        onTap: (){
          Utils().navigatorToReturn(context, RifasScreen(name));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Container(
                    color: Colors.grey[300],
                    height: getSize(context).width * 0.3,
                    width: getSize(context).width * 0.3,
                    child: Image.network(
                      'https://picsum.photos/250?image=9',
                      height: getSize(context).width * 0.3,
                      width: getSize(context).width * 0.3,
                    ))),
            Container(
              height: getSize(context).width * 0.2,
              width: getSize(context).width * 0.5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  color: Colors.grey[300]),
              child: Column(
                children: [
                  SizedBox(
                    height: 6,
                  ),
                  buildTextFont(context, 17, FontWeight.w500, name, Colors.black),
                  SizedBox(
                    height: 6,
                  ),
                  buildTextFont(context, 12, FontWeight.w500,
                      "Valor da rifa: R\$$priceRifas", Colors.black),
                  SizedBox(
                    height: 2,
                  ),
                  buildTextFont(
                      context, 17, FontWeight.w500, "(BARRA)54%", Colors.black)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildErro(context, size, validation, text) {
    if (validation == false) {
      return Container(
        width: size.width * 0.7,
        height: 20,
        color: Colors.red[800],
        child: Center(
          child: BuildWidgets()
              .buildTextFont(context, 12, FontWeight.w500, text, Colors.white),
        ),
      );
    } else {
      return SizedBox();
    }
  }

  Widget buildAwaitValidation(awaitValidation, text, context) {
    if (awaitValidation == false) {
      return Text(
        text,
        style: TextStyle(color: Colors.white),
      );
    } else {
      return Container(
        height: getSize(context).width * 0.04,
        width: getSize(context).width * 0.04,
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      );
    }
  }

  Widget buildTopicsConfig(context, String type, icon, Color color) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, size: 25, color: color),
                SizedBox(
                  width: 8,
                ),
                BuildWidgets()
                    .buildTextFont(context, 18, FontWeight.w400, type, color)
              ],
            ),
            Icon(Icons.arrow_right_outlined, size: 25)
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Divider(),
      ],
    );
  }
}

class AlertsDialogValidate {
  erroAlert(dynamic context, String errorText) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      animType: AnimType.SCALE,
      headerAnimationLoop: false,
      title: 'Ops...',
      desc: errorText,
      btnOkOnPress: () {},
      // btnOkIcon: Icons.cancel,
      btnOkColor: Colors.red[700],
      autoHide: Duration(seconds: 5),
      btnOkText: 'Fechar',
    )..show();
  }
}
