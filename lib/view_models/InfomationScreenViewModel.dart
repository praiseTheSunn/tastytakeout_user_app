import 'package:get/get.dart';
import 'package:tastytakeout_user_app/models/DTO/UserModel.dart';

class InformationScreenViewModel extends GetxController {
  var userInfo = UserModel().obs;

  @override
  void onInit() {
    super.onInit();
    updateUserInfoFromLocal();
  }

  void updateUserInfo(UserModel user) {
    userInfo.value = user;
  }

  void updateUserInfoFromLocal() {
    userInfo.value = UserModel.fromJson(Get.arguments);
  }
}
