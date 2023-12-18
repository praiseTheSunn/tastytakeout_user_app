import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastytakeout_user_app/data_sources/hardcode.dart' as data;
import 'package:tastytakeout_user_app/view_models/ListOrdersViewModel.dart';
import 'package:tastytakeout_user_app/views/widgets/item_order.dart';

class OrdersController extends GetxController {
  final title = 'Orders'.obs;
}

class OrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ListOrdersViewModel());
    Get.lazyPut(() => OrdersController());
  }
}

class _OrdersPageState extends State<OrdersPage> {
  final _listOrdersViewModel = Get.find<ListOrdersViewModel>();
  final _ordersController = Get.find<OrdersController>();

  final List<String> types = [data.Prepare, data.Pending, data.Completed];
  final selectedTypes = [data.Prepare].obs;

  @override
  void initState() {
    super.initState();
    _listOrdersViewModel.fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          AppBar(
            title: Obx(() => Container(
                  margin: EdgeInsets.only(top: 8.0),
                  child: Text(_ordersController.title.value),
                )),
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          Container(
              padding: EdgeInsets.all(8.0),
              margin: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: types
                    .map((type) => Obx(() => FilterChip(
                        selected: selectedTypes.contains(type),
                        label: Text(type),
                        onSelected: (selected) {
                          selectedTypes.clear();
                          selectedTypes.add(type);
                        })))
                    .toList(),
              )),
          Expanded(
            child: Obx(
              () => ListView.builder(
                padding: EdgeInsets.fromLTRB(20, 0.0, 20, 20),
                itemCount: _listOrdersViewModel
                    .getOrdersByStatus(selectedTypes.value.first)
                    .length,
                itemBuilder: (context, index) {
                  return OrderItemWidget(
                      order: _listOrdersViewModel
                          .getOrdersByStatus(selectedTypes.value.first)[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}
