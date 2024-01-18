import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastytakeout_user_app/service/auth_service.dart';

import '../../data_sources/hardcode.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  final AuthService authService = Get.put(AuthService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Đăng ký'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sign Up!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            // TextField(
            //   controller: _usernameController,
            //   decoration: InputDecoration(
            //     labelText: 'Username',
            //   ),
            // ),
            // SizedBox(height: 16.0),
            TextField(
              controller: _phoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Số điện thoại',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Mật khẩu',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Xác nhận mật khẩu',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                if (_phoneNumberController.text.isEmpty ||
                    _passwordController.text.isEmpty ||
                    _confirmPasswordController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Lỗi: Vui lòng nhập đầy đủ thông tin'),
                      duration: Duration(seconds: 2), // Set the duration here]
                      backgroundColor: Color.fromARGB(255, 223, 129, 129),
                    ),
                  );
                  return;
                }
                else if (_passwordController.text != _confirmPasswordController.text) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Lỗi: Mật khẩu xác nhận không khớp'),
                      duration: Duration(seconds: 2), // Set the duration here]
                      backgroundColor: Color.fromARGB(255, 223, 129, 129),
                    ),
                  );
                  return;
                }
                // Add logic for sign-up button
                print('Sign Up: ${_phoneNumberController.text}, ${_passwordController.text}, ${_confirmPasswordController.text}');
                
                bool isSuccessful = await authService.signUp(_phoneNumberController.text, _passwordController.text);
                if (isSuccessful) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Đăng ký thành công!'),
                      duration: Duration(seconds: 2), // Set the duration here]
                      backgroundColor: Color.fromARGB(255, 129, 223, 129),
                    ),
                  );
                  updateUserInfoAfterLogin();
                  Get.toNamed('/signin');
                }
                else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Lỗi: Đăng ký thất bại!'),
                      duration: Duration(seconds: 2), // Set the duration here]
                      backgroundColor: Color.fromARGB(255, 223, 129, 129),
                    ),
                  );
                }
              },
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SignUpPage(),
  ));
}
