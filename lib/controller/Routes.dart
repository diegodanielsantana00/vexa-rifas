import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';


// Colors
Color aplicativoCollor = HexColor('#8C7018');
Color aplicativoCollor50 = HexColor('#edddab');
Color aplicativoCollor600 = HexColor("#3d2f00");


//HTTPS LINKS
const APIRealTime = "https://vexa-rifas-default-rtdb.firebaseio.com/";
const APIKey = "AIzaSyCQUZ_lYfrK0wSVaEZDXycoCK3r5jXi6yk";
const RegisterLink = "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$APIKey";
const LoginLink = "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$APIKey";
const verifyEmailLink = "https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key=$APIKey";
const confirmVerifyEmailLink = "https://identitytoolkit.googleapis.com/v1/accounts:update?key=$APIKey";
const getUserlINK = "https://identitytoolkit.googleapis.com/v1/accounts:lookup?key=$APIKey";
const resetPasswordLink = "https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key=$APIKey";
const publicKeyMercadoPago = "APP_USR-6a502659-7c12-4f03-a816-b760b10c3f98";
const preferenceId = "621322987-be4d57cd-2335-4e72-b4b6-6e537984d58f";

//MENSSAGER

class MessageApp{
  String emailInvalid = "Seu email está inválido";
  String emailInvalidQuestion = "Por favor coloque um email válido";
  String passwordCheck = "A sua senha deve ter pelo menos 6 dígitos";
}