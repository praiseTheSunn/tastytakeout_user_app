import 'package:get/get.dart';
import 'package:tastytakeout_user_app/models/DTO/OrderModel.dart';
import 'package:tastytakeout_user_app/data_sources/hardcode.dart' as data;

class ListOrdersViewModel extends GetxController {
  var orderList = <OrderModel>[].obs;
  var filteredOrderList = <OrderModel>[].obs;
  var cartList = <OrderModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future<void> fetchOrders() async {
    var orders = data.orders;

    if (orders != null) {
      orderList.value = orders;
      filteredOrderList.value = [];
    }
  }

  Future<void> fetchCart() async {
    var orders = data.orders;

    if (orders != null) {
      cartList.value = orders;
    }
  }

  void filterOrdersByStatus(String status) {
    filteredOrderList.value =
        orderList.where((order) => order.status == status).toList();
  }

  void addToCart(OrderModel item) {
    cartList.add(item);
  }

  void clearCart() {
    cartList.clear();
  }
}
