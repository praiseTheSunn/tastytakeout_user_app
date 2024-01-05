import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastytakeout_user_app/data_sources/hardcode.dart' as data;
import 'package:tastytakeout_user_app/view_models/ListOrdersViewModel.dart';
import 'package:tastytakeout_user_app/views/widgets/custom_app_bar.dart';
import 'package:tastytakeout_user_app/views/widgets/custom_drawer.dart';
import 'package:tastytakeout_user_app/views/widgets/order_item.dart';

class OrdersController extends GetxController {
  final title = 'Orders'.obs;
  final ListOrdersViewModel listOrdersViewModel = Get.find();
  final List<String> OrderStatus = [data.Prepare, data.Pending, data.Completed];
  List<String> selectedStatus = [data.Prepare];

  @override
  void onInit() {
    super.onInit();
    selectedStatus = [data.Prepare];
    listOrdersViewModel.fetchOrders();
    listOrdersViewModel.filterOrdersByStatus(selectedStatus[0]);
  }

  @override
  void onReady() {
    super.onReady();
    selectedStatus = [data.Prepare];
    listOrdersViewModel.fetchOrders();
    listOrdersViewModel.filterOrdersByStatus(selectedStatus[0]);
  }
}

class OrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ListOrdersViewModel());
    Get.lazyPut(() => OrdersController());
  }
}

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Orders'),
      drawer: CustomDrawer(),
      body: OrdersView(),
    );
  }
}

class OrdersView extends StatefulWidget {
  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  final OrdersController _ordersController = Get.find<OrdersController>();
  late List<String> types;
  late List<String> selectedTypes;

  @override
  void initState() {
    super.initState();
    _ordersController.listOrdersViewModel.fetchOrders();
    types = _ordersController.OrderStatus;
    selectedTypes = _ordersController.selectedStatus;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: types
                  .map((type) => FilterChip(
                      selected: selectedTypes.contains(type),
                      label: Text(type),
                      onSelected: (selected) {
                        setState(() {
                          selectedTypes.clear();
                          selectedTypes.add(type);
                          _ordersController.listOrdersViewModel
                              .filterOrdersByStatus(type);
                        });
                      }))
                  .toList(),
            )),
        Expanded(
          child: Obx(
            () => ListView.builder(
              padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
              itemCount: _ordersController
                  .listOrdersViewModel.filteredOrderList.length,
              itemBuilder: (context, index) {
                return OrderItemWidget(index: index);
              },
            ),
          ),
        ),
      ],
    );
  }
}
