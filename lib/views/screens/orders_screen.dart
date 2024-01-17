import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastytakeout_user_app/data_sources/hardcode.dart' as data;
import 'package:tastytakeout_user_app/main.dart';
import 'package:tastytakeout_user_app/view_models/ListOrdersViewModel.dart';
import 'package:tastytakeout_user_app/views/widgets/custom_app_bar.dart';
import 'package:tastytakeout_user_app/views/widgets/custom_drawer.dart';
import 'package:tastytakeout_user_app/views/widgets/order_item.dart';

import '../../globals.dart';

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
      backgroundColor: Colors.grey[200],
      appBar: CustomAppBar(title: 'Đơn hàng'),
      drawer: CustomDrawer(),
      body: Container(
        decoration: BoxDecoration(
          border: Border.fromBorderSide(
            BorderSide(
              color: Colors.grey.shade300,
              width: 0.0,
            ),
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25.0),
            bottomRight: Radius.circular(25.0),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25.0),
            bottomRight: Radius.circular(25.0),
          ),
          child: OrdersView(),
        ),
      ),
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
        ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8.0),
            bottomRight: Radius.circular(8.0),
          ),
          child: Container(
            color: mainColor,
            //padding: EdgeInsets.all(8.0),
            //margin: EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _ordersController.listOrdersViewModel.OrderStatus
                    .map((type) => Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 8.0, 0),
                          child: FilterChip(
                            selected: _ordersController
                                .listOrdersViewModel.selectedStatus
                                .contains(type),
                            label: Text(
                              data.mapStatus[type]!,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            selectedColor: secondaryColor,
                            backgroundColor: mainColor,
                            elevation: 0.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            onSelected: (selected) {
                              setState(() {
                                _ordersController
                                    .listOrdersViewModel.selectedStatus
                                    .clear();
                                _ordersController
                                    .listOrdersViewModel.selectedStatus
                                    .add(type);
                                _ordersController.listOrdersViewModel
                                    .fetchOrders();
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
        ),
        Expanded(
          child: Obx(
            () {
              if (_ordersController.listOrdersViewModel.isLoading.value ||
                  _ordersController
                      .listOrdersViewModel.filteredOrderList.isEmpty) {
                String notification = '';
                if (_ordersController.listOrdersViewModel.isLoading.value) {
                  notification = 'Đang tải dữ liệu...';
                } else if (_ordersController
                    .listOrdersViewModel.filteredOrderList.isEmpty) {
                  notification = 'Bạn chưa có đơn hàng nào!';
                }
                return RefreshIndicator(
                  onRefresh: () async {
                    _ordersController.listOrdersViewModel.fetchOrders();
                    _ordersController.listOrdersViewModel
                        .filterOrdersByStatus();
                  },
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'lib/resources/gif/loading.gif',
                        width: 150,
                        height: 150,
                      ),
                      Text(
                        notification,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )),
                );
              } else {
                return RefreshIndicator(
                    onRefresh: () async {
                      _ordersController.listOrdersViewModel.fetchOrders();
                      _ordersController.listOrdersViewModel
                          .filterOrdersByStatus();
                    },
                    child: ListView.builder(
                      padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
                      itemCount: _ordersController
                          .listOrdersViewModel.filteredOrderList.length,
                      //reverse: true,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            OrderItemWidget(index: index),
                            SizedBox(height: 8.0),
                          ],
                        );
                      },
                    ));
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
