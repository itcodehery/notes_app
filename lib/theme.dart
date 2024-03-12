import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData colorTheme = ThemeData(
    fontFamily: 'Jost',
    primaryColor: const Color.fromARGB(255, 192, 255, 58),
    primaryColorDark: const Color.fromARGB(100, 192, 255, 58),
    cardColor: const Color.fromARGB(255, 39, 39, 39),
    canvasColor: const Color.fromARGB(255, 28, 28, 28),
    disabledColor: Colors.grey.shade900,
    splashColor: Colors.white,
    iconButtonTheme: const IconButtonThemeData(
        style: ButtonStyle(
      fixedSize: MaterialStatePropertyAll(Size(30, 30)),
      iconColor: MaterialStatePropertyAll(Colors.black),
      backgroundColor: MaterialStatePropertyAll(Colors.white),
    )),
    dividerColor: Colors.white60,
    // Add more theme properties here
  );
}
