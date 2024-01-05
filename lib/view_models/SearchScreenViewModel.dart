

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tastytakeout_user_app/data_sources/food_source.dart';

// class Food {
//   final String name;
//   final String description;
//   final String imageUrl;
//   final double price;
//   final String shopName; // Added shopName field

//   Food({
//     required this.name,
//     required this.description,
//     required this.imageUrl,
//     required this.price,
//     required this.shopName, // Added shopName parameter
//   });

//   factory Food.fromJson(Map<String, dynamic> json) {
//     return Food(
//       name: json['name'],
//       description: json['description'],
//       imageUrl: json['image_urls'] != null && json['image_urls'].isNotEmpty
//           ? json['image_urls'][0]
//           : '',
//       price: (json['price'] ?? 0).toDouble(),
//       shopName: json['store']['name'],
//     );
//   }
// }

class SearchScreenViewModel extends GetxController {
  final FoodSource _foodSource = FoodSource();

  RxList<Food> foodList = <Food>[].obs;
  final List<String> suggestions = [];
  RxMap<String, List<Food>> groupedByShop = <String, List<Food>>{}.obs;

  Future<void> fetchFoodWithName(queryString) async {
    try {
      foodList.clear();
      Iterable foods = await _foodSource.getFoodWithName(queryString);
      // print imageUrls
      for (var food in foods) {
        foodList.add(food);
      }
      Map<String, List<Food>> groupedByShopTemp = groupFoodByShop(foodList);
      for (var key in groupedByShopTemp.keys) {
        groupedByShop[key] = groupedByShopTemp[key]!;
      }


    } catch (e) {
      // Handle errors or exceptions here
      print('Error in fetchFoodWithName: $e');
    }
  }

  Map<String, List<Food>> groupFoodByShop(List<Food> foodList) {
      Map<String, List<Food>> groupedByShop = {};

      for (Food food in foodList) {
        if (groupedByShop.containsKey(food.shopName)) {
          groupedByShop[food.shopName]!.add(food);
        } else {
          groupedByShop[food.shopName] = [food];
        }
      }

      return groupedByShop;
  }
}