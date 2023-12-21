import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastytakeout_user_app/helper/format_helper.dart';
import '../../models/DTO/OrderModel.dart';
import '../../view_models/ListOrdersViewModel.dart';
import '../widgets/cart_item.dart';
import '../widgets/order_item.dart';
import 'order_payment_success.dart';

class OrderPaymentPage extends StatelessWidget {
  int index;
  late ListOrdersViewModel _listOrdersViewModel =
      Get.find<ListOrdersViewModel>();

  OrderPaymentPage({required this.index});

  int radioValue = 1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Payment'),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CartItemWidget(index: index, clickable: false),
              SizedBox(height: 20.0),
              Row(
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
                      Text('Text 1',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              color: Colors.green)),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
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
                      Text('Text 2',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              color: Colors.green)),
                    ],
                  ),
                ],
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
              Row(
                children: [
                  Radio(
                    value: 1,
                    groupValue: radioValue,
                    onChanged: (value) {
                      radioValue = value as int;
                    },
                  ),
                  Text('Chuyển khoản'),
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: 2,
                    groupValue: radioValue,
                    onChanged: (value) {
                      radioValue = value as int;
                    },
                  ),
                  Text('Tiền mặt'),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                children: [
                  Text(
                      'Tổng: ${formatMoney(_listOrdersViewModel.cartList[index].calculatePrice())}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.green)),
                ],
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                  onPressed: () {
                    Get.to(() => PaymentSuccessPage());
                  },
                  child: Text('Xác nhận')),
            ],
          ),
        ),
      ),
    );
  }
}
