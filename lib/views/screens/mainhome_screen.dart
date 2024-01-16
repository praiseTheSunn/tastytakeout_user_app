import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tastytakeout_user_app/globals.dart';

import 'package:tastytakeout_user_app/view_models/MainHomeViewModel.dart';
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

class MainHomePage extends StatefulWidget {
  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  final MainHomeViewModel mainHomeViewModel = Get.put(MainHomeViewModel());

  @override
  void initState() {
    super.initState();
    mainHomeViewModel.fetchPopularFoodImagesUrls();
    // fetchData();
  }

  // Future<void> fetchData() async {
  //   try {
  //     await mainHomeViewModel.fetchPopularFoodImagesUrls();
  //   } catch (e) {
  //     // Handle errors or exceptions here
  //     print('Error in fetchData: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // final mainHomeViewModel = Provider.of<MainHomeViewModel>(context);
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
    return Container(
      color: Colors.white,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ImageSliderWidget(images: mainHomeViewModel.images),
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
              images: mainHomeViewModel.images,
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
