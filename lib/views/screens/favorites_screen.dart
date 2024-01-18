import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastytakeout_user_app/globals.dart';
import 'package:tastytakeout_user_app/view_models/FavoritesScreenViewModel.dart';
import 'package:tastytakeout_user_app/views/screens/food_detail_screen.dart';

// import 'package:tastytakeout_user_app/views/screens/food_details_screen.dart';
import 'package:tastytakeout_user_app/views/widgets/custom_app_bar.dart';
import 'package:tastytakeout_user_app/views/widgets/item_food_extra.dart';

import '../widgets/custom_drawer.dart';

class FavoritesScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FavoritesScreenViewModel(), fenix: true);
  }
}

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen({Key? key});
  FavoritesScreenViewModel _viewModel =
      Get.find<FavoritesScreenViewModel>();

  @override
  Widget build(BuildContext context) {
    print('FavoritesScreen build');
    return Scaffold(
      backgroundColor: mainColor,
      appBar: CustomAppBar(
        title: 'Yêu thích',
        // Add necessary onPressed callbacks for the app bar icons
      ), // Replace with your custom app bar implementation
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
      child: Obx(() {
        if (_viewModel.isLoading.value) {
          String notification = 'Đang tải dữ liệu...';
          print(notification);
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'lib/resources/gif/loading.gif',
                width: 150,
                height: 150,
              ),
              Text(
                notification,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ));
        } else {
          return RefreshIndicator(
            onRefresh: () async {
              _viewModel.fetchFavoriteFood();
            },
            child: Obx(() => ListView.builder(
                itemCount: _viewModel.foodList.value.length,
                itemBuilder: (context, index) {
                  final food = _viewModel.foodList.value[index];
                  return InkWell(
                    onTap: () {
                      Get.to(FoodDetailScreen(
                        foodId: _viewModel.foodList.value[index].id,
                      ))?.then((value) {
                        _viewModel.fetchFavoriteFood();
                      });
                    },
                    child: FoodCard(
                      foodName: food.name,
                      // description: food.description,
                      imagePath: food.imageUrls[0],
                      price: food.price.toString(),
                      shopName: food.shopName,
                      // Pass shopName to FoodCard
                      onTap: () {
                        print("Tapped on ${food.name}");
                      },
                    ),
                  );
                },
              ),
            ),
          );
        }
      }),
    );
  }
}
