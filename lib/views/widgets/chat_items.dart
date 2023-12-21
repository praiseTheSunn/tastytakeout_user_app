import 'package:flutter/material.dart';

class ChatItems extends StatelessWidget {
  final String UserName;
  final String UserMessage;
  final String UserImage;
  final String UserTime;

  const ChatItems({super.key,
    required this.UserName,
    required this.UserMessage,
    required this.UserImage,
    required this.UserTime,});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('lib/resources/user_image1.png'),
            maxRadius: 30,
          ),
          SizedBox(width: 16,),
          Expanded(
            child: Container(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(UserName),
                  SizedBox(height: 6,),
                  Text(UserMessage,style: TextStyle(fontSize: 14,color: Colors.grey.shade500),),
                ],
              ),
            ),
          ),
          Text(UserTime,style: TextStyle(fontSize: 12,color: Colors.grey.shade500),),
        ],
      )
    );
  }
}
