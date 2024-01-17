import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastytakeout_user_app/view_models/PopularScreenViewModel.dart';
import 'package:tastytakeout_user_app/views/screens/food_detail_screen.dart';
// import 'package:tastytakeout_user_app/viewmodels/popular_screen_viewmodel.dart';
// import 'package:tastytakeout_user_app/views/screens/food_details_screen.dart';
import 'package:tastytakeout_user_app/views/widgets/custom_app_bar.dart';
import 'package:tastytakeout_user_app/views/widgets/item_food_extra.dart';
import 'package:tastytakeout_user_app/view_models/NearbyScreenViewModel.dart';

class NearbyScreen extends StatefulWidget {
  @override
  _NearbyScreenState createState() => _NearbyScreenState();
}

class _NearbyScreenState extends State<NearbyScreen> {
  late PopularScreenViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = PopularScreenViewModel();
    _viewModel.fetchPopularFood(4);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Gần đây"),
        automaticallyImplyLeading: true,
        centerTitle: true,
        // Add necessary onPressed callbacks for the app bar icons
      ), // Replace with your custom app bar implementation
      body: Obx(() => ListView.builder(
          reverse: true,
          itemCount: _viewModel.foodList.length,
          itemBuilder: (context, index) {
            final food = _viewModel.foodList[index];
            return FoodCard(
              foodName: food.name,
              // description: food.description,
              imagePath: food.imageUrls[0],
              price: food.price.toString(),
              shopName: food.shopName,
              onTap: () {
                Get.to(FoodDetailScreen(foodId: food.id));
              },
            );
          },
        ),
      ),
    );
  }
}