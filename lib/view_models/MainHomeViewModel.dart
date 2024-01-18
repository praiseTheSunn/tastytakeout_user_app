import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:tastytakeout_user_app/data_sources/food_source.dart';
import 'package:tastytakeout_user_app/globals.dart';
import 'package:tastytakeout_user_app/models/dto/EventModel.dart';

class MainHomeViewModel extends GetxController {
  final FoodSource _popularFoodSource = FoodSource();
  var popularFoodImagesUrls = RxList<String>();
  var eventInformation = RxList<EventModel>();
  var eventImagesUrls = RxList<String>();
  final BASEURL = 'http://$serverIp/';

  @override
  void onInit() {
    super.onInit();
    fetchPopularFoodImagesUrls();
    fetchEventImageUrls();
    update();
  }

  Future<void> fetchEventImageUrls() async {
    print('fetchEventImageUrls');
    try {
      final response = await get(
        Uri.parse(BASEURL + 'events/'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept-Charset': 'UTF-8',
        },
      );
      if (response.statusCode != 200) {
        throw Exception('Error fetching event list');
      } else {
        List<dynamic> json = jsonDecode(utf8.decode(response.bodyBytes));
        print(json);
        eventInformation.value = json.map((e) => EventModel.fromJson(e)).toList();
        for (int i = 0; i < eventInformation.length; i++) {
          eventInformation[i].translateVoucher();
        }
        eventImagesUrls.value = eventInformation.map((e) => e.imageUrl).toList();
      }
    } catch (e) {
      print('Error in fetchEventImageUrls ' + e.toString());
    } finally {

    }
  }


  Future<void> fetchPopularFoodImagesUrls() async {
    try {
      Iterable imageUrls = await _popularFoodSource.getPopularFoodImages(4.0);
      popularFoodImagesUrls.value = imageUrls.toList().map((e) => e.toString()).toList().obs;
    } catch (e) {
      // Handle errors or exceptions here
      print('Error in fetchPopularFoodImagesUrls: $e');
    }
  }
}
