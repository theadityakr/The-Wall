import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  final String text,user,time;
  const Comment({super.key,required this.text,required this.user,required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(text),

          Row(
            children: [
              Text(user),
              Text('*'),
              Text(time)
            ],
          )
        ],
      ),
    );
  }
}