import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:tastytakeout_user_app/views/screens/food_detail_screen.dart';
import '../../models/DTO/FoodModel.dart';
import '../../helper/format_helper.dart' as formatHelper;

class FoodItemWidget extends StatelessWidget {
  final FoodModel food;

  FoodItemWidget({
    required this.food,
  });

  // https://img.freepik.com/free-photo/abstract-surface-textures-white-concrete-stone-wall_74190-8189.jpg

  @override
  Widget build(BuildContext context) {
    String imageUrl = food.imageUrls.isNotEmpty
        ? food.imageUrls[0]
        : 'Error';
    String name = food.name;
    String quantityText = ' Số lượng: ' + food.quantity.toString();
    String cost = formatHelper.formatMoney(food.price);

    return Container(
        padding: EdgeInsets.symmetric(vertical: 12.0),
        child: GestureDetector(
          onTap: () {
            Get.to(() => FoodDetailScreen(foodId: food.id));
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(4),
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
                        fontSize: 22.0,
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
                    RatingBarIndicator(
                      itemBuilder: (context, index) =>
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                      itemCount: 5,
                      itemSize: 16,
                      rating: food.rating.toDouble(),
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
                      )
                    ),
                  ],
                ),
              )
            ],
          ),
        )
    );

    // return GestureDetector(
    //   child: Card(
    //       elevation: 4.0,
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(12.0),
    //       ),
    //       color: Colors.green[100],
    //       child: Container(
    //         child: Row(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Expanded(
    //               child: Padding(
    //                 padding: const EdgeInsets.all(12.0),
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     RichText(
    //                       text: TextSpan(
    //                         children: [
    //                           TextSpan(
    //                             text: name,
    //                             style: TextStyle(
    //                               fontWeight: FontWeight.bold,
    //                               fontSize: 16.0,
    //                               color: Colors.black, // Adjust color as needed
    //                             ),
    //                           ),
    //                           TextSpan(
    //                             text: quantityText, // Display quantity here
    //                             style: TextStyle(
    //                               fontWeight: FontWeight.bold,
    //                               fontSize: 16.0,
    //                               color: Colors.green, // Adjust color as needed
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                     SizedBox(height: 8.0),
    //                     Text(
    //                       cost, // Display cost here
    //                       style: TextStyle(
    //                         color: Colors.black87, // Adjust color as needed
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //             // Right side with an image
    //             Container(
    //               width: 80.0,
    //               height: 80.0,
    //               decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.only(
    //                   topRight: Radius.circular(12.0),
    //                   bottomRight: Radius.circular(12.0),
    //                 ),
    //                 image: DecorationImage(
    //                     image: NetworkImage(imageUrl), fit: BoxFit.cover),
    //               ),
    //             ),
    //           ],
    //         ),
    //       )),
    // );
  }
}
