// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:apps4rent/components/button.dart';
import 'package:apps4rent/components/text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

 final emailTextController = TextEditingController();
 final passwordTextController = TextEditingController();

 final confirmPasswordTextController = TextEditingController();
  void displayMessage(String Message){
      showDialog(context: context, builder: (context) => AlertDialog(title: Text(Message),));
  }
 void signUp() async {

  if(passwordTextController.text!= confirmPasswordTextController.text){
    Navigator.pop(context);
    displayMessage("Password don't Match!");
    return;
 }

 try{
  UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailTextController.text, password: passwordTextController.text);
  if(context.mounted) Navigator.pop(context);

  FirebaseFirestore.instance
      .collection('Users')
      .doc(userCredential.user!.email)
      .set({
        'username' : emailTextController.text.split('@')[0],
        'bio': 'Empty Bio....'
      });
 }


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
                const Text("Lets create an account for you!"),
                const SizedBox(height: 50),
                MyTextField(controller: emailTextController,hintText: 'Email',obscureText:false),

                const SizedBox(height: 10),
                MyTextField(controller: passwordTextController,hintText: 'Password',obscureText:true),
                const SizedBox(height: 10),
                MyTextField(controller: confirmPasswordTextController,hintText: 'Confirm Password',obscureText:true),

                const SizedBox(height: 20),

                MyButton(
                  onTap: signUp,
                  text: 'Sign Up',
                  ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already a Member? ",style: TextStyle(color: Colors.grey[700]),),
                    

                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                      "Sign In",
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