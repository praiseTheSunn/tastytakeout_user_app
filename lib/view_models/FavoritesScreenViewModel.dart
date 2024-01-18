import 'package:get/get.dart';
import 'package:tastytakeout_user_app/data_sources/food_source.dart';
import 'package:tastytakeout_user_app/models/DTO/FoodModel.dart';

// import 'package:tastytakeout_user_app/models/food.dart';

class FavoritesScreenViewModel extends GetxController {
  var isLoading = true.obs;
  final FoodSource foodSource = FoodSource();

  RxList<FoodModel> foodList = <FoodModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchFavoriteFood();
  }

  Future<void> fetchFavoriteFood() async {
    try {
      isLoading(true);
      foodList.clear();
      Iterable foods = await foodSource.getFavoriteFood();
      // print imageUrls
      for (var food in foods) {
        foodList.add(food);
      }
    } catch (e) {
      // Handle errors or exceptions here
      print('Error in fetchPopularFood in PopularScreenViewModel: $e');
    } finally {
      isLoading(false);
    }
  }
}
