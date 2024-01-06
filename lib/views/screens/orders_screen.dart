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

  @override
  void onInit() {
    super.onInit();
    listOrdersViewModel.fetchOrders();
    listOrdersViewModel.selectedStatus = [data.PENDING];
    listOrdersViewModel.filterOrdersByStatus();
  }

  @override
  void onReady() {
    super.onReady();
    listOrdersViewModel.fetchOrders();
    listOrdersViewModel.filterOrdersByStatus();
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

  @override
  void initState() {
    super.initState();
    _ordersController.listOrdersViewModel.fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          margin: EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _ordersController.listOrdersViewModel.OrderStatus
                  .map((type) => Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 8.0, 0),
                        child: FilterChip(
                          selected: _ordersController
                              .listOrdersViewModel.selectedStatus
                              .contains(type),
                          label: Text(type),
                          onSelected: (selected) {
                            setState(() {
                              _ordersController
                                  .listOrdersViewModel.selectedStatus
                                  .clear();
                              _ordersController
                                  .listOrdersViewModel.selectedStatus
                                  .add(type);
                              _ordersController.listOrdersViewModel
                                  .filterOrdersByStatus();
                            });
                          },
                        ),
                      ))
                  .toList(),
            ),
          ),
        ),
        Expanded(
          child: Obx(
            () {
              if (_ordersController.listOrdersViewModel.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView.builder(
                  padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                  itemCount: _ordersController
                      .listOrdersViewModel.filteredOrderList.length,
                  itemBuilder: (context, index) {
                    return OrderItemWidget(index: index);
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

/*
CircularProgressIndicator()
 */
