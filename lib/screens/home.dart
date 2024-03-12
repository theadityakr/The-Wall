// ignore_for_file: prefer_const_constructors

import 'package:apps4rent/components/drawer.dart';
import 'package:apps4rent/components/text_field.dart';
import 'package:apps4rent/components/wall_post.dart';
import 'package:apps4rent/helper/helper_methods.dart';
import 'package:apps4rent/screens/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final textController = TextEditingController();
  void signOut(){
    FirebaseAuth.instance.signOut();
  }

  void postMessage(){
    if(textController.text.isNotEmpty){
        FirebaseFirestore.instance.collection("User Posts").add({
          'UserEmail':currentUser.email,
          'Message':textController.text,
          'TimeStamp':Timestamp.now(),
          'Likes':[]
        });
    }
    setState(() {
      textController.clear();
    });
  }

  void goToProfilePage(){
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const ProfilePage()));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Center(
          child: Text(
              'The Wall',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16
              ),
            ),
        ),
        actions: [
          IconButton(onPressed: signOut, icon: Icon(Icons.logout),color: Colors.white,),
        ],
      // iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: MyDrawer(
        onProfileTap: goToProfilePage,
        onSignOutTap: signOut,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("User Posts")
                    .orderBy("TimeStamp",descending: false,)
                    .snapshots(),
                builder: (context, snapshot) {
                   if(snapshot.hasData){
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context,index){
                        final post = snapshot.data!.docs[index];
                        return WallPost(
                          message: post['Message'],
                          user: post['UserEmail'],
                          time: formatData(post['TimeStamp']),
                          postId: post.id,
                          likes: List<String>.from(post['Likes'] ?? [])
                          );
                      },
                    );
                    
                   } else if(snapshot.hasError){
                      return Center(
                        child: Text('Error:${snapshot.error}'),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                children: [
                  Expanded(
                    child: MyTextField(
                      controller: textController,
                      hintText: 'Write Something on the Wall..',
                      obscureText: false
                      ),
                  ),

                  IconButton(
                    onPressed: postMessage, 
                    icon: const Icon(Icons.arrow_circle_up),
                    )
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}