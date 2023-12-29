import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/custom_drawer.dart';

class PaymentFailedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Thanh toán",
      ),
      drawer: CustomDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 100),
          Container(
            width: double.infinity,
            height: 150,
            child: Image.asset(
              "lib/resources/payment_info/failure.png",
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Thanh toán thất bại!',
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          Text(
            'Hãy thử thanh toán lại',
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Quay về'),
          ),
        ],
      ),
    );
  }
}
