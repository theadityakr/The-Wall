// ignore_for_file: prefer_const_constructors
import 'package:apps4rent/auth/auth.dart';
import 'package:apps4rent/firebase_options.dart';
import 'package:apps4rent/theme/dark.dart';
import 'package:apps4rent/theme/light.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp ({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: lightTheme,
      darkTheme: darkTheme,
      home: AuthPage(),
    );
  }
}