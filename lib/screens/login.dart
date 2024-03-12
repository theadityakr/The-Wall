// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:apps4rent/components/button.dart';
import 'package:apps4rent/components/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key,required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

 final emailTextController = TextEditingController();
 final passwordTextController = TextEditingController();

  void displayMessage(String Message){
      showDialog(context: context, builder: (context) => AlertDialog(title: Text(Message),));
  }
 void signIn() async {
  showDialog(context: context, builder: (context)=> const Center(child: CircularProgressIndicator(),)) ; 
  
  try{await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailTextController.text, password: passwordTextController.text);
  if(context.mounted) Navigator.pop(context);}
  on FirebaseAuthException catch (e) {
    Navigator.pop(context);
    displayMessage(e.code);
  }
 }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                const  Icon(Icons.lock,size: 100),
                const SizedBox(height: 50),
                const Text("Welcome back, you've been missed!"),
                const SizedBox(height: 50),
                MyTextField(controller: emailTextController,hintText: 'Email',obscureText:false),

                const SizedBox(height: 10),
                MyTextField(controller: passwordTextController,hintText: 'Password',obscureText:true),

                const SizedBox(height: 20),

                MyButton(
                  onTap: signIn,
                  text: 'Sign In',
                  ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Not a Member? ",style: TextStyle(color: Colors.grey[700]),),
                    

                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                      "Register Now",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                      ) 
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}