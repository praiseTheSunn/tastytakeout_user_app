import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastytakeout_user_app/data_sources/food_source.dart';
import 'package:tastytakeout_user_app/view_models/SearchScreenViewModel.dart';
import 'package:tastytakeout_user_app/views/screens/food_detail_screen.dart';
import 'package:tastytakeout_user_app/views/widgets/item_food_extra.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  final SearchScreenViewModel _viewModel = Get.put(SearchScreenViewModel());
  
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: Implement your search logic here
    _viewModel.fetchFoodWithName(query);
    _viewModel.suggestions.add(query);
    return DefaultTabController(
      length: 2,
      child: Column(
            children: [
              TabBar(
                tabs: [
                  Tab(text: 'Món ăn'),
                  Tab(text: 'Cửa hàng'),
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
                      Obx(() => 
                      ListView.builder(
      itemCount: _viewModel.groupedByShop.value.length,
      itemBuilder: (context, index) {
        String shopName = _viewModel.groupedByShop.value.keys.elementAt(index);
        List<Food> foods = _viewModel.groupedByShop.value[shopName]!;

        return Card(
          elevation: 0,
          color: Colors.transparent,
          margin: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  shopName,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: foods.length,
                itemBuilder: (context, index) {
                  Food food = foods[index];
                  return InkWell(
                    onTap: () {
                              Get.to(FoodDetailScreen());
                            },
                    child: FoodCard(
                                foodName: food.name,
                                // description: food.description,
                                imagePath: food.imageUrl,
                                price: food.price.toString(),
                                shopName: "", // Pass shopName to FoodCard
                                onTap: () {
                                  print("Tapped on ${food.name}");
                                },
                              ),
                  );
                },
              ),
            ],
          ),
        );
      },
    )
                      )
                    ],
                  ),
              ),
            ],
          ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: Implement your suggestion logic here
    // return Container();

    return ListView.builder(
      itemCount: _viewModel.suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_viewModel.suggestions[index]),
          onTap: () {
            // Close the search delegate and pass the selected suggestion
            // close(context, _viewModel.suggestions[index]);
            query = _viewModel.suggestions[index];
            showResults(context);
          },
        );
      },
    );
  }
}
