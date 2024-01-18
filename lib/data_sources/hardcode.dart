import 'package:shared_preferences/shared_preferences.dart';
import 'package:tastytakeout_user_app/data_sources/user_source.dart';
import 'package:tastytakeout_user_app/models/DTO/UserModel.dart';

import '/models/DTO/FoodModel.dart';
import '/models/DTO/OrderModel.dart';

/// Const variable
const String REJECTED = 'REJECTED';
const String PENDING = 'PENDING';
const String PREPARE = 'PREPARE';
const String DELIVERING = 'DELIVERING';
const String COMPLETED = 'COMPLETED';

var mapStatus = {
  PENDING: 'Đang chờ',
  PREPARE: 'Đang chuẩn bị',
  DELIVERING: 'Đang giao',
  COMPLETED: 'Đã giao',
};

//Data----------------//
String accessKey = '';
UserModel userModel = UserModel();
//--------------------//

Future<void> updateUserInfoAfterLogin() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  accessKey = prefs.getString('token') ?? '';
  userModel = await UserSource().getUserInfo();
}

final String imageUrl =
    'https://images.pexels.com/photos/376464/pexels-photo-376464.jpeg';

final List<OrderModel> orders = [
  OrderModel(
      orderId: 1,
      storeId: 1,
      storeName: "Store 1",
      status: COMPLETED,
      foods: foods.sublist(0, 1)),
  OrderModel(
      orderId: 2,
      storeId: 2,
      storeName: "Store 2",
      status: PENDING,
      foods: foods.sublist(1, 2)),
  OrderModel(
      orderId: 3,
      storeId: 3,
      storeName: "Store 3",
      status: PREPARE,
      foods: foods.sublist(2, 3)),
  OrderModel(
      orderId: 4,
      storeId: 4,
      storeName: "Store 4",
      status: PREPARE,
      foods: foods.sublist(3, 4))
];

final List<OrderModel> carts = [
  OrderModel(
      orderId: 1,
      storeId: 1,
      storeName: "Store 11",
      status: COMPLETED,
      foods: foods.sublist(0, 1)),
  OrderModel(
      orderId: 2,
      storeId: 2,
      storeName: "Store 22",
      status: PREPARE,
      foods: foods.sublist(1, 2)),
  OrderModel(
      orderId: 3,
      storeId: 3,
      storeName: "Store 33",
      status: PREPARE,
      foods: foods.sublist(2, 3)),
  OrderModel(
      orderId: 4,
      storeId: 4,
      storeName: "Store 44",
      status: PREPARE,
      foods: foods.sublist(3, 4))
];

List<FoodModel> foods = [
  FoodModel(
    name: 'Chicken Burger store1',
    price: 10000,
    quantity: 1,
    imageUrls: [imageUrl],
  ),
  FoodModel(
    name: 'Chicken Burger store2',
    price: 10000,
    quantity: 1,
    imageUrls: [imageUrl],
  ),
  FoodModel(
    name: 'Chicken Burger store3',
    price: 10000,
    quantity: 1,
    imageUrls: [imageUrl],
  ),
  FoodModel(
    name: 'Chicken Burger store4',
    price: 10000,
    quantity: 1,
    imageUrls: [imageUrl],
  )
];
