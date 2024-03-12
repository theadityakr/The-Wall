import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(color: Colors.white , fontSize: 20),
  ),
  colorScheme: ColorScheme.dark(
     primary: Colors.grey[900]!, 
    //  onPrimary: onPrimary, 
     secondary: Colors.grey[800]!,  
    //  onSecondary: onSecondary, 
    //  error: error, 
    //  onError: onError, 
     background: Colors.black, 
    //  onBackground: onBackground, 
    //  surface: surface, 
    //  onSurface: onSurface
     ),
);