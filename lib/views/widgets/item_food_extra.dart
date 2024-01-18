import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  final String foodName;
  final String price;
  final String distance;
  final String shopName;
  final String imagePath;

  const FoodCard({
    required this.foodName,
    required this.price,
    required this.shopName,
    required this.imagePath,
    this.distance = '',
    required Null Function() onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 255, 255, 255),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    foodName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '$price ₫${distance.isNotEmpty ? ' | $distance' : ''}',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    shopName,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              imagePath,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'lib/resources/tasty_takeout_icon.png',
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}
