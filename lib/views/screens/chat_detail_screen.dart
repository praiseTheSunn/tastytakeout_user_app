import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastytakeout_user_app/view_models/ChatDetailScreenViewModel.dart';
import 'package:tastytakeout_user_app/views/widgets/chat_bubble.dart';

import '../../models/dto/MessageModel.dart';

class ChatDetailScreen extends StatelessWidget {
  ChatDetailScreen({super.key});

  String chatRoomId = '';
  int storeId = 0;
  String storeName = '';
  String storeImage = '';
  late TextEditingController messageController = TextEditingController();
  late ChatDetailScreenViewModel chatDetailScreenViewModel;

  @override
  void dispose() {
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    chatRoomId = args['chat_room_id'];
    storeId = args['store_id'];
    storeName = args['store_name'];
    storeImage = args['store_image_url'];
    chatDetailScreenViewModel = Get.put(ChatDetailScreenViewModel(chatRoomId));
    return Scaffold(
      appBar: AppBar(
        title: Text(storeName, style: TextStyle(color: Colors.black), overflow: TextOverflow.ellipsis,),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: CircleAvatar(
              backgroundImage: NetworkImage(storeImage),
            ),
          )
        ],
      ),
      backgroundColor: Colors.grey.shade200,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Obx(
            () {
              if (chatDetailScreenViewModel.isLoading.value) {
                return Expanded(child: Center(child: CircularProgressIndicator()));
              } else {
                return Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(10),
                    reverse: true,
                    controller: chatDetailScreenViewModel.scrollController,
                    itemCount: chatDetailScreenViewModel.chatMessage.length,
                    itemBuilder: (context, index) {
                      return ChatBubble(
                        messageModel:
                            chatDetailScreenViewModel.chatMessage[index],
                      );
                    },
                  ),
                );
              }
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                border: Border(
                  top: BorderSide(
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
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
                      chatDetailScreenViewModel
                          .sendMessage(messageController.text);
                      messageController.text = '';
                      // chatDetailScreenViewModel.scrollToTop(300);
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
