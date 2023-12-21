import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastytakeout_user_app/data_sources/hardcode.dart' as data;
import 'package:tastytakeout_user_app/view_models/ListOrdersViewModel.dart';
import 'package:tastytakeout_user_app/views/widgets/custom_app_bar.dart';
import 'package:tastytakeout_user_app/views/widgets/custom_drawer.dart';
import 'package:tastytakeout_user_app/views/widgets/order_item.dart';

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
  late ListOrdersViewModel _listOrdersViewModel;

  final List<String> types = [data.Prepare, data.Pending, data.Completed];
  List<String> selectedTypes = [data.Prepare];

  @override
  void initState() {
    super.initState();
    _listOrdersViewModel = Get.find<ListOrdersViewModel>();
    _listOrdersViewModel.fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Orders",
      ),
      drawer: CustomDrawer(),
      body: Column(
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
                            _listOrdersViewModel.filterOrdersByStatus(type);
                          });
                        }))
                    .toList(),
              )),
          Expanded(
            child: Obx(
              () => ListView.builder(
                padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                itemCount: _listOrdersViewModel.filteredOrderList.length,
                itemBuilder: (context, index) {
                  return OrderItemWidget(index: index);
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
