
import 'package:flutter/material.dart';
import 'package:vexa_rifas/screens/StartScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: StartScreen(),
  ));
}
