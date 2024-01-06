import 'package:get/get.dart';
import 'package:tastytakeout_user_app/models/DTO/OrderModel.dart';
import 'package:tastytakeout_user_app/data_sources/hardcode.dart' as data;

import '../data_sources/order_source.dart';

class ListOrdersViewModel extends GetxController {
  var orderList = <OrderModel>[].obs;
  var filteredOrderList = <OrderModel>[].obs;
  var cartList = <OrderModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchOrders() async {
    //List<OrderModel> orders = data.orders;

    orderList.value = await OrdersSource().fetchOrders();
    filteredOrderList.value = [];
  }

  Future<void> fetchCart() async {
    List<OrderModel> carts = data.carts;

    if (cartList.value.isEmpty) {
      cartList.value = carts;
    }
  }

  void filterOrdersByStatus(String status) {
    filteredOrderList.value =
        orderList.where((order) => order.status == status).toList();
  }

  void exportFromCartToOrder(int cartIndex) {
    cartList[cartIndex].status = data.Pending;

    orderList.add(cartList[cartIndex]);
    filterOrdersByStatus(data.Prepare);
    cartList.removeAt(cartIndex);
  }
}
