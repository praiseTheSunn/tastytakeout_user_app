import '/models/DTO/FoodModel.dart';
import '/data_sources/hardcode.dart' as data;

class OrderModel {
  late final int orderId;
  late final List<FoodModel> foods;
  late final int buyerId;
  late final String address;
  late String status; // Prepare, Pending, Completed
  late int price;
  late final int storeId;
  late final String storeName;
  late final int voucherId;
  late final String createdAt;
  late final String paymentMethod;

  OrderModel({
    this.orderId = 0,
    this.foods = const [],
    this.buyerId = 0,
    this.address = '',
    this.status = data.Prepare,
    this.price = 0,
    this.storeId = 0,
    this.storeName = '',
    this.voucherId = 0,
    this.createdAt = '',
    this.paymentMethod = '',
  });

  int calculatePrice() {
    int totalPrice = 0;
    for (var food in foods) {
      totalPrice += food.price * food.quantity;
    }
    return totalPrice;
  }
}
