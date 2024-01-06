import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastytakeout_user_app/helper/format_helper.dart';
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
      appBar: CustomAppBar(
        title: "Thanh toán",
      ),
      drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CartItemWidget(cartIndex: cartIndex, clickable: false),
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
                        style: TextStyle(fontWeight: FontWeight.bold),
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
                onChanged: (value) {
                  radioValue.value = value!;
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
            ElevatedButton(
                onPressed: () {
                  _listOrdersViewModel.exportFromCartToOrder(cartIndex);
                  Navigator.pop(context);
                  Get.to(() => PaymentSuccessPage());
                },
                child: const Text('Xác nhận')),
          ],
        ),
      ),
    );
  }
}
