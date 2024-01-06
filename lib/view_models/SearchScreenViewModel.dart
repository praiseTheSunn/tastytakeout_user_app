

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tastytakeout_user_app/data_sources/food_source.dart';
import 'package:tastytakeout_user_app/models/DTO/FoodModel.dart';

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

  RxList<FoodModel> foodList = <FoodModel>[].obs;
  final List<String> suggestions = [];
  RxMap<String, List<FoodModel>> groupedByShop = <String, List<FoodModel>>{}.obs;

  Future<void> fetchFoodWithName(queryString) async {
    try {
      foodList.clear();
      Iterable foods = await _foodSource.getFoodWithName(queryString);
      // print imageUrls
      for (var food in foods) {
        foodList.add(food);
      }
      Map<String, List<FoodModel>> groupedByShopTemp = groupFoodByShop(foodList);
      for (var key in groupedByShopTemp.keys) {
        groupedByShop[key] = groupedByShopTemp[key]!;
      }


    } catch (e) {
      // Handle errors or exceptions here
      print('Error in fetchFoodWithName: $e');
    }
  }

  Map<String, List<FoodModel>> groupFoodByShop(List<FoodModel> foodList) {
      Map<String, List<FoodModel>> groupedByShop = {};

      for (FoodModel food in foodList) {
        if (groupedByShop.containsKey(food.shopName)) {
          groupedByShop[food.shopName]!.add(food);
        } else {
          groupedByShop[food.shopName] = [food];
        }
      }

      return groupedByShop;
  }
}