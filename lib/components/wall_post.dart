// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:html';
import 'dart:js_interop_unsafe';

import 'package:apps4rent/components/comment_button.dart';
import 'package:apps4rent/components/like_button.dart';
import 'package:apps4rent/helper/helper_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class WallPost extends StatefulWidget {

  final String message,user,time,postId;
  final List<String> likes;
  const WallPost({super.key, required this.message, required this.time, required this.user, required this.likes, required this.postId});

  @override
  State<WallPost> createState() => _WallPostState();
}

class _WallPostState extends State<WallPost> {
  final currenUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;
  final commentTextController = TextEditingController();

  @override
  void initState(){
    super.initState();
    isLiked = widget.likes.contains(currenUser.email);
  }


  void toggleLike(){

    
    setState(() {
      isLiked = !isLiked;
    });

    DocumentReference postRef = FirebaseFirestore.instance.collection('User Posts').doc(widget.postId);
    if(isLiked)
      postRef.update({
        'Likes':FieldValue.arrayUnion([currenUser.email])
        });
    else 
      postRef.update({
        'Likes':FieldValue.arrayRemove([currenUser.email])
        });

  }

  void addComment(String commentText){
    FirebaseFirestore.instance
    .collection('User Posts')
    .doc(widget.postId)
    .collection('Comments')
    .add({
      'CommentText': commentText,
      'CommentedBy': currenUser.email,
      'CommentedTime': Timestamp.now()
    });
  }


  void showCommentDialog(){
    showDialog(
      context: context,
      builder: (context)=> AlertDialog(
        title: Text('Add Comment'),
        content: TextFormField(
          controller: commentTextController,
          decoration: InputDecoration(hintText: 'Write a Comment...'),
        ),
          actions: [
            TextButton(
              onPressed: () {
              Navigator.pop(context);
              commentTextController.clear();
              },
              child: Text('Cancel', style: TextStyle(color: Colors.grey[900]))),
              


             TextButton(
              onPressed: (){
                addComment(commentTextController.text);
                Navigator.pop(context);
              commentTextController.clear();
              } ,
              child: Text('Post', style: TextStyle(color: Colors.grey[900])))           
          ],

      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(

        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(8),
        ),
        margin: EdgeInsets.only(top: 20,left: 25,right: 25),
        padding: EdgeInsets.only(top: 10,bottom:10,left: 18,right: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.grey[400]),
                padding: EdgeInsets.all(10),
                child: const Icon(Icons.person,color: Colors.white,),
                ),
 
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text(widget.user,style: TextStyle(color: Colors.grey[500],fontSize: 12)),
                  const SizedBox(height: 8,),
                  Text(widget.message,style: TextStyle(color: Colors.grey[300],fontSize: 14)),
                  const SizedBox(height: 8,),
                  Text(widget.time,style: TextStyle(color: Colors.blue[500],fontSize: 10)),
                  ]
                ),
              ],
            ),

            Column(
              children: [
                LikeButton(isLiked: isLiked, onTap: toggleLike),
                Text(widget.likes.length.toString(),style: TextStyle(color: Colors.grey[500],fontSize: 10)),

                const SizedBox(height: 5),
                CommentButton(onTap: showCommentDialog),
                Text('0',style: TextStyle(color: Colors.grey[500],fontSize: 10))
              ],
            ),
            
          ],
        ),




      );
  }
}