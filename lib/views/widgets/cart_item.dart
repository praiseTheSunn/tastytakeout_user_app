import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastytakeout_user_app/views/screens/store_infomation_screen.dart';
import 'package:tastytakeout_user_app/views/widgets/cart_confirm_bottom_sheet.dart';
import 'package:tastytakeout_user_app/views/widgets/food_item.dart';

import '../../helper/format_helper.dart';
import '../../view_models/ListOrdersViewModel.dart';
import '../screens/order_payment_screen.dart';

class CartItemWidget extends GetWidget {
  int cartIndex;
  bool clickable = true;
  late ListOrdersViewModel _listOrdersViewModel =
      Get.find<ListOrdersViewModel>();

  CartItemWidget({required this.cartIndex, required this.clickable});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(0.0),
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
                        Get.to(() => StoreInfomationScreen(),
                            arguments: _listOrdersViewModel
                                .filteredCartList[cartIndex].storeId);
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 12.0),
                        child: Text(
                          '  🛒 ${_listOrdersViewModel.filteredCartList[cartIndex].storeName}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (clickable)
                      showCartPreviewBottomSheet(context, cartIndex);
                  },
                  child: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Colors.grey,
                      ),
                      child: Text('Sửa',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Colors.white,
                          ))),
                )
              ],
            ),
            SizedBox(height: 0.0),
            Obx(
              () => ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _listOrdersViewModel
                    .filteredCartList[cartIndex].foods.length,
                separatorBuilder: (context, index) {
                  return Divider(height: 1.0, color: Colors.grey);
                },
                itemBuilder: (context, foodIndex) {
                  return FoodItemWidget(
                      food: _listOrdersViewModel
                          .filteredCartList[cartIndex].foods[foodIndex]);
                },
              ),
            ),
            SizedBox(height: 10.0),
            Divider(height: 1.0, color: Colors.grey),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.only(left: 0.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0.0),
                      color: Colors.transparent,
                      border: Border.all(
                        color: Colors.transparent,
                        width: 0.0,
                      ),
                    ),
                    child: Text(
                      'Tổng tiền' +
                          ' : ' +
                          formatMoney(_listOrdersViewModel
                                  .filteredCartList[cartIndex]
                                  .calculatePrice())
                              .toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => OrderPaymentPage(cartIndex: cartIndex));
                    },
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0.0),
                        color: Colors.deepOrangeAccent,
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      child: Text(
                        'Thanh toán',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Divider(color: Colors.grey.shade300, height: 1.0),
          ],
        ),
      ),
    );

    // return GestureDetector(
    //   onTap: () {
    //     if (clickable) showCartPreviewBottomSheet(context, cartIndex);
    //   },
    //   child: Card(
    //     elevation: 4.0,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(12.0),
    //     ),
    //     color: Colors.white,
    //     child: Padding(
    //       padding: const EdgeInsets.all(12.0),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Obx(
    //             () => Text(
    //               '${_listOrdersViewModel.filteredCartList[cartIndex].storeName} - ${formatHelper.formatMoney(_listOrdersViewModel.filteredCartList[cartIndex].calculatePrice())}',
    //               style: TextStyle(
    //                 fontWeight: FontWeight.bold,
    //                 fontSize: 18.0,
    //                 color: Colors.black,
    //               ),
    //             ),
    //           ),
    //           SizedBox(height: 12.0),
    //           Obx(
    //             () => ListView.builder(
    //               shrinkWrap: true,
    //               physics: NeverScrollableScrollPhysics(),
    //               itemCount:
    //                   _listOrdersViewModel.filteredCartList[cartIndex].foods.length,
    //               itemBuilder: (context, foodIndex) {
    //                 return FoodItemWidget(
    //                     food: _listOrdersViewModel
    //                         .filteredCartList[cartIndex].foods[foodIndex]);
    //               },
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
