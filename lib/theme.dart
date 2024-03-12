import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData colorTheme = ThemeData(
      primaryColor: const Color.fromARGB(255, 192, 255, 58),
      cardColor: const Color.fromARGB(255, 39, 39, 39),
      canvasColor: const Color.fromARGB(255, 28, 28, 28),
      disabledColor: Colors.grey.shade900,
      splashColor: Colors.white,
      iconButtonTheme: const IconButtonThemeData(
          style: ButtonStyle(
        fixedSize: MaterialStatePropertyAll(Size(30, 30)),
        iconColor: MaterialStatePropertyAll(Colors.black),
        backgroundColor: MaterialStatePropertyAll(Colors.white),
      ))
      // Add more theme properties here
      );
}
