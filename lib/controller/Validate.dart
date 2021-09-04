import 'package:flutter/material.dart';

Color emailValidate(String email, context) {
  if (email == "") {
    return Colors.transparent;
  } else {
    if (email.indexOf('@') >= 0 &&
        email.indexOf('.') >= 0 &&
        email.indexOf(' ') == -1) {
      return Colors.transparent;
    } else {
      return Colors.red;
    }
  }
}

Color passwordValidate(String password, String password2, context) {
  if (password2 == "") {
    return Colors.transparent;
  }
  if (password == password2) {
    if (password.length >= 6) {
      return Colors.transparent;
    } else {
      return Colors.red;
    }
  } else {
    return Colors.red;
  }
}
