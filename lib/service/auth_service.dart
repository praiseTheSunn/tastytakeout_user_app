import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends GetxController {
  RxBool isLoggedIn = false.obs;

  Future<void> login() async {
    // Perform login logic here
    // For simplicity, let's assume login is successful
    isLoggedIn.value = true;

    // Save login status to shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', true);
  }

  Future<void> logout() async {
    isLoggedIn.value = false;

    // Clear login status in shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false);
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoggedIn.value = prefs.getBool('isLoggedIn') ?? false;
  }
}