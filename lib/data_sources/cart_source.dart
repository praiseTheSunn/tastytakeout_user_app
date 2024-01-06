import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tastytakeout_user_app/data_sources/food_source.dart';
import 'package:tastytakeout_user_app/models/DTO/FoodModel.dart';
import 'package:tastytakeout_user_app/models/DTO/OrderModel.dart';

class CartSource {
  final baseUrl = Uri.http('localhost:8080', '/carts/');
  final loginUrl = Uri.http('localhost:8080', '/auth/login/');

  /* Example JSON response:
         [
          {
            "quantity": 2147483647,
            "food": {
              "id": 0,
              "category": {
                "id": 0,
                "name": "string"
              },
              "store": {
                "id": 0,
                "owner": 0,
                "name": "string",
                "image_url": "string",
                "address": "string"
              },
              "image_urls": "string",
              "name": "string",
              "description": "string",
              "price": 2147483647,
              "quantity": 2147483647,
              "created_at": "2024-01-05T10:46:29.687Z",
              "rating": 0
            }
          }
        ]
          */

  Future<String> getAccessToken() async {
    final responseLogin = await http.post(
      loginUrl,
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'username': '123',
        'password': '1234',
      }),
    );

    String accessToken = jsonDecode(responseLogin.body)['access'];
    print('Access token: $accessToken');
    return accessToken;
  }

  /* jsonData example:
        [
          {
            "quantity": 2147483647,
            "food": {
              "id": 0,
              "category": {
                "id": 0,
                "name": "string"
              },
              "store": {
                "id": 0,
                "owner": 0,
                "name": "string",
                "image_url": "string",
                "address": "string"
              },
              "image_urls": "string",
              "name": "string",
              "description": "string",
              "price": 2147483647,
              "quantity": 2147483647,
              "created_at": "2024-01-05T10:50:53.000Z",
              "rating": 0
            }
          }
        ]
         */

  Future<List<OrderModel>> fetchCartInfoToPendingOrders() async {
    try {
      List<OrderModel> carts = [];

      final response = await http.get(
        baseUrl,
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer ${await getAccessToken()}',
        },
      );

      if (response.statusCode == 200) {
        print('Response: ${response.body}');
        var jsonString = response.body;
        List<dynamic> jsonData = json.decode(jsonString);

        if (jsonData.isNotEmpty) {
          List<FoodModel> foodList = [];

          for (var cartItem in jsonData) {
            int quantity = cartItem['quantity'];
            var foodItem = cartItem['food'];
            int foodId = foodItem['id'];
            String foodName = foodItem['name'];
            String foodImageUrl = foodItem['image_urls'];
            int foodPrice = foodItem['price'];
            int storeId = foodItem['store']['id'];
            String storeName = foodItem['store']['name'];

            FoodModel food = FoodModel(
              id: foodId,
              name: foodName,
              imageUrls: [foodImageUrl],
              price: foodPrice,
              quantity: quantity,
              storeId: storeId,
              storeName: storeName,
            );

            foodList.add(food);
          }

          foodList.sort((a, b) => a.storeId.compareTo(b.storeId));

          // Group food items by store
          Map<int, List<FoodModel>> groupedFoodList = {};
          for (var food in foodList) {
            if (groupedFoodList.containsKey(food.storeId)) {
              groupedFoodList[food.storeId]?.add(food);
            } else {
              groupedFoodList[food.storeId] = [food];
            }
          }

          // Create order from grouped food items
          for (var storeId in groupedFoodList.keys) {
            List<FoodModel> foods = groupedFoodList[storeId]!;
            OrderModel order = OrderModel(
              foods: foods,
              storeId: foods[0].storeId,
              storeName: foods[0].storeName,
            );
            carts.add(order);
          }
        }
        return carts;
      } else {
        // Error handling for unsuccessful requests
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Exception handling
      print('Exception during request: $e');
    }
    return [];
  }
}
