import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:tastytakeout_user_app/models/dto/NotificationModel.dart';

import '../globals.dart';

class NotificationScreenViewModel extends GetxController {
  final BASE_URL = 'http://$serverIp/notifications/';
  String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxODg1OTUxNjI4LCJpYXQiOjE3MDQ1MTE2MjgsImp0aSI6IjU1MGFiOWU0MGM4MTQ2MDNhNmQxMjcxZjRiZjYxNmQ4IiwidXNlcl9pZCI6MTAsInJvbGUiOiJCVVlFUiJ9.Um--pPRWNG7VPh9F7ARYaRIn2Ab5yDvrpZvfsO9_9vA';
  var isLoading = false.obs;
  var notificationList = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      isLoading(true);
      var response = await get(
        Uri.parse(BASE_URL),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept-Charset': 'UTF-8',
          'Authorization': 'Bearer ' + token
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonBody = jsonDecode(utf8.decode(response.bodyBytes));
        notificationList.value = jsonBody.map((e) => NotificationModel.fromJson(e)).toList();
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }
}
