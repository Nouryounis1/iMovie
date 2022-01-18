import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData darkTheme = ThemeData(
    fontFamily: 'Jannah',
    scaffoldBackgroundColor: HexColor('030002'),
    primaryColor: Colors.white,
    appBarTheme: AppBarTheme(
      titleSpacing: 20.0,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      backgroundColor: HexColor('030002'),
      elevation: 0.0,
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: const TextStyle(
          color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        elevation: 20.0,
        unselectedItemColor: Colors.grey,
        backgroundColor: HexColor('131517')),
    textTheme: const TextTheme(
        bodyText1: TextStyle(
            fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white)));
