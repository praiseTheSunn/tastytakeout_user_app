import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastytakeout_user_app/globals.dart';
import 'package:tastytakeout_user_app/view_models/MainHomeViewModel.dart';
import 'package:tastytakeout_user_app/views/screens/advertisement_screen.dart';
import 'package:tastytakeout_user_app/views/screens/nearby_screen.dart';
import 'package:tastytakeout_user_app/views/screens/popular_screen.dart';
import 'package:tastytakeout_user_app/views/widgets/custom_app_bar.dart';
import 'package:tastytakeout_user_app/views/widgets/home_image_slider.dart';
import 'package:tastytakeout_user_app/views/widgets/horizontal_image_list.dart';

import '../widgets/custom_drawer.dart';

class MainHomeController extends GetxController {
  final title = 'MainHome'.obs;
}

class MainHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainHomeController());
  }
}

class MainHomePage extends StatelessWidget {
  const MainHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    print('MainHomePage build');
    return Scaffold(
      backgroundColor: mainColor,
      appBar: CustomAppBar(
        title: "Trang chủ",
      ),
      drawer: CustomDrawer(),
      body: Container(
        decoration: BoxDecoration(
          border: Border.fromBorderSide(
            BorderSide(
              color: Colors.grey.shade300,
              width: 0.0,
            ),
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    MainHomeViewModel mainHomeViewModel = Get.put(MainHomeViewModel());
    return Container(
      color: Colors.white,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx( () => Expanded(
              child: Container(
                padding: EdgeInsets.all(0),
                child: CarouselSlider(
                  items: List.generate(
                      mainHomeViewModel.eventImagesUrls.length,
                          (index) => index).map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return GestureDetector(
                          child: Container(
                            width: 400,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            margin: EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 5.0),
                            child: Image.network(
                              mainHomeViewModel.eventImagesUrls[i],
                              fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context, Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                        null
                                        ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                              errorBuilder: (BuildContext context, Object exception,
                                  StackTrace? stackTrace) {
                                return Container(
                                  child: Center(
                                    child: Image.asset('lib/resources/tasty_takeout_icon.png',fit: BoxFit.cover,)
                                  ),
                                );
                              }
                            ),
                          ),
                          onTap: () {
                            Get.to(() => AdvertisementPage(eventModel: mainHomeViewModel.eventInformation[i]));
                          },
                        );
                      },
                    );
                  }).toList(),
                  options: CarouselOptions(
                    height: 400,
                    enlargeCenterPage: true,
                    viewportFraction: 1.0,
                    aspectRatio: 1.0,
                    autoPlay: true,
                  ),
                ),
              ),
            ),
          ),

          /// Renders a list of horizontal image lists.
          /// Each horizontal image list contains a title and a horizontal list of images.
          HorizontalImageList(
              title: "Phổ biến",
              images: mainHomeViewModel.popularFoodImagesUrls,
              onPressed: () {
                // Get.toNamed('/popular');
                Get.to(() => PopularScreen());
              }),
          HorizontalImageList(
              title: "Gần đây",
              images: mainHomeViewModel.popularFoodImagesUrls,
              onPressed: () {
                // Get.toNamed('/nearby');
                Get.to(() => NearbyScreen());
              }),
        ],
      ),
    );
  }
}

// class MainHomePage extends StatelessWidget {
//   // final MainHomeViewModel mainHomeViewModel = MainHomeViewModel();

//   // Future<void> fetchData() async {
//   //   try {
//   //     await mainHomeViewModel.fetchPopularFoodImagesUrls();
//   //   } catch (e) {
//   //     // Handle errors or exceptions here
//   //     print('Error in fetchData: $e');
//   //   }
//   // }

//   // void initState() {
//   //   Provider.of<MainHomeViewModel>(context, listen: false).fetchPopularFoodImagesUrls();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     // fetchData();
//     final mainHomeViewModel = Provider.of<MainHomeViewModel>(context);
//     // mainHomeViewModel.fetchPopularFoodImagesUrls();

//     return Scaffold(
//       appBar: CustomAppBar(
//         title: "Trang chủ",
//       ),
//       drawer: CustomDrawer(),
//       body: Column(
//         // mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: ImageSliderWidget(images: mainHomeViewModel.images),
//             ),
//           ),

//           /// Renders a list of horizontal image lists.
//           /// Each horizontal image list contains a title and a horizontal list of images.
//           HorizontalImageList(title: "Phổ biến", images: mainHomeViewModel.popularFoodImagesUrls, onPressed: () {
//             // Get.toNamed('/popular');
//             Get.to(() => PopularScreen());
//           }),
//           HorizontalImageList(title: "Gần đây", images: mainHomeViewModel.images, onPressed: () {
//             // Get.toNamed('/nearby');
//             Get.to(() => NearbyScreen());
//           }),
//         ],
//       ),
//     );
//   }
// }
