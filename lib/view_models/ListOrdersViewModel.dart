import 'package:get/get.dart';
import 'OrderViewModel.dart';
import 'package:tastytakeout_user_app/models/DTO/OrderModel.dart';
import 'package:tastytakeout_user_app/data_sources/hardcode.dart' as data;

class ListOrdersViewModel extends GetxController {
  final _orders = <OrderViewModel>[].obs;

  List<OrderViewModel> get orders {
    return this._orders;
  }

  Future<void> fetchOrders() async {
    var orderModels = data.orders.cast<OrderModel>();
    this._orders.value =
        orderModels.map((order) => OrderViewModel(order)).toList();
  }

  List<OrderViewModel> getOrdersByStatus(String status) {
    return this._orders.where((order) => order.status == status).toList();
  }
}
