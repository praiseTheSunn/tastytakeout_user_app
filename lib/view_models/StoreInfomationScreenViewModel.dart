import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart';

import '../models/dto/StoreModel.dart';
import 'package:tastytakeout_user_app/globals.dart';

class StoreInfomationScreenViewModel extends GetxController {
  var storeId = -1.obs;
  var isLoading = true.obs;
  var storeInfo = StoreModel(
    id: 0,
    name: '',
    address: '',
    imgUrl: '',
    foods: [],
    isLike: false,
    likers_count: 0,
  ).obs;
  final BASE_URL = 'http://$serverIp/stores/';

  StoreInfomationScreenViewModel({required this.storeId});

  @override
  void onInit() {
    fetchStoreInfo();
    super.onInit();
  }

  Future<void> fetchStoreInfo() async {
    try {
      isLoading(true);
      final response = await get(
        Uri.parse('$BASE_URL$storeId'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept-Charset': 'UTF-8',
        },
      );
      if (response.statusCode != 200) {
        throw Exception('Error fetching food detail');
      } else {
        print(response.body);
        storeInfo.value = StoreModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      }
    } catch (e) {
      print('Error in fetchFoodDetail ' + e.toString());
    } finally {
      print(storeInfo);
      print(storeInfo.value.name);
      isLoading(false);
    }
  }
}

