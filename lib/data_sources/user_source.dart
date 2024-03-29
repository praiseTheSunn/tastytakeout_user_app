import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tastytakeout_user_app/globals.dart';
import 'package:tastytakeout_user_app/models/DTO/UserModel.dart';
import 'package:tastytakeout_user_app/service/auth_service.dart';
import '../data_sources/hardcode.dart' as data;

class UserSource {
  final baseUrl = Uri.http(serverIp, '/users/');
  final loginUrl = Uri.http(serverIp, '/users/login/');
  final AuthService authService = Get.put(AuthService());

  /* Example JSON response:
         {
          "id": 10,
          "username": "123",
          "email": "user@example.com",
          "avatar_url": "https://sm.ign.com/ign_nordic/cover/a/avatar-gen/avatar-generations_prsz.jpg",
          "name": "Hoàng Thị Hồng",
          "bio": "An Phong, thường được biết đến với nghệ danh Lưu Diệc Phi (tiếng Trung: 刘亦菲; bính âm: Liú Yìfēi; tiếng Anh: Crystal Liu, sinh ngày 25 tháng 8 năm 1987), là một nữ diễn viên kiêm ca sĩ người Mỹ gốc Hoa. Cô đã nhiều lần xuất hiện trong danh sách 100 ngôi sao nổi tiếng nhất Trung Quốc theo Forbes và được vinh danh là một trong Tứ Tiểu Hoa Đán của Trung Quốc vào năm 2009.[1] Cô được biết đến rộng rãi với biệt danh \"Thần tiên tỷ tỷ\" ở Trung Quốc.[2][3]",
          "address": "Trung Quốc",
          "date_of_birth": "2000-12-30T08:55:34.754000Z",
          "gender": "MALE"
        }
          */

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

  Future<String> getAccessToken() async {
    // get access token from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';

    // final responseLogin = await http.post(
    //   loginUrl,
    //   headers: {
    //     'accept': 'application/json',
    //     'Content-Type': 'application/json',
    //   },
    //   body: jsonEncode(<String, String>{
    //     'username': '123',
    //     'password': '1234',
    //   }),
    // );

    // String accessToken = jsonDecode(responseLogin.body)['access'];
    // print('Access token: $accessToken');
    // return accessToken;
  }

  Future<UserModel> getUserInfo() async {
    try {
      final response = await http.get(
        baseUrl,
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer ${await getAccessToken()}',
        },
      );

      if (response.statusCode == 200) {
        var jsonString = utf8.decode(response.bodyBytes);
        var jsonMap = jsonDecode(jsonString);
        data.userModel = UserModel.fromJson(jsonMap);
        return data.userModel;
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception during request User: $e');
    }
    return UserModel();
  }

  Future<http.Response> patchUserInfo(UserModel _userModel) async {
    try {
      final response = await http.patch(
        baseUrl,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${await getAccessToken()}',
        },
        body: jsonEncode(_userModel.toMapJson()),
      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return response;
    } catch (e) {
      print('Exception during POST request: $e');
      return http.Response('Error during request', 500);
    }
  }
}
