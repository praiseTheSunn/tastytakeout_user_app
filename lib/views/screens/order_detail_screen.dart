import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastytakeout_user_app/views/screens/store_infomation_screen.dart';
import '../../models/DTO/OrderModel.dart';
import '../../view_models/ListOrdersViewModel.dart';
import '../widgets/order_item.dart';
import '../widgets/payment_cart_items.dart';

class OrderDetailPage extends StatelessWidget {
  int index;
  late ListOrdersViewModel _listOrdersViewModel =
      Get.find<ListOrdersViewModel>();

  OrderDetailPage({required this.index});

  var radioValue = 0.obs;

  @override
  Widget build(BuildContext context) {
    if (_listOrdersViewModel.filteredOrderList[index].paymentMethod == "CASH") {
      radioValue.value = 1;
    } else {
      radioValue.value = 2;
    }

    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Chi tiết đơn'),
          centerTitle: true,
        ),
        body: GestureDetector(
          onTap: () {
            Get.to(() => StoreInfomationScreen(),
                arguments:
                    _listOrdersViewModel.filteredOrderList[index].storeId);
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    child: OrderItemWidget(index: index)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 20.0),
                      GestureDetector(
                        onTap: () {
                          print("Thay đổi địa chỉ");
                        },
                        child: Row(
                          children: [
                            Icon(Icons.pin_drop_sharp),
                            SizedBox(width: 8.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Địa chỉ giao hàng',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  _listOrdersViewModel
                                      .filteredOrderList[index].address,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.0),
                      GestureDetector(
                        onTap: () {
                          print("Thay đổi voucher");
                        },
                        child: Row(
                          children: [
                            Icon(Icons.card_giftcard),
                            SizedBox(width: 8.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Áp dụng voucher',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('Không áp dụng',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0,
                                        color: Colors.green)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        children: [
                          Icon(Icons.wallet),
                          SizedBox(width: 8.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hình thức thanh toán',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Obx(
                        () => RadioListTile<int>(
                          title: const Text('Chuyển khoản'),
                          value: 1,
                          groupValue: radioValue.value,
                          onChanged: (value) {},
                        ),
                      ),
                      Obx(
                        () => RadioListTile<int>(
                          title: const Text('Tiền mặt'),
                          value: 2,
                          groupValue: radioValue.value,
                          onChanged: (value) {},
                        ),
                      ),
                      SizedBox(height: 20.0)
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
        ));
  }
}
