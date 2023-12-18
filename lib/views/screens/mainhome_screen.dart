import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastytakeout_user_app/view_models/MainHomeViewModel.dart';
import 'package:tastytakeout_user_app/views/widgets/custom_app_bar.dart';
import 'package:tastytakeout_user_app/views/widgets/home_image_slider.dart';
import 'package:tastytakeout_user_app/views/widgets/horizontal_image_list.dart';

import '../widgets/custom_drawer.dart';

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
    final viewModel = MainHomeViewModel();

    return Scaffold(
      appBar: CustomAppBar(
        title: "Trang chủ",
      ),
      drawer: CustomDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ImageSliderWidget(viewModel: viewModel),
            ),
          ),
          SizedBox(height: 16),
          Container(
            height: 100,
            child: HorizontalImageList(images: viewModel.images),
          ),
          SizedBox(height: 16),
          Container(
            height: 100,
            child: HorizontalImageList(images: viewModel.images),
          ),
        ],
      ),
    );
  }
}
