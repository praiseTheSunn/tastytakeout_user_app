import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastytakeout_user_app/view_models/MainHomeViewModel.dart';
import 'package:tastytakeout_user_app/views/widgets/custom_app_bar.dart';
import 'package:tastytakeout_user_app/views/widgets/home_image_slider.dart';
import 'package:tastytakeout_user_app/views/widgets/horizontal_image_list.dart';

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

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomAppBar(
            title: 'Trang chủ',
            onMenuPressed: () {
              // Open drawer or perform other actions
            },
            onSearchPressed: () {
              // Perform search function
            },
            onNotificationPressed: () {
              // Perform notification action
            },
            onUserPressed: () {
              // Open user profile or perform other user-related actions
            },
          ),
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
