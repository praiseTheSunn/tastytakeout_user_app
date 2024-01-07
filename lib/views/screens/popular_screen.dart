import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastytakeout_user_app/views/screens/food_detail_screen.dart';
// import 'package:tastytakeout_user_app/viewmodels/popular_screen_viewmodel.dart';
// import 'package:tastytakeout_user_app/views/screens/food_details_screen.dart';
import 'package:tastytakeout_user_app/views/widgets/custom_app_bar.dart';
import 'package:tastytakeout_user_app/views/widgets/item_food_extra.dart';
import 'package:tastytakeout_user_app/view_models/PopularScreenViewModel.dart';

class PopularScreen extends StatefulWidget {
  @override
  _PopularScreenState createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  final PopularScreenViewModel _viewModel = Get.put(PopularScreenViewModel());

  @override
  Widget build(BuildContext context) {
    _viewModel.fetchPopularFood(4);
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Phổ biến',
        // Add necessary onPressed callbacks for the app bar icons
      ), // Replace with your custom app bar implementation
      body: 
      Obx(() =>
        ListView.builder(
          itemCount: _viewModel.foodList.value.length,
          itemBuilder: (context, index) {
            final food = _viewModel.foodList.value[index];
            return InkWell(
              onTap: () {
                              Get.to(FoodDetailScreen());
                            },
              child: FoodCard(
                foodName: food.name,
                // description: food.description,
                imagePath: food.imageUrls[0],
                price: food.price.toString(),
                shopName: food.shopName, // Pass shopName to FoodCard
                onTap: () {
                  print("Tapped on ${food.name}");
                },
              ),
            );
          },
        ),
      )
    );
  }
}

//       body: ListView.builder(
//         itemCount: _viewModel.foodList.length,
//         itemBuilder: (context, index) {
//           final food = _viewModel.foodList[index];
//           return ListTile(
//             title: Text(food.name),
//             subtitle: Text(food.description),
//             onTap: () {
//               print("Tapped on ${food.name}");

//             }
//           );
//         },
//       ),
//     );
//   }
// }
