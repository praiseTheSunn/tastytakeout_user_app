import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/DTO/OrderModel.dart';
import '../../view_models/ListOrdersViewModel.dart';
import '../widgets/order_item.dart';

class OrderDetailPage extends StatelessWidget {
  int index;
  late ListOrdersViewModel _listOrdersViewModel =
      Get.find<ListOrdersViewModel>();

  OrderDetailPage({required this.index});

  int radioValue = 1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text('My App'),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              OrderItemWidget(index: index, isClickable: false),
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
                      Text('Text 1'),
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
                      Text('Text 2'),
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
              SizedBox(height: 20.0)
            ],
          ),
        ),
      ),
    );
  }
}
