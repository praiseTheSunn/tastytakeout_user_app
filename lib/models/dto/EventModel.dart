import 'package:flutter/foundation.dart';

class EventModel {
  int id;
  // List<dynamic> voucher;
  String imageUrl;
  String name;
  String description;
  String start_date;
  String end_date;


  EventModel({
    required this.id,
    // required this.voucher,
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.start_date,
    required this.end_date,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      // voucher: json['voucher'],
      imageUrl: json['imageUrl'],
      name: json['name'],
      description: json['description'],
      start_date: json['begin'],
      end_date: json['end'],
    );
  }
}