import '/models/DTO/OrderModel.dart';
import 'package:flutter/cupertino.dart';

class OrderViewModel extends ChangeNotifier {
  final OrderModel _order;

  OrderViewModel(this._order);
}
