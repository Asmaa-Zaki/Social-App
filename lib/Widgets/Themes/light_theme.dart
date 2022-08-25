import 'package:flutter/material.dart';

import '../../ViewModels/Constants/constants.dart';

lightTheme() {
  return ThemeData(
      bottomNavigationBarTheme:
          BottomNavigationBarThemeData(selectedItemColor: Colors.blueGrey[700]),
      primarySwatch: Colors.blueGrey,
      primaryColor: firstDefaultColor,
      appBarTheme: AppBarTheme(backgroundColor: firstDefaultColor));
}
