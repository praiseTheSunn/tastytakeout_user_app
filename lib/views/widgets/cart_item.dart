import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:tastytakeout_user_app/models/DTO/OrderModel.dart';
import 'package:tastytakeout_user_app/views/widgets/food_item.dart';
import 'package:tastytakeout_user_app/helper/format_helper.dart'
    as formatHelper;
import 'package:tastytakeout_user_app/views/widgets/cart_confirm_bottom_sheet.dart';
import '../../view_models/ListOrdersViewModel.dart';
import '../screens/order_detail_screen.dart';

class CartItemWidget extends GetWidget {
  int cartIndex;
  bool clickable = true;
  late ListOrdersViewModel _listOrdersViewModel =
      Get.find<ListOrdersViewModel>();

  CartItemWidget({required this.cartIndex, required this.clickable});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (clickable) showCartPreviewBottomSheet(context, cartIndex);
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
              Obx(
                () => Text(
                  '${_listOrdersViewModel.cartList[cartIndex].storeName} - ${formatHelper.formatMoney(_listOrdersViewModel.cartList[cartIndex].calculatePrice())}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 12.0),
              Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount:
                      _listOrdersViewModel.cartList[cartIndex].foods.length,
                  itemBuilder: (context, foodIndex) {
                    return FoodItemWidget(
                        food: _listOrdersViewModel
                            .cartList[cartIndex].foods[foodIndex]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
