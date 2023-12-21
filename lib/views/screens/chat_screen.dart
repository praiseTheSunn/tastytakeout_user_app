import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastytakeout_user_app/data_sources/chat_data.dart';
import 'package:tastytakeout_user_app/views/screens/chat_detail_screen.dart';
import 'package:tastytakeout_user_app/views/widgets/chat_items.dart';

import '../../models/dto/ChatModel.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_drawer.dart';

class ChatController extends GetxController {
  final title = 'Chat'.obs;
}

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatController());
  }
}

class ChatPage extends StatelessWidget {
  final List<ChatModel> items = ChatSampleData().getData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'ChatPage',
      ),
      drawer: CustomDrawer(),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              print("Tapped on container $index");
              print(items[index]);
              Get.to(ChatDetailScreen(), arguments: items[index]);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ChatItems(
                UserName: items[index].user_name,
                UserMessage: items[index].messages[0].message,
                UserImage: items[index].user_image,
                UserTime: items[index].messages[0].time,
              ),
            ),
          );
        },
      ),
    );
  }
}
