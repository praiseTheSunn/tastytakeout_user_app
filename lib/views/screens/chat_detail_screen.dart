import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastytakeout_user_app/views/widgets/chat_bubble.dart';

import '../../models/dto/ChatModel.dart';

class ChatDetailScreen extends StatelessWidget {
  ChatDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatModel chatModel = Get.arguments as ChatModel;
    return Scaffold(
      appBar: AppBar(
        title: Text('ChatDetailScreen'),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: chatModel.messages.length,
            itemBuilder: (context, index) {
              return ChatBubble(messageModel: chatModel.messages[index]);
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Colors.grey.shade200,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Type a message',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
