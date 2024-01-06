import 'package:get/get.dart';
import 'package:tastytakeout_user_app/data_sources/food_source.dart';
import 'package:tastytakeout_user_app/models/DTO/FoodModel.dart';

// import 'package:tastytakeout_user_app/models/food.dart';

class FavoritesScreenViewModel extends GetxController {
  final FoodSource _popularFoodSource = FoodSource();

  RxList<FoodModel> foodList = <FoodModel>[].obs;

  Future<void> fetchFavoriteFood() async {
    try {
      foodList.clear();
      Iterable foods = await _popularFoodSource.getFavoriteFood();
      // print imageUrls
      for (var food in foods) {
        foodList.add(food);
      }

    } catch (e) {
      // Handle errors or exceptions here
      print('Error in fetchPopularFood in PopularScreenViewModel: $e');
    }
  }
}