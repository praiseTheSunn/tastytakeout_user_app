import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  late NearbyScreenViewModel _nearbyViewModel;

  @override
  void initState() {
    super.initState();
    _nearbyViewModel = NearbyScreenViewModel(); // Replace with your viewmodel implementation
    _nearbyViewModel.fetchData(); // Fetch data from somewhere
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Gần đây',
        // Add necessary onPressed callbacks for the app bar icons
      ), // Replace with your custom app bar implementation
      body: ListView.builder(
        itemCount: _nearbyViewModel.foodList.length,
        itemBuilder: (context, index) {
          final food = _nearbyViewModel.foodList[index];
          return FoodCard(
            foodName: food.name,
            // description: food.description,
            imagePath: food.imageUrl,
            price: food.price.toString(),
            shopName: food.shopName, // Pass shopName to FoodCard
            distance: food.distance,
            onTap: () {
              print("Tapped on ${food.name}");
            },
          );
        },
      ),
    );
  }
}