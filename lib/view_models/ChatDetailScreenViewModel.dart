import 'package:get/get.dart';
import 'package:tastytakeout_user_app/models/dto/ChatModel.dart';

import '../models/dto/MessageModel.dart';

class ChatDetailScreenViewModel extends GetxController {
  var chatMessage = [].obs;

  void getChatMessage(int userID,int buyerID) {
      // Do later
  }

  void getChatMessages(ChatModel chatModel) {
    chatMessage.value = chatModel.messages;
  }

  void addMessage(ChatModel chatModel, MessageModel message) {
    chatMessage.add(message);
    for (int i = 0; i < chatModel.messages.length; i++) {
      print(chatModel.messages[i].message);
    }
  }
}

