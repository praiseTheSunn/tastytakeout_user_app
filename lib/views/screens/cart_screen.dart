import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/views/widgets/item_food.dart';
import '/views/screens/foodpage_screen.dart';

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
      //appBar: AppBar(title: Text('Settings')),
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
