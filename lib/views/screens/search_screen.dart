import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastytakeout_user_app/views/screens/food_detail_screen.dart';
import 'package:tastytakeout_user_app/views/widgets/custom_search_app_bar.dart';
import 'package:tastytakeout_user_app/views/widgets/item_food_extra.dart';
import 'package:tastytakeout_user_app/view_models/SearchScreenViewModel.dart';

class SearchScreen extends StatefulWidget {
  final String searchQuery;

  const SearchScreen({Key? key, required this.searchQuery}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchScreenViewModel _viewModel = Get.put(SearchScreenViewModel());

  @override
  Widget build(BuildContext context) {
    _viewModel.fetchFoodWithName(widget.searchQuery);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomSearchAppBar(),
        body: Column(
          children: [
            TabBar(
              tabs: [
                Tab(text: 'Tab 1'),
                Tab(text: 'Tab 2'),
              ],
            ),
            Expanded(
              child: TabBarView(
                  children: [
                    Obx(() => ListView.builder(
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
                            imagePath: food.imageUrl,
                            price: food.price.toString(),
                            shopName: food.shopName, // Pass shopName to FoodCard
                            onTap: () {
                              print("Tapped on ${food.name}");
                            },
                          ),
                        );
                      },
                    )
                    ),
                    Icon(Icons.directions_transit),
                  ],
                ),
            ),
          ],
        ),
        ),
      );
  }
}
