import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tastytakeout_user_app/data_sources/user_source.dart';

class AuthService extends GetxController {
  RxBool isLoggedIn = false.obs;
  String token = '';
  UserSource userSource = UserSource();

  Future<bool> login(String username, String password) async {
    // Perform login logic here
    // For simplicity, let's assume login is successful
    isLoggedIn.value = true;

    // Get access token from server
    token = await userSource.getAccessTokenByLogin(username, password);

    if (token == '') {
      return false;
    }

    // Save login status to shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('token', token);
    return true;
  }

  Future<void> logout() async {
    isLoggedIn.value = false;

    // Clear login status in shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs.setString('token', '');
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? value = await prefs.getBool('isLoggedIn');
    String? tempToken = await prefs.getString('token');
    isLoggedIn.value = value ?? false;
    token = tempToken ?? '';
  }
}