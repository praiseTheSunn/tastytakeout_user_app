import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tastytakeout_user_app/data_sources/food_source.dart';
import 'package:tastytakeout_user_app/models/DTO/FoodModel.dart';
import 'package:tastytakeout_user_app/models/DTO/OrderModel.dart';

class OrdersSource {
  OrdersSource._privateConstructor();

  static final OrdersSource _instance = OrdersSource._privateConstructor();

  factory OrdersSource() {
    return _instance;
  }

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
  final loginUrl = Uri.http('10.0.2.2:8080', '/users/login/');

  Future<String> getAccessToken() async {
    print('Getting access token...');
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

  Future<http.Response> postData(
      Uri uri, Map<String, dynamic> requestData) async {
    try {
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${await getAccessToken()}',
        },
        body: jsonEncode(requestData),
      );
      return response;
    } catch (e) {
      print('Exception during POST request: $e');
      return http.Response('Error during request', 500);
    }
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
        var jsonString = utf8.decode(response.bodyBytes);
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
            int voucher = orderItem['voucher'] ?? 0;

            // Extract food items from order
            List<dynamic> foodItems = orderItem['foods'];

            // Fetch details of all food items in parallel
            List<Future<FoodModel>> foodFutures =
                foodItems.map((foodItem) async {
              int stt = foodItem['id'];
              int foodId = foodItem['food'];
              int quantity = foodItem['quantity'];
              int total = foodItem['total'];

              FoodModel _food =
                  await FoodSource().getSimpleFoodDataById(foodId);

              return FoodModel(
                id: foodId,
                name: _food.name,
                price: _food.price,
                quantity: quantity,
                storeId: _food.storeId,
                storeName: _food.storeName,
                imageUrls: _food.imageUrls,
              );
            }).toList();

            // Wait for all food details to be fetched
            List<FoodModel> foods = await Future.wait(foodFutures);

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
        return orders;
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception during request Orders: $e');
    }
    return [];
  }

  Future<bool> addOrder(OrderModel cartOrder) async {
    var jsonMap = cartOrder.toMapJson();
    var response = await postData(baseUrl, jsonMap);

    if (response.statusCode == 201) {
      return true;
    } else {
      print('Request failed with status: ${response.statusCode}');
      return false;
    }
  }
}
