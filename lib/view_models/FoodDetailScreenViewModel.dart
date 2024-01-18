import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:tastytakeout_user_app/globals.dart';
import 'package:tastytakeout_user_app/service/auth_service.dart';
import 'package:tastytakeout_user_app/view_models/ListOrdersViewModel.dart';

class FoodDetailScreenViewModel extends GetxController {
  final TEST_ID = 1;
  int id = 0;
  final BASE_URL = 'http://$serverIp/foods/';
  String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxODg1OTUxNjI4LCJpYXQiOjE3MDQ1MTE2MjgsImp0aSI6IjU1MGFiOWU0MGM4MTQ2MDNhNmQxMjcxZjRiZjYxNmQ4IiwidXNlcl9pZCI6MTAsInJvbGUiOiJCVVlFUiJ9.Um--pPRWNG7VPh9F7ARYaRIn2Ab5yDvrpZvfsO9_9vA';
  var isLoading = true.obs;
  var isFavorite = false.obs;
  var foodDetail = FoodDetail(
    name: '',
    price: 0,
    imageUrl: [],
    rating: 0,
    description: '',
    isFavorite: false,
    storeDetail: StoreDetail(
      id: 0,
      name: '',
      address: '',
      imageUrl: '',
    ),
  ).obs;

  FoodDetailScreenViewModel(int id) {
    this.id = id;
    final AuthService authService = Get.put(AuthService());
    authService.checkLoginStatus();
    this.token = authService.token;
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
      var response = await get(
        Uri.parse('$BASE_URL$id'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept-Charset': 'UTF-8',
          'Authorization' : 'Bearer ' + token,
        },
      );
      if (response.statusCode != 200) {
        throw Exception('Error fetching food detail');
      } else {
        print(response.body);
        foodDetail.value = FoodDetail.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
        isFavorite.value = foodDetail.value.isFavorite;
      }
    } catch (e) {
      print('Error in fetchFoodDetail ' + e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<bool> addFoodToCart(int id,int quantity) async {
    try {
      final jsonBody = json.encode({
        'quantity': quantity,
        'food': id,
      });
      print(jsonBody);
      final response = await post(
        Uri.parse('http://$serverIp/carts/'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept-Charset': 'UTF-8',
          'Authorization' : 'Bearer ' + token,
        },
        body: jsonBody,
      );
      if (response.statusCode != 201  && response.statusCode != 200) {
        throw Exception('Error adding food to cart');
      } else {
        print(response);
        return true;
      }
    } catch (e) {
      print('Error in addFoodToCart ' + e.toString());
      return false;
    }
  }

  Future<bool> changeLikeStatus() async {
    try {
      final jsonBody = json.encode({
        'is_liked': !isFavorite.value,
      });
      print(jsonBody);
      final response = await post(
        Uri.parse('$BASE_URL$id/like/'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept-Charset': 'UTF-8',
          'Authorization' : 'Bearer ' + token,
        },
        body: jsonBody,
      );
      if (response.statusCode != 201 && response.statusCode != 200) {
        throw Exception('Error changing like status');
      } else {
        print(response);
        isFavorite.value = !isFavorite.value;
        return true;
      }
    } catch (e) {
      print('Error in changeLikeStatus ' + e.toString());
      return false;
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
  final bool isFavorite;

  FoodDetail({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.description,
    required this.storeDetail,
    required this.isFavorite,
  });

  factory FoodDetail.fromJson(Map<String, dynamic> json) {
    return FoodDetail(
      name: json['name'],
      price: json['price'],
      imageUrl: json['image_urls'],
      rating: json['rating'],
      description: json['description'],
      isFavorite: json['is_liked'],
      storeDetail: StoreDetail.fromJson(json['store']),
    );
  }
}
