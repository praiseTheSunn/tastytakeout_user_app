import 'package:flutter/material.dart';
import 'package:tastytakeout_user_app/views/widgets/custom_search_app_bar.dart';

import 'package:flutter/material.dart';
import 'package:tastytakeout_user_app/views/widgets/custom_search_app_bar.dart';

import 'package:flutter/material.dart';
import 'package:tastytakeout_user_app/views/widgets/custom_search_app_bar.dart';

class SearchScreen extends StatefulWidget {
  final String searchQuery;

  const SearchScreen({Key? key, required this.searchQuery}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
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
                    // ListView.builder(
                    //   itemCount: _viewModel.foodList.length,
                    //   itemBuilder: (context, index) {
                    //     final food = _viewModel.foodList[index];
                    //     return InkWell(
                    //       onTap: () {
                    //         Get.to(FoodDetailScreen());
                    //       },
                    //       child: FoodCard(
                    //         foodName: food.name,
                    //         // description: food.description,
                    //         imagePath: food.imageUrl,
                    //         price: food.price.toString(),
                    //         shopName: food.shopName, // Pass shopName to FoodCard
                    //         onTap: () {
                    //           print("Tapped on ${food.name}");
                    //         },
                    //       ),
                    //     );
                    //   },
                    // ),
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
