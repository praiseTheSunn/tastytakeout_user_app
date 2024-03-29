import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tastytakeout_user_app/data_sources/food_source.dart';
import 'package:tastytakeout_user_app/data_sources/hardcode.dart' as data;
import 'package:tastytakeout_user_app/globals.dart';
import 'package:tastytakeout_user_app/models/DTO/FoodModel.dart';
import 'package:tastytakeout_user_app/models/DTO/OrderModel.dart';
import 'package:tastytakeout_user_app/models/DTO/UserModel.dart';
import 'package:tastytakeout_user_app/data_sources/hardcode.dart';

class CartSource {
  final baseUrl = Uri.http(serverIp, '/carts/');
  final loginUrl = Uri.http(serverIp, '/users/login/');

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
    return data.accessKey;
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

    print('Getting access token...');
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
        print(response.body);
        var jsonString = utf8.decode(response.bodyBytes);
        List<dynamic> jsonData = json.decode(jsonString);

        if (jsonData.isNotEmpty) {
          // Group food items by store
          Map<int, List<FoodModel>> groupedFoodList = {};

          for (var cartItem in jsonData) {
            print(cartItem);
            int cartId = cartItem['id'];
            int quantity = cartItem['quantity'];
            var foodItem = cartItem['food'];

            int foodId = foodItem['id'];
            String foodName = foodItem['name'];
            String foodImageUrl =
                (foodItem['image_urls'] as List<dynamic>).first.toString();
            int foodPrice = foodItem['price'];
            int storeId = foodItem['store']['id'];
            var rating = foodItem['rating'];
            String storeName = foodItem['store']['name'];

            if (groupedFoodList.containsKey(storeId) &&
                groupedFoodList[storeId]!.any((food) => food.id == foodId)) {
              continue;
            }

            FoodModel food = FoodModel(
              id: foodId,
              cartId: cartId,
              name: foodName,
              imageUrls: [foodImageUrl],
              price: foodPrice,
              quantity: quantity,
              storeId: storeId,
              storeName: storeName,
              rating: rating.toInt(),
            );

            if (groupedFoodList.containsKey(storeId)) {
              groupedFoodList[storeId]!.add(food);
            } else {
              groupedFoodList[storeId] = [food];
            }

            if (groupedFoodList[storeId]!.length == 1) {
              OrderModel order = OrderModel(
                foods: groupedFoodList[storeId]!,
                status: PENDING,
                storeId: storeId,
                storeName: storeName,
                address: userModel.getAddress(),
                createdAt: DateTime.now().toIso8601String(),
              );
              carts.add(order);
            }
          }
        }
        return carts;
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception during request Cart: $e');
    }
    return [];
  }

  Future<http.Response> deleteCart(List<FoodModel> foods) async {
    try {
      /*...*/
      for (var food in foods) {
        final response = await http.delete(
          Uri.http(serverIp, '/carts/${food.cartId}/'),
          headers: {
            'accept': 'application/json',
            'Authorization': 'Bearer ${await getAccessToken()}',
          },
        );

        if (response.statusCode == 204) {
          print('Cart deleted');
        } else {
          print('Request failed with status: ${response.statusCode}');
        }
      }
    } catch (e) {
      print('Exception during delete Cart: $e');
    }
    return http.Response('', 500);
  }
}
