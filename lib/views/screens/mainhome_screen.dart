import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainHomeController extends GetxController {
  final title = 'MainHome'.obs;
}

class MainHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainHomeController());
  }
}

class MainHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text('MainHomePage')),
      body: Center(
        child: Container(
          child: Text(Get.find<MainHomeController>().title.value),
        ),
      ),
    );
  }
}
