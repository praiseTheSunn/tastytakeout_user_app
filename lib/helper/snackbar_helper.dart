import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('$message'),
      duration: Duration(seconds: 2),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // You can add custom logic here when the action is pressed
        },
      ),
    ),
  );
}
