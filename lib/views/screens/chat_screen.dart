import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'ChatPage',
      ),
      drawer: CustomDrawer(),
      body: Center(
        child: Container(
          child: Text(Get.find<ChatController>().title.value),
        ),
      ),
    );
  }
}
