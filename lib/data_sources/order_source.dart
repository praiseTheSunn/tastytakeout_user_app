import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tastytakeout_user_app/data_sources/food_source.dart';
import 'package:tastytakeout_user_app/models/DTO/FoodModel.dart';
import 'package:tastytakeout_user_app/models/DTO/OrderModel.dart';

class OrdersSource {
/* Example JSON response:
          [
            {
              "id": 0,
              "foods": [
                {
                  "id": 0,
                  "quantity": 2147483647,
                  "total": 2147483647,
                  "food": 0
                }
              ],
              "address": "string",
              "status": "PENDING",
              "total": 2147483647,
              "created_at": "2024-01-04T17:25:49.634Z",
              "payment_method": "CASH",
              "buyer": 0,
              "voucher": 0
            }
          ]
          */

  final baseUrl = Uri.http('10.0.2.2:8080', '/orders/');
  final loginUrl = Uri.http('10.0.2.2:8080', '/login/');

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

  Future<http.Response> postData(String url, String jsonData) async {
    final response = await http.post(
      baseUrl,
      headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer ${await getAccessToken()}',
      },
      body: jsonData,
    );
    return response;
  }

  Future<List<OrderModel>> fetchOrders() async {
    try {
      List<OrderModel> orders = [];

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
          for (var orderItem in jsonData) {
            int id = orderItem['id'];
            String address = orderItem['address'];
            String status = orderItem['status'];
            int total = orderItem['total'];
            String createdAt = orderItem['created_at'];
            String paymentMethod = orderItem['payment_method'];
            int buyer = orderItem['buyer'];
            int voucher = orderItem['voucher'];

            // Extract food items from order
            List<dynamic> foodItems = orderItem['foods'];
            List<FoodModel> foods = foodItems.map((foodItem) {
              int stt = foodItem['id'];
              int foodId = foodItem['food'];
              int quantity = foodItem['quantity'];
              int total = foodItem['total'];

              FoodModel _food =
                  FoodSource().getSimpleFoodDataById(foodId) as FoodModel;

              return FoodModel(
                id: foodId,
                name: _food.name,
                price: _food.price,
                quantity: quantity,
                storeId: _food.storeId,
                storeName: _food.storeName,
              );
            }).toList();

            OrderModel order = OrderModel(
              orderId: id,
              foods: foods,
              address: address,
              status: status,
              storeId: foods[0].storeId,
              storeName: foods[0].storeName,
              createdAt: createdAt,
              paymentMethod: paymentMethod,
              buyerId: 12345,
              voucherId: 1,
            );

            orders.add(order);
          }
        }
        for (var order in orders) {
          print('Order: ${order.orderId}');
          for (var food in order.foods) {
            print('Food: ${food.name}');
          }
        }
        return orders;
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception during request Orders: $e');
    }
    return [];
  }
}
