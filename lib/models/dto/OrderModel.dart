import '/models/DTO/FoodModel.dart';

class OrderModel {
  late final String orderId;
  late final String storeId;
  late final String storeName;
  late final List<FoodModel> foods;
  late int price;
  late final String status; // Prepare, Pending, Completed

  OrderModel({
    this.orderId = '',
    this.storeId = '',
    this.storeName = '',
    this.foods = const [],
    this.price = 0,
    this.status = 'Pending',
  });

  void decreaseFoodQuantity(FoodModel food) {
    if (this.foods.contains(food)) {
      food.quantity--;
      this.price -= food.price;
    }
  }

  void increaseFoodQuantity(FoodModel food) {
    if (this.foods.contains(food)) {
      food.quantity++;
      this.price += food.price;
    }
  }

  int calculatePrice() {
    int totalPrice = 0;
    for (var food in foods) {
      totalPrice += food.price * food.quantity;
    }
    return totalPrice;
  }
}
