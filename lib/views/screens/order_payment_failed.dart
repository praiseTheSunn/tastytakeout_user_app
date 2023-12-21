import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentFailedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            height: 200,
            child: Image.network(
              'https://c8.alamy.com/comp/2ABNAN7/green-check-mark-icon-in-a-circle-tick-symbol-in-green-color-2ABNAN7.jpg',
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Text View 1',
            style: TextStyle(fontSize: 20),
          ),
          Text(
            'Text View 2',
            style: TextStyle(fontSize: 20),
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
