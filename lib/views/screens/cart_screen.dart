import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/custom_drawer.dart';
import '/views/screens/foodpage_screen.dart';
import '/views/widgets/item_food.dart';

class CartController extends GetxController {
  final title = 'Cart'.obs;
}

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CartController());
  }
}

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Cart',
      ),
      drawer: CustomDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text(Get.find<CartController>().title.value),
            ),
            FoodItemView(
                topText: "Food name",
                bottomText: "price",
                quantity: 1,
                imageUrl:
                    "https://images.pexels.com/photos/376464/pexels-photo-376464.jpeg"),
            ElevatedButton(
              child: Text('Cart Flow Page'),
              onPressed: () {
                Get.to(FoodPage());
              },
            ),
          ],
        ),
      ),
    );
  }
}
