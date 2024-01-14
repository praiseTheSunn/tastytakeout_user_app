import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:tastytakeout_user_app/globals.dart';

class FoodDetailScreenViewModel extends GetxController {
  final TEST_ID = 1;
  int id = 0;
  final BASE_URL = 'http://$serverIp/foods/';
  var isLoading = true.obs;
  var foodDetail = FoodDetail(
    name: '',
    price: 0,
    imageUrl: [],
    rating: 0,
    description: '',
    storeDetail: StoreDetail(
      id: 0,
      name: '',
      address: '',
      imageUrl: '',
    ),
  ).obs;

  FoodDetailScreenViewModel(int id) {
    this.id = id;
  }

  @override
  void onInit() {
    fetchFoodDetail();
    print('FoodDetailScreenViewModel initialized');
    super.onInit();
  }

  Future<void> fetchFoodDetail() async {
    try {
      isLoading(true);
      final response = await get(
        Uri.parse('$BASE_URL$id'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept-Charset': 'UTF-8',
        },
      );
      if (response.statusCode != 200) {
        throw Exception('Error fetching food detail');
      } else {
        print(response.body);
        foodDetail.value = FoodDetail.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      }
    } catch (e) {
      print('Error in fetchFoodDetail ' + e.toString());
    } finally {
      isLoading(false);
    }
  }
}

class StoreDetail {
  final String name;
  final String address;
  final String imageUrl;
  final int id;

  StoreDetail({
    required this.name,
    required this.address,
    required this.imageUrl,
    required this.id,
  });

  factory StoreDetail.fromJson(Map<String, dynamic> json) {
    return StoreDetail(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      imageUrl: json['image_url'],
    );
  }
}

class FoodDetail {
  final String name;
  final int price;
  final List<dynamic> imageUrl;
  final double rating;
  final String description;
  final StoreDetail storeDetail;

  FoodDetail({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.description,
    required this.storeDetail,
  });

  factory FoodDetail.fromJson(Map<String, dynamic> json) {
    return FoodDetail(
      name: json['name'],
      price: json['price'],
      imageUrl: json['image_urls'],
      rating: json['rating'],
      description: json['description'],
      storeDetail: StoreDetail.fromJson(json['store']),
    );
  }
}
