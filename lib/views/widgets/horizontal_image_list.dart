import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastytakeout_user_app/views/screens/foodpage_screen.dart';

import '../screens/popular_screen.dart';

/// A widget that displays a horizontal list of images.
class HorizontalImageList extends StatelessWidget {
  final RxList<String> images;
  final String title;
  final VoidCallback onPressed;

  HorizontalImageList(
      {required this.title, required this.images, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    // loop through images
    print(title);
    for (var image in images) {
      print(image);
    }
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and view all button
          SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                TextButton(
                  onPressed: onPressed,
                  child: const Text('Xem tất cả'),
                ),
              ],
            ),
          ),

          // Horizontal list of images
          SizedBox(
            height: 100,
            child: Obx(
              () => ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Handle image click here
                      // Example: Navigate to PopularScreen
                      // Get.to(() => FoodPage());
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            child: InteractiveViewer(
                              panEnabled: false,
                              boundaryMargin: EdgeInsets.all(20),
                              minScale: 0.5,
                              maxScale: 4,
                              child: Image.network(
                                  images[index],
                                  fit: BoxFit.cover),
                            ),
                          );
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          images[index],
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
