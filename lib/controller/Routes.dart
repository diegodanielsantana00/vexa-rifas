import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';


// Colors
// ignore: non_constant_identifier_names
Color AplicativoCollor = HexColor('#8C7018');
// ignore: non_constant_identifier_names
Color AplicativoCollor50 = HexColor('#edddab');
// ignore: non_constant_identifier_names
Color AplicativoCollor600 = HexColor("#3d2f00");


//HTTPS LINKS
const APIRealTime = "https://vexa-rifas-default-rtdb.firebaseio.com/";
const APIKey = "AIzaSyCQUZ_lYfrK0wSVaEZDXycoCK3r5jXi6yk";
const RegisterLink = "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$APIKey";
const LoginLink = "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$APIKey";
const verifyEmailLink = "https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key=$APIKey";
const confirmVerifyEmailLink = "https://identitytoolkit.googleapis.com/v1/accounts:update?key=$APIKey";
const getUserlINK = "https://identitytoolkit.googleapis.com/v1/accounts:lookup?key=$APIKey";

//MENSSAGER

class MessageApp{
  String emailInvalid = "Seu email está inválido";
  String emailInvalidQuestion = "Por favor coloque um email válido";
  String passwordCheck = "A sua senha deve ter pelo menos 6 dígitos";
}