import 'package:flutter/material.dart';
import '/helper/snackbar_helper.dart' as snackbarHelper;

class FoodItemView extends StatelessWidget {
  final String topText;
  final String bottomText;
  final String imageUrl;
  final int quantity;
  bool isChoose;

  void setChoose(bool value) {
    this.isChoose = value;
  }

  FoodItemView({
    required this.topText,
    required this.quantity,
    required this.bottomText,
    required this.imageUrl,
    this.isChoose = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        this.isChoose = !this.isChoose;
        snackbarHelper.showSnackbar(context, 'You $isChoose on $topText');
      },
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        color: isChoose ? Colors.white : Colors.green[100],
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                            text: topText,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: Colors.black, // Adjust color as needed
                            ),
                          ),
                          TextSpan(
                            text: '  X$quantity', // Display quantity here
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: Colors.green, // Adjust color as needed
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      bottomText,
                      style: TextStyle(
                        color: Colors.black87, // Adjust color as needed
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Right side with an image
            Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12.0),
                  bottomRight: Radius.circular(12.0),
                ),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
