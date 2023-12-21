import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastytakeout_user_app/view_models/ListOrdersViewModel.dart';
import 'dart:developer' as developer;
import '../../models/DTO/FoodModel.dart';
import '../../models/DTO/OrderModel.dart';
import '../screens/order_detail_screen.dart';
import '../screens/order_payment_screen.dart';
import 'order_item.dart';

List<RxInt> quantityListObs = <RxInt>[];

void showOrderPreviewBottomSheet(BuildContext context, int index) {
  showModalBottomSheet(
    context: context,
    builder: (context) => OrderPreviewBottomSheet(index: index),
  );
}

class OrderPreviewBottomSheet extends StatelessWidget {
  int index;
  ListOrdersViewModel listOrdersViewModel = Get.find<ListOrdersViewModel>();

  OrderPreviewBottomSheet({required this.index}) {
    if (!quantityListObs.isEmpty) {
      quantityListObs.clear();
    }

    for (var i = 0; i < listOrdersViewModel.cartList[index].foods.length; i++) {
      quantityListObs
          .add(RxInt(listOrdersViewModel.cartList[index].foods[i].quantity));
      print("Quantity: " + quantityListObs[i].value.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: listOrdersViewModel.cartList[index].foods.length,
                itemBuilder: (context, foodIndex) {
                  return Column(
                    children: [
                      FoodItemPreviewWidget(
                        food: listOrdersViewModel
                            .cartList[index].foods[foodIndex],
                        foodIndex: foodIndex,
                      ),
                      SizedBox(height: 20.0),
                    ],
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Row(
            children: [
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  for (var i = 0;
                      i < listOrdersViewModel.cartList[index].foods.length;
                      i++) {
                    listOrdersViewModel.cartList[index].foods[i]
                        .setQuantity(quantityListObs[i].value);
                  }

                  Get.to(() => OrderPaymentPage(index: index));
                  Navigator.pop(context);
                },
                child: Text('Confirm'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FoodItemPreviewWidget extends StatelessWidget {
  late FoodModel food;
  late int foodIndex;

  FoodItemPreviewWidget({
    required this.food,
    required this.foodIndex,
  });

  @override
  Widget build(BuildContext context) {
    String imageUrl = food.imageUrl;
    String name = food.name;
    String quantityText = ' X${food.quantity}';
    String cost = food.price.toString();

    return GestureDetector(
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        color: Colors.green[100],
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  bottomLeft: Radius.circular(12.0),
                ),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Left side with 3 lines of text
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: Colors.black, // Adjust color as needed
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      cost, // Display cost here
                      style: TextStyle(
                        color: Colors.black87, // Adjust color as needed
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Obx(() {
                      return Row(
                        children: [
                          // "-" button to decrease quantity
                          IconButton(
                            onPressed: () {
                              if (quantityListObs[foodIndex].value > 1) {
                                quantityListObs[foodIndex].value--;
                              }
                            },
                            icon: Icon(Icons.remove),
                          ),
                          // Display quantity
                          Text(
                            ' X${quantityListObs[foodIndex].value}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: Colors.green, // Adjust color as needed
                            ),
                          ),
                          // "+" button to increase quantity
                          IconButton(
                            onPressed: () {
                              quantityListObs[foodIndex].value++;
                            },
                            icon: Icon(Icons.add),
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
