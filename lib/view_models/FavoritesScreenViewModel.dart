import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tastytakeout_user_app/data_sources/food_source.dart';
import 'package:tastytakeout_user_app/models/DTO/FoodModel.dart';
import 'package:http/http.dart' as http;

import '../globals.dart';

// import 'package:tastytakeout_user_app/models/food.dart';

class FavoritesScreenViewModel extends GetxController {
  var isLoading = true.obs;
  final FoodSource foodSource = FoodSource();
  final baseUrl = Uri.http(serverIp, '/foods/');

  var foodList = RxList<FoodModel>();

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchFavoriteFood() async {
    print('fetchFavoriteFood');
    try {
      isLoading(true);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token') ?? '';
      final uri = Uri.parse('$baseUrl?is_liked=true');

      final response = await http.get(
        uri,
        headers: {
          'accept': 'application/json',
          'Authorization' : 'Bearer ' + token,
        },
      );

      if (response.statusCode == 200) {
        var jsonString = utf8.decode(response.bodyBytes);
        List<dynamic> jsonData = json.decode(jsonString);

        foodList.value = jsonData
            .map((foodItem) =>
                FoodModel.fromJson(foodItem))
            .toList();
      } else {
        // Error handling for unsuccessful requests
        throw('Request failed with status: ${response.statusCode}');
      }
      // foodList.clear();
      // Iterable foods = await foodSource.getFavoriteFood();
      // // print imageUrls
      // for (var food in foods) {
      //   foodList.add(food);
      // }
      // foodList.refresh();
    } catch (e) {
      // Handle errors or exceptions here
      print('Error in fetchFavoriteFood in FavoritesScreenViewModel: $e');
    } finally {
      isLoading(false);
    }
  }
  @override
  void onReady() {
    // TODO: implement onReady
    print('onReady');
    super.onReady();
    fetchFavoriteFood();
  }
}
