import 'package:flutter/material.dart';

import '../../../ViewModels/Constants/constants.dart';

darkTheme() {
  return ThemeData(
      primaryColor: firstDefaultColor,
      primarySwatch: Colors.blueGrey,
      appBarTheme: AppBarTheme(backgroundColor: defaultDarkColor, elevation: 1),
      inputDecorationTheme: const InputDecorationTheme(
        iconColor: Colors.white,
        hintStyle: TextStyle(color: Colors.white),
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        labelStyle: TextStyle(color: Colors.white),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: defaultDarkColor,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey.shade700),
      cardColor: defaultDarkColor,
      primaryColorDark: defaultDarkColor,
      scaffoldBackgroundColor: defaultDarkColor,
      iconTheme: const IconThemeData(color: Colors.white),
      textTheme: const TextTheme(
        bodyText1: TextStyle(),
        bodyText2: TextStyle(),
        subtitle1: TextStyle(),
        subtitle2: TextStyle(),
      ).apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
      ));
}
