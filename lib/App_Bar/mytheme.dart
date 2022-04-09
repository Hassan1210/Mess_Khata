import 'package:flutter/material.dart';
// ignore_for_file: prefer_const_constructors
import 'package:mess_khata/constant.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeMode theme = ThemeMode.dark;
  bool get isLight => theme == ThemeMode.dark;

  update(isOn){
    theme = isOn? ThemeMode.light:ThemeMode.dark;
    notifyListeners();
  }

}

class MyTheme{
  static final themeDark = ThemeData(
    scaffoldBackgroundColor: darkScaffoldBackgroundColor,
    primaryColor: darkPrimaryColor,
    iconTheme: IconThemeData(
      color: lightPrimaryColor,
    ),
      dividerColor: Colors.grey[400],

  );
  static final themeLight = ThemeData(
    scaffoldBackgroundColor: lightScaffoldBackgroundColor,
    primaryColor: lightPrimaryColor,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    dividerColor: Colors.grey[400],
  );
}