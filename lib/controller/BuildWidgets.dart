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
      bool awaitValidation, double sizeHorizontal, double horizontal) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: horizontal),
      width: getSize(context).width * sizeHorizontal,
      // ignore: deprecated_member_use
      child: FlatButton(
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          color: aplicativoCollor600,
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
        color: aplicativoCollor50,
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
        cursorColor: aplicativoCollor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: aplicativoCollor,
          ),
          hintText: type,
          border: InputBorder.none,
        ),
        controller: controller,
      ),
    );
  }

  Widget buildTextFieldNoIcon(
      String type,
      bool obscure,
      dynamic context,
      double width,
      dynamic controller,
      dynamic colorBorder,
      double verticalHeight) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: verticalHeight),
      width: getSize(context).width * width,
      decoration: BoxDecoration(
        color: aplicativoCollor50,
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
        cursorColor: aplicativoCollor,
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
        color: aplicativoCollor50,
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
        cursorColor: aplicativoCollor,
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

  Widget buildRifasShop(dynamic context, String name, double priceRifas,
      String url, int countRifas, int idRifa) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: GestureDetector(
        onTap: () {
          Utils().navigatorToReturn(
              context, RifasScreen(name, priceRifas, countRifas, idRifa));
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
                    height: 10,
                  ),
                  buildTextFont(
                      context, 17, FontWeight.w500, name, Colors.black),
                  SizedBox(
                    height: 6,
                  ),
                  buildTextFont(context, 12, FontWeight.w500,
                      "Valor da rifa: ∆ ${Utils().moneyTransform(priceRifas)}", Colors.black),
                  // SizedBox(
                  //   height: 2,
                  // ),
                  // buildTextFont(
                  //     context, 17, FontWeight.w500, "32/100", Colors.black)
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
  erroAlert(dynamic context, String errorText, int autoHide, Function function, String bntText, bool dismissOnTouchOutside1) {
    if (autoHide > 1) {
      return AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.SCALE,
        headerAnimationLoop: false,
        title: 'Ops...',
        desc: errorText,
        btnCancelOnPress: function,
        // btnOkIcon: Icons.cancel,
        btnCancelColor: Colors.red[700],
        autoHide: Duration(seconds: autoHide),
        btnCancelText: bntText,
        dismissOnTouchOutside: dismissOnTouchOutside1
      )..show();
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.SCALE,
        headerAnimationLoop: false,
        title: 'Ops...',
        desc: errorText,
        btnCancelOnPress: function,
        // btnOkIcon: Icons.cancel,
        btnCancelColor: Colors.red[700],
        btnCancelText: bntText,
        dismissOnTouchOutside: dismissOnTouchOutside1
      )..show();
    }
  }

sucessAlert(dynamic context, String errorText, int autoHide, Function function, bool dismissOnTouchOutside1) {
    if (autoHide > 1) {
      return AwesomeDialog(
        context: context,
        dialogType: DialogType.SUCCES,
        animType: AnimType.SCALE,
        headerAnimationLoop: false,
        title: 'SUCESSO!',
        desc: errorText,
        btnOkOnPress: function,
        btnOkIcon: Icons.check_circle_outline,
        btnOkColor: Colors.green[700],
        autoHide: Duration(seconds: autoHide),
        btnOkText: "Ok",
        dismissOnTouchOutside: dismissOnTouchOutside1
      )..show();
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.SUCCES,
        animType: AnimType.SCALE,
        headerAnimationLoop: false,
        title: 'SUCESSO!',
        desc: errorText,
        btnOkOnPress: function,
        btnOkIcon: Icons.check_circle_outline,
        btnOkColor: Colors.green[700],
        btnOkText: "Ok",
        dismissOnTouchOutside: dismissOnTouchOutside1
      )..show();
    }
  }

  infoAlert(dynamic context, String title, String infoText, Function function) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.INFO,
      animType: AnimType.SCALE,
      headerAnimationLoop: false,
      title: title,
      desc: infoText,
      btnCancelColor: Colors.red[700],
      btnCancelOnPress: () {},
      btnOkOnPress: function,
      btnOkColor: Colors.green[700],
      btnOkText: 'Comprar',
    )..show();
  }
}
