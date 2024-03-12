import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(color: Colors.black , fontSize: 20),

  ),
    colorScheme: ColorScheme.light(
     primary: Colors.grey[300]!, 
    //  onPrimary: onPrimary, 
     secondary: Colors.grey[500]!,  
    //  onSecondary: onSecondary, 
    //  error: error, 
    //  onError: onError, 
     background: Colors.white!, 
    //  onBackground: onBackground, 
    //  surface: surface, 
    //  onSurface: onSurface
     ),
);