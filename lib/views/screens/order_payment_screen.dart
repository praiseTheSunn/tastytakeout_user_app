import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastytakeout_user_app/helper/format_helper.dart';
import 'package:tastytakeout_user_app/views/screens/order_payment_failure.dart';
import 'package:tastytakeout_user_app/views/widgets/payment_cart_items.dart';
import '../../data_sources/cart_source.dart';
import '../../data_sources/order_source.dart';
import '../../view_models/ListOrdersViewModel.dart';
import '../widgets/cart_item.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_drawer.dart';
import 'order_payment_success.dart';
import 'package:tastytakeout_user_app/data_sources/hardcode.dart' as data;

class OrderPaymentPage extends StatelessWidget {
  int cartIndex;
  late ListOrdersViewModel _listOrdersViewModel =
      Get.find<ListOrdersViewModel>();

  OrderPaymentPage({required this.cartIndex});

  var radioValue = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Thanh toán'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PaymentCardItem(cartIndex: cartIndex, clickable: false),
              SizedBox(height: 30.0),
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
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0),
                        ),
                        Text(
                          data.userModel.getAddress(),
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
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
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
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0),
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
                  onChanged: (value) {
                    radioValue.value = value!;
                    _listOrdersViewModel.cartList[cartIndex].paymentMethod =
                        'BANKING';
                  },
                ),
              ),
              Obx(
                () => RadioListTile<int>(
                  title: const Text('Tiền mặt'),
                  value: 2,
                  groupValue: radioValue.value,
                  onChanged: (value) {
                    radioValue.value = value!;
                    _listOrdersViewModel.cartList[cartIndex].paymentMethod =
                        'CASH';
                  },
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                children: [
                  Text(
                      'Tổng: ${formatMoney(_listOrdersViewModel.cartList[cartIndex].calculatePrice())}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.green)),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                children: [
                  SizedBox(width: 10.0),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextButton(
                        onPressed: () async {
                          //_listOrdersViewModel.exportFromCartToOrder(cartIndex);
                          _listOrdersViewModel.cartList[cartIndex];
                          var result = await OrdersSource().addOrder(
                              _listOrdersViewModel.cartList[cartIndex]);

                          if (result) {
                            CartSource().deleteCart(
                                _listOrdersViewModel.cartList[cartIndex].foods);
                            _listOrdersViewModel.cartList.removeAt(cartIndex);
                            Navigator.pop(context);
                            Get.to(() => PaymentSuccessPage());
                          } else {
                            Navigator.pop(context);
                            Get.to(() => PaymentFailedPage());
                          }
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
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
