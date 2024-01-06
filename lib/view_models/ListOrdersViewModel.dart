import 'package:get/get.dart';
import 'package:tastytakeout_user_app/models/DTO/OrderModel.dart';
import 'package:tastytakeout_user_app/data_sources/hardcode.dart' as data;

import '../data_sources/cart_source.dart';
import '../data_sources/order_source.dart';

class ListOrdersViewModel extends GetxController {
  var orderList = <OrderModel>[].obs;
  var filteredOrderList = <OrderModel>[].obs;
  var cartList = <OrderModel>[].obs;
  var isLoading = true.obs;

  final List<String> OrderStatus = [
    data.PENDING,
    data.PREPARE,
    data.DELIVERING,
    data.COMPLETED
  ];
  List<String> selectedStatus = [data.PENDING];

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchOrders() async {
    //List<OrderModel> orders = data.orders;
    if (orderList.isEmpty) {
      isLoading.value = true;
    }

    orderList.value = await OrdersSource().fetchOrders();
    filterOrdersByStatus();
    isLoading.value = false;
  }

  Future<void> fetchCart() async {
    //List<OrderModel> carts = data.carts;
    if (cartList.isEmpty) {
      isLoading.value = true;
    }

    cartList.value = await CartSource().fetchCartInfoToPendingOrders();
    isLoading.value = false;
  }

  void filterOrdersByStatus() {
    filteredOrderList.value =
        orderList.where((order) => order.status == selectedStatus[0]).toList();
  }

  void exportFromCartToOrder(int cartIndex) {
    cartList[cartIndex].status = data.PENDING;

    orderList.add(cartList[cartIndex]);
    selectedStatus[0] = data.PENDING;
    filterOrdersByStatus();
    cartList.removeAt(cartIndex);
  }
}
