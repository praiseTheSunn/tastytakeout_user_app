import '../models/DTO/FoodModel.dart';
import '/models/DTO/OrderModel.dart';
import 'package:flutter/cupertino.dart';

class OrderViewModel {
  final OrderModel _order;

  OrderViewModel(this._order);

  String get storeName {
    return this._order.storeName;
  }

  List<FoodModel> get foods {
    return this._order.foods;
  }

  String get status {
    return this._order.status;
  }

  int get cost {
    return this._order.cost;
  }
}
