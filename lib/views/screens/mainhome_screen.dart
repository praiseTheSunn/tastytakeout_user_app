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
    final viewModel = MainHomeViewModel();

    return Scaffold(
      appBar: AppBar(title: Text('MainHomePage')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ImageSliderWidget(viewModel: viewModel),
            ),
          ),
        ],
      ),
    );
  }
}

class MainHomeViewModel {
  final List<String> images = [
    'lib/resources/sale1.jpg',
    'lib/resources/sale2.png',
    // Add your image URLs here
  ];
}

class ImageSliderWidget extends StatelessWidget {
  final MainHomeViewModel viewModel;

  ImageSliderWidget({required this.viewModel});

  @override
  Widget build(BuildContext context) {

    return PageView.builder(
      itemCount: viewModel.images.length,
      itemBuilder: (context, index) {
        return Image.asset(
          viewModel.images[index],
          fit: BoxFit.fitWidth,
        );
      },
    );
  }
}
