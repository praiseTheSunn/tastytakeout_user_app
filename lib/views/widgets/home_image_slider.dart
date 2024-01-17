//
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:tastytakeout_user_app/view_models/MainHomeViewModel.dart';
// import 'package:tastytakeout_user_app/views/screens/advertisement_screen.dart';
//
// class ImageSliderWidget extends StatefulWidget {
//   final List<String> images;
//
//   ImageSliderWidget({required this.images});
//
//   @override
//   _ImageSliderWidgetState createState() => _ImageSliderWidgetState();
// }
//
// class _ImageSliderWidgetState extends State<ImageSliderWidget> {
//   int currentIndex = 0; // Track the current index
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         // Pass the image URL to AdvertisementPage when the image is pressed
//         Get.to(() => AdvertisementPage(imageUrl: widget.images[currentIndex]));
//       },
//       child: PageView.builder(
//         itemCount: widget.images.length,
//         onPageChanged: (index) {
//           setState(() {
//             currentIndex = index; // Update the current index
//           });
//         },
//         itemBuilder: (context, index) {
//           return Container(
//             child: Image.network(
//               widget.images[index],
//               fit: BoxFit.cover,
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
