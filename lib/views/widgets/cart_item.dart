import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:tastytakeout_user_app/models/DTO/OrderModel.dart';
import 'package:tastytakeout_user_app/views/widgets/food_item.dart';
import 'package:tastytakeout_user_app/helper/format_helper.dart'
    as formatHelper;
import 'package:tastytakeout_user_app/views/widgets/order_confirm_bottom_sheet.dart';
import '../../view_models/ListOrdersViewModel.dart';
import '../screens/order_detail_screen.dart';

class CartItemWidget extends GetWidget {
  int index;
  bool clickable = true;
  late ListOrdersViewModel _listOrdersViewModel =
      Get.find<ListOrdersViewModel>();
  late OrderModel order;

  CartItemWidget({required this.index, required this.clickable}) {
    order = _listOrdersViewModel.cartList[index];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (clickable) showOrderPreviewBottomSheet(context, index);
      },
      child: Card(
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
                '${order.storeName} - ${formatHelper.formatMoney(order.calculatePrice())}',
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
                itemCount: order.foods.length,
                itemBuilder: (context, index) {
                  return FoodItemWidget(food: order.foods[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
