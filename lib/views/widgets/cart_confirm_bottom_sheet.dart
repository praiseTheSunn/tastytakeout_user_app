import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:tastytakeout_user_app/view_models/ListOrdersViewModel.dart';

import '../../helper/format_helper.dart' as formatHelper;
import '../../models/DTO/FoodModel.dart';

List<RxInt> quantityListObs = <RxInt>[];
List<int> deleteList = [];
Map<int, int> changeQuantityList = {};

void showCartPreviewBottomSheet(BuildContext context, int index) {
  showModalBottomSheet(
    context: context,
    builder: (context) => CartPreviewBottomSheet(cartIndex: index),
  );
}

class CartPreviewBottomSheet extends StatelessWidget {
  late final int cartIndex;
  ListOrdersViewModel listOrdersViewModel = Get.find<ListOrdersViewModel>();

  CartPreviewBottomSheet({required this.cartIndex});

  @override
  Widget build(BuildContext context) {
    quantityListObs.clear();
    changeQuantityList.clear();
    deleteList.clear();

    for (var i = 0;
        i < listOrdersViewModel.cartList[cartIndex].foods.length;
        i++) {
      quantityListObs.add(
          RxInt(listOrdersViewModel.cartList[cartIndex].foods[i].quantity));
      print("Quantity: " + quantityListObs[i].value.toString());
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 20.0),
          Expanded(
            child: SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: listOrdersViewModel.cartList[cartIndex].foods.length,
                itemBuilder: (context, foodIndex) {
                  return Column(
                    children: [
                      Dismissible(
                        key: Key(listOrdersViewModel
                            .cartList[cartIndex].foods[foodIndex].cartId
                            .toString()),
                        onDismissed: (direction) {
                          deleteList.add(listOrdersViewModel
                              .cartList[cartIndex].foods[foodIndex].cartId);
                        },
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          color: Colors.red,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.delete, size: 40),
                          ),
                        ),
                        child: FoodItemPreviewWidget(
                          food: listOrdersViewModel
                              .cartList[cartIndex].foods[foodIndex],
                          foodIndex: foodIndex,
                        ),
                      ),
                      SizedBox(height: 20.0),
                    ],
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Row(
            children: [
              Spacer(),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.deepOrangeAccent,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextButton(
                    onPressed: () {
                      changeQuantityList.forEach((key, value) {
                        // listOrdersViewModel.cartList[cartIndex].foods.firstWhere((element) => element.id == key).setQuantity(value);
                        var res =
                            listOrdersViewModel.updateQuantity(key, value);
                        if (res != null) {
                          res.then((value) {
                            if (value) {
                              Get.snackbar(
                                'Thành công',
                                'Cập nhật giỏ hàng thành công',
                                backgroundColor: Colors.green,
                                colorText: Colors.white,
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            } else {
                              Get.snackbar(
                                'Thất bại',
                                'Đã xảy ra lỗi',
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            }
                          });
                        }
                      });
                      deleteList.forEach((element) {
                        var res = listOrdersViewModel.deleteCart(element);
                        if (res != null) {
                          res.then((value) {
                            if (value) {
                              Get.snackbar(
                                'Thành công',
                                'Xóa sản phẩm khỏi giỏ hàng thành công',
                                backgroundColor: Colors.green,
                                colorText: Colors.white,
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            } else {
                              Get.snackbar(
                                'Thất bại',
                                'Đã xảy ra lỗi',
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            }
                          });
                        }
                      });
                      Get.toNamed('/cart', id: 1);
                    },
                    child: Text(
                      'Xác nhận',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.0),
        ],
      ),
    );
  }
}

class FoodItemPreviewWidget extends StatelessWidget {
  late FoodModel food;
  late int foodIndex;

  FoodItemPreviewWidget({
    required this.food,
    required this.foodIndex,
  });

  @override
  Widget build(BuildContext context) {
    String imageUrl = food.imageUrls[0];
    String name = food.name;
    String quantityText = ' X${food.quantity}';
    String cost = formatHelper.formatMoney(food.price);

    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.white,
        ),
        padding: EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  width: 80.0,
                  height: 80.0,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            // Left side with 3 lines of text
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: Colors.black, // Adjust color as needed
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      cost, // Display cost here
                      style: TextStyle(
                        color: Colors.black87, // Adjust color as needed
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: InputQty.int(
                minVal: 1,
                initVal: quantityListObs[foodIndex].value,
                onQtyChanged: (value) {
                  if (value != quantityListObs[foodIndex].value) {
                    changeQuantityList[food.cartId] = value;
                  } else {
                    changeQuantityList.remove(food.cartId);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
    //   GestureDetector(
    //   child: Card(
    //     elevation: 4.0,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(12.0),
    //     ),
    //     color: Colors.green[100],
    //     child: Row(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Container(
    //           width: 80.0,
    //           height: 80.0,
    //           decoration: BoxDecoration(
    //             borderRadius: BorderRadius.only(
    //               topLeft: Radius.circular(12.0),
    //               bottomLeft: Radius.circular(12.0),
    //             ),
    //             image: DecorationImage(
    //               image: NetworkImage(imageUrl),
    //               fit: BoxFit.cover,
    //             ),
    //           ),
    //         ),
    //         // Left side with 3 lines of text
    //         Expanded(
    //           child: Padding(
    //             padding: const EdgeInsets.all(12.0),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 RichText(
    //                   text: TextSpan(
    //                     children: [
    //                       TextSpan(
    //                         text: name,
    //                         style: TextStyle(
    //                           fontWeight: FontWeight.bold,
    //                           fontSize: 16.0,
    //                           color: Colors.black, // Adjust color as needed
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //                 SizedBox(height: 8.0),
    //                 Text(
    //                   cost, // Display cost here
    //                   style: TextStyle(
    //                     color: Colors.black87, // Adjust color as needed
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //         Container(
    //           child: Padding(
    //             padding: const EdgeInsets.all(12.0),
    //             child: Column(
    //               children: [
    //                 Obx(() {
    //                   return Row(
    //                     children: [
    //                       // "-" button to decrease quantity
    //                       IconButton(
    //                         onPressed: () {
    //                           if (quantityListObs[foodIndex].value > 1) {
    //                             quantityListObs[foodIndex].value--;
    //                           }
    //                         },
    //                         icon: Icon(Icons.remove),
    //                       ),
    //                       // Display quantity
    //                       Text(
    //                         ' X${quantityListObs[foodIndex].value}',
    //                         style: TextStyle(
    //                           fontWeight: FontWeight.bold,
    //                           fontSize: 16.0,
    //                           color: Colors.green, // Adjust color as needed
    //                         ),
    //                       ),
    //                       // "+" button to increase quantity
    //                       IconButton(
    //                         onPressed: () {
    //                           quantityListObs[foodIndex].value++;
    //                         },
    //                         icon: Icon(Icons.add),
    //                       ),
    //                     ],
    //                   );
    //                 }),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
