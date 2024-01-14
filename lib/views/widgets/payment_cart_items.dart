import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastytakeout_user_app/views/screens/store_infomation_screen.dart';
import 'package:tastytakeout_user_app/views/widgets/cart_confirm_bottom_sheet.dart';
import 'package:tastytakeout_user_app/views/widgets/food_item.dart';

import '../../view_models/ListOrdersViewModel.dart';
import '../screens/order_payment_screen.dart';

class PaymentCardItem extends GetWidget {
  int cartIndex;
  bool clickable = true;
  late ListOrdersViewModel _listOrdersViewModel =
  Get.find<ListOrdersViewModel>();

  PaymentCardItem({required this.cartIndex, required this.clickable});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Obx(
                        () => GestureDetector(
                      onTap: () {
                        Get.to(() => StoreInfomationScreen(),arguments: _listOrdersViewModel.cartList[cartIndex].storeId);
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 12.0),
                        child: Text(
                          '${_listOrdersViewModel.cartList[cartIndex].storeName} >',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.0),
            Obx(
                  () => ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount:
                _listOrdersViewModel.cartList[cartIndex].foods.length,
                separatorBuilder: (context, index) {
                  return Divider(height: 1.0, color: Colors.grey);
                },
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
    );
  }
}
