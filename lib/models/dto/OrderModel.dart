import '/models/DTO/FoodModel.dart';

class OrderModel {
  late final String orderId;
  late final String storeId;
  late final String storeName;
  late final List<FoodModel> foods;
  late int cost;
  late final String status; // Prepare, Pending, Completed

  OrderModel({
    required this.orderId,
    required this.storeId,
    required this.storeName,
    required this.foods,
    required this.status,
  }) {
    calculateTotalCost();
  }

  void calculateTotalCost() {
    cost = 0;
    for (var food in foods) {
      cost += food.cost * food.quantity;
    }
  }
}
