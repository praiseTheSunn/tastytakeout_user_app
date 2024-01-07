import 'package:get/get.dart';
import 'package:tastytakeout_user_app/data_sources/food_source.dart';
import 'package:tastytakeout_user_app/models/DTO/FoodModel.dart';

class PopularScreenViewModel extends GetxController {
  final FoodSource _popularFoodSource = FoodSource();

  RxList<FoodModel> foodList = <FoodModel>[].obs;

  Future<void> fetchPopularFood(double rating) async {
    try {
      foodList.clear();
      Iterable foods = await _popularFoodSource.getFoodWithRating(rating);
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