import '/models/DTO/FoodModel.dart';
import '/data_sources/hardcode.dart' as data;

class OrderModel {
  late final int orderId;
  late final List<FoodModel> foods;
  late final int buyerId;
  late final String address;
  late String status; // InCast, Pending, Prepare, Delivering , Completed
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
    this.voucherId = -1,
    this.createdAt = '',
    this.paymentMethod = 'CASH', // CASH, BANKING
  });

  int calculatePrice() {
    int totalPrice = 0;
    for (var food in foods) {
      totalPrice += food.price * food.quantity;
    }
    return totalPrice;
  }

/* order json data of food
      {
      "foods": [
        {
          "quantity": 2147483647,
          "total": 2147483647,
          "food": 0
        }
      ],
      "address": "string",
      "status": "PENDING",
      "total": 2147483647,
      "created_at": "2024-01-05T09:37:27.827Z",
      "payment_method": "CASH",
      "voucher": 0
    }
   */

  String toJson() {
    String json = '{';
    json += '"foods": [';
    for (var food in foods) {
      json += '{';
      json += '"quantity": ${food.quantity},';
      json += '"total": ${food.price * food.quantity},';
      json += '"food": ${food.id}';
      json += '},';
    }
    json += '],';
    json += '"address": "$address",';
    json += '"status": "$status",';
    json += '"total": ${calculatePrice()},';
    json += '"created_at": "$createdAt",';
    json += '"payment_method": "$paymentMethod",';
    json += '"voucher": $voucherId';
    json += '}';
    return json;
  }
}
