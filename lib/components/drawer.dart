// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:apps4rent/components/list_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  void Function()? onProfileTap;
  void Function()? onSignOutTap;
  MyDrawer({super.key, required this.onProfileTap, required this.onSignOutTap});
  void signOut(){
    FirebaseAuth.instance.signOut();
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[900],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
         Column(
          children: [
            const DrawerHeader(child: Icon(Icons.person,color: Colors.white,size: 64,)),          
      
         MyListTile(icon: Icons.home, text: 'H O M E', onTap: () => Navigator.pop(context)),
         MyListTile(icon: Icons.person_outline, text: 'P R O F I L E', onTap: onProfileTap,),
          ],
         ),
         Padding(
           padding: const EdgeInsets.only(bottom: 25.0),
           child: MyListTile(icon: Icons.logout, text: 'L O G O U T', onTap: onSignOutTap,),
         ),

        ],
      ),
    );
  }
} 