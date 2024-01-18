import 'package:flutter/foundation.dart';

class EventModel {
  int id;
  List<dynamic> voucher;
  List<Voucher> translatedVoucher = [];
  String imageUrl;
  String name;
  String description;
  String start_date;
  String end_date;


  EventModel({
    required this.id,
    required this.voucher,
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.start_date,
    required this.end_date,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      voucher: json['vouchers'],
      imageUrl: json['imageUrl'],
      name: json['name'],
      description: json['description'],
      start_date: json['begin'],
      end_date: json['end'],
    );
  }

  void translateVoucher() {
    for (var i = 0; i < voucher.length; i++) {
      translatedVoucher.add(Voucher.fromJson(voucher[i]));
    }
  }
}

class Voucher {
  final int id;
  final String name;
  final String code;
  final String description;
  int quantity;
  int used_quantity;
  int max_price;
  int min_price;
  int discount_amount;
  String discount_type;

  Voucher({
    required this.id,
    required this.name,
    required this.code,
    required this.description,
    required this.quantity,
    required this.used_quantity,
    required this.max_price,
    required this.min_price,
    required this.discount_amount,
    required this.discount_type,
  });

  factory Voucher.fromJson(Map<String, dynamic> json) {
    return Voucher(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      description: json['description'],
      quantity: json['quantity'],
      used_quantity: json['used_quantity'],
      max_price: json['max_price'],
      min_price: json['min_price'],
      discount_amount: json['discount_amount'],
      discount_type: json['discount_type'],
    );
  }
}