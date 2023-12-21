import '/models/DTO/FoodModel.dart';
import '/models/DTO/OrderModel.dart';

/// Const variable
final String Prepare = 'Chuẩn bị';
final String Pending = 'Đang giao';
final String Completed = 'Đã giao';

final String imageUrl =
    'https://images.pexels.com/photos/376464/pexels-photo-376464.jpeg';

final List<OrderModel> orders = [
  OrderModel(
      orderId: "id1",
      storeId: "s1",
      storeName: "Store 1",
      status: Completed,
      foods: foods.sublist(0, 1)),
  OrderModel(
      orderId: "id2",
      storeId: "s2",
      storeName: "Store 2",
      status: Prepare,
      foods: foods.sublist(0, 2)),
  OrderModel(
      orderId: "id2",
      storeId: "s2",
      storeName: "Store 3",
      status: Prepare,
      foods: foods.sublist(0, 3)),
  OrderModel(
      orderId: "id2",
      storeId: "s2",
      storeName: "Store 4",
      status: Prepare,
      foods: foods.sublist(0, 4))
];

final List<FoodModel> foods = [
  FoodModel(
    name: 'Chicken Burger',
    price: 10000,
    quantity: 1,
    imageUrl: imageUrl,
  ),
  FoodModel(
    name: 'Chicken Burger',
    price: 10000,
    quantity: 1,
    imageUrl: imageUrl,
  ),
  FoodModel(
    name: 'Chicken Burger',
    price: 10000,
    quantity: 1,
    imageUrl: imageUrl,
  ),
  FoodModel(
    name: 'Chicken Burger',
    price: 10000,
    quantity: 1,
    imageUrl: imageUrl,
  )
];
