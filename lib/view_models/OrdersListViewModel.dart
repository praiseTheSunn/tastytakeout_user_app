import 'package:flutter/cupertino.dart';
import '/models/DTO/OrderModel.dart';
import '/data_sources/hardcode.dart' as data;

class ListOrdersViewModel extends ChangeNotifier {
  List<OrderModel> _orders = [];

  List<OrderModel> get orders {
    return this._orders;
  }

  Future<void> fetchOrders() async {
    this._orders = data.orders.cast<OrderModel>();
  }

  List<OrderModel> getOrdersByStatus(String status) {
    return this._orders.where((order) => order.status == status).toList();
  }
}
