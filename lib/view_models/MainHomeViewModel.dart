import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastytakeout_user_app/data_sources/food_source.dart';

class MainHomeViewModel extends GetxController {
  final FoodSource _popularFoodSource = FoodSource();
  RxList<String> popularFoodImagesUrls = <String>[].obs;

  final List<String> images = [];

  Future<void> fetchPopularFoodImages() async {
    try {
      await _popularFoodSource.fetchData();
    } catch (e) {
      // Handle errors or exceptions here
      print('Error in fetchDataFromPopularFoodSource: $e');
    }
  }

  Future<void> fetchPopularFoodImagesUrls() async {
    try {
      Iterable imageUrls = await _popularFoodSource.getPopularFoodImages(4.0);
      // print imageUrls
      for (var imageUrl in imageUrls) {
        popularFoodImagesUrls.add(imageUrl);
      }
    } catch (e) {
      // Handle errors or exceptions here
      print('Error in fetchPopularFoodImagesUrls: $e');
    }
  }
}
