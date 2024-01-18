// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:input_quantity/input_quantity.dart';
import '../../models/DTO/FoodModel.dart';
import '../../helper/format_helper.dart' as formatHelper;
import '../screens/food_detail_screen.dart';

class OrderFoodItemWidget extends StatelessWidget {
  final FoodModel food;

  OrderFoodItemWidget({
    required this.food,
  });

  // https://img.freepik.com/free-photo/abstract-surface-textures-white-concrete-stone-wall_74190-8189.jpg

  @override
  Widget build(BuildContext context) {
    String imageUrl = food.imageUrls.isNotEmpty ? food.imageUrls[0] : 'Error';
    String name = food.name;
    String quantityText = 'Số lượng: ' + food.quantity.toString();
    String cost = formatHelper.formatMoney(food.price);
    /*
    * onTap: () {
            Get.to(() => FoodDetailScreen(foodId: food.id));
          },
          * */
    return GestureDetector(
      onTap: () {
        Get.to(() => FoodDetailScreen(foodId: food.id));
      },
      child: Container(
          color: HexColor('#e6e6e6'),
          padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(
                    imageUrl,
                    height: 100,
                    width: 100,
                    errorBuilder: (context, error, stackTrace) {
                      print('Error loading image: $error');
                      return Icon(
                        Icons.error,
                        size: 80,
                      );
                    },
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 8.0),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.black, // Adjust color as needed
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      cost, // Display cost here
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black87, // Adjust color as needed
                      ),
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.grey,
                          ),
                          child: Text(
                            quantityText, // Display quantity here
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: Colors.black, // Adjust color as needed
                            ),
                          ),
                        )),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
