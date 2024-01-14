import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastytakeout_user_app/views/widgets/food_item.dart';
import 'package:tastytakeout_user_app/helper/format_helper.dart'
    as formatHelper;

import '../../models/DTO/OrderModel.dart';
import '../../view_models/ListOrdersViewModel.dart';
import '../screens/order_detail_screen.dart';
import 'order_food_items.dart';

class OrderItemWidget extends GetWidget {
  int index;
  final bool isClickable;
  late ListOrdersViewModel _listOrdersViewModel =
      Get.find<ListOrdersViewModel>();

  OrderItemWidget({
    required this.index,
    this.isClickable = true,
  });

  @override
  Widget build(BuildContext context) {
    if (_listOrdersViewModel.filteredOrderList.isEmpty ||
        index >= _listOrdersViewModel.filteredOrderList.length) {
      return Container();
    }

    return GestureDetector(
        onTap: () {
          if (!isClickable) return;
          Get.to(() => OrderDetailPage(index: index));
        },
        child: Obx(
          () => Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${_listOrdersViewModel.filteredOrderList[index].storeName} - ${formatHelper.formatMoney(_listOrdersViewModel.filteredOrderList[index].calculatePrice())}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 12.0),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _listOrdersViewModel
                        .filteredOrderList[index].foods.length,
                    itemBuilder: (context, foodIndex) {
                      return Container(
                       margin: EdgeInsets.only(bottom: 8.0),
                        child: OrderFoodItemWidget(
                            food: _listOrdersViewModel
                                .filteredOrderList[index].foods[foodIndex]),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
