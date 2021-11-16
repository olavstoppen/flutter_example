import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData buildTheme() {
    return ThemeData(
      primaryColor: Colors.blue,
      primarySwatch: Colors.blue,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
      )
    );
  }
}

extension ColorUtils on Color {
  MaterialColor toSwatch() {
    final Map<int, Color> swatch = {
      50: Color.fromRGBO(this.red, this.green, this.blue, .1),
      100: Color.fromRGBO(this.red, this.green, this.blue, .2),
      200: Color.fromRGBO(this.red, this.green, this.blue, .3),
      300: Color.fromRGBO(this.red, this.green, this.blue, .4),
      400: Color.fromRGBO(this.red, this.green, this.blue, .5),
      500: Color.fromRGBO(this.red, this.green, this.blue, .6),
      600: Color.fromRGBO(this.red, this.green, this.blue, .7),
      700: Color.fromRGBO(this.red, this.green, this.blue, .8),
      800: Color.fromRGBO(this.red, this.green, this.blue, .9),
      900: Color.fromRGBO(this.red, this.green, this.blue, 1),
    };

    return MaterialColor(this.value, swatch);
  }
}