import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastytakeout_user_app/view_models/ChatDetailScreenViewModel.dart';
import 'package:tastytakeout_user_app/views/widgets/chat_bubble.dart';

import '../../models/dto/ChatModel.dart';
import '../../models/dto/MessageModel.dart';

class ChatDetailScreen extends StatelessWidget {
  ChatDetailScreen({super.key});

  late TextEditingController messageController = TextEditingController();
  final ChatDetailScreenViewModel chatDetailScreenViewModel =
      Get.put(ChatDetailScreenViewModel());

  @override
  void initState() {
    // chatDetailScreenViewModel.getChatMessages();
  }

  @override
  void dispose() {
    messageController.dispose();
    // chatDetailScreenViewModel.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ChatModel chatModel = Get.arguments as ChatModel;
    chatDetailScreenViewModel.getChatMessages(chatModel);
    print("Initial messages");
    for (int i = 0; i < chatModel.messages.length; i++) {
      print(chatModel.messages[i].message);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('ChatDetailScreen'),
      ),
      body: Stack(
        children: [
          Obx(
            () => ListView.builder(
              itemCount: chatDetailScreenViewModel.chatMessage.length,
              itemBuilder: (context, index) {
                return ChatBubble(messageModel: chatDetailScreenViewModel.chatMessage[index]);
              },
            ),
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
                      controller: messageController,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      if (messageController.text.isNotEmpty) {
                        chatDetailScreenViewModel.addMessage(
                          chatModel,
                          MessageModel(
                            message: messageController.text,
                            time: DateTime.now().toString(),
                            sendByMe: true,
                          ),
                        );
                        messageController.clear();
                      }
                    },
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
