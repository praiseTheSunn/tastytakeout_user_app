import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tastytakeout_user_app/data_sources/user_source.dart';

import 'package:http/http.dart' as http;
import 'package:tastytakeout_user_app/globals.dart';

class AuthService extends GetxController {
  RxBool isLoggedIn = false.obs;
  String token = '';
  final loginUrl = Uri.http(serverIp, '/users/login');
  final signUpUrl = Uri.http(serverIp, '/users/register');

  Future<String> getAccessTokenByLogin(String username, String password) async {
    final responseLogin = await http.post(
      loginUrl,
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );
    if (responseLogin.statusCode != 200) {
      print('Request failed with status: ${responseLogin.statusCode}');
      return '';
    }

    String accessToken = jsonDecode(responseLogin.body)['access'];
    print('Access token: $accessToken');
    return accessToken;
  }

  Future<bool> login(String username, String password) async {
    // Perform login logic here
    // For simplicity, let's assume login is successful
    isLoggedIn.value = true;

    // Get access token from server
    token = await getAccessTokenByLogin(username, password);

    if (token == '') {
      return false;
    }

    // Save login status to shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('token', token);
    print(token);
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

  Future<bool> signUp(String username, String password) async {
    final response = await http.post(
      signUpUrl,
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
        'role': 'BUYER',
      }),
    );
    if (response.statusCode != 201) {
      print('Request failed with status: ${response.statusCode}');
      return Future.value(false);
    }

    return Future.value(true);
  }
}