import 'package:chat_app/themes/dark_mode.dart';
import 'package:chat_app/themes/light_mode.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{
  // At first it will gonna be in light Mode 
  ThemeData _themeData=lightMode;

  //getter
  ThemeData get themedata=>_themeData;

  bool get isDarkMode=>_themeData==darkMode; //for the Cupertino Switch 

  //setter 
  setThemeData(ThemeData themedata){
      _themeData=themedata;
      notifyListeners();
  }

  //toggle Theme 
  void toggleTheme(){
    if(_themeData==lightMode){
      setThemeData(darkMode);
    }
    else{
      setThemeData(lightMode);
    }
  }
}