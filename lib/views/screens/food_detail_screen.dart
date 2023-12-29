import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:tastytakeout_user_app/views/screens/store_infomation_screen.dart';

class FoodDetailScreen extends StatelessWidget {
  const FoodDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chi tiết sản phẩm"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.all(0),
                child: CarouselSlider(
                  items: [1, 2, 3, 4, 5].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: 200,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          margin: EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 5.0),
                          child: Image.asset('lib/resources/food2.jpg',
                              fit: BoxFit.fill),
                        );
                      },
                    );
                  }).toList(),
                  options: CarouselOptions(
                    height: 200,
                    enlargeCenterPage: true,
                    viewportFraction: 1.0,
                    aspectRatio: 1.0,
                    autoPlay: true,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Cappuccino',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    Text('58,000đ',
                        style: TextStyle(fontSize: 24, color: Colors.grey)),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: IconButton(
                        icon: Icon(Icons.favorite_outline),
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                        iconSize: 24,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: IconButton(
                        icon: Icon(Icons.shopping_cart),
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                        iconSize: 24,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: RatingBar.builder(
                itemSize: 30,
                itemBuilder: (context, _) => Icon(
                  size: 27,
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {},
              ),
            ),
            SizedBox(height: 12.0),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Image.asset(
                    'lib/resources/user_image1.png',
                    height: 50,
                    width: 50,
                  ),
                ), // Logo của nhà cung cấp
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Lowland Coffee', style: TextStyle(fontSize: 16)),
                    GestureDetector(
                      child: Text(
                        'Xem thêm',
                        style: TextStyle(
                            fontSize: 16, decoration: TextDecoration.underline),
                      ),
                      onTap: () {
                        Get.to(StoreInfomationScreen());
                      },
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Mô tả sản phẩm ở đây...'),
            ),
          ],
        ),
      ),
    );
  }
}
