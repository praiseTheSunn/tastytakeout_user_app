import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastytakeout_user_app/service/auth_service.dart';
import 'package:tastytakeout_user_app/views/screens/forgotpassword_screen.dart';
import 'package:tastytakeout_user_app/views/screens/signup_screen.dart';

// ViewModel class for managing the state of the sign-in page
class SignInViewModel extends GetxController {
  String username = '';
  String password = ''; 
}

class SignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInViewModel());
  }
}

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final AuthService authService = Get.put(AuthService());
  // Create an instance of the ViewModel
  SignInViewModel _viewModel = SignInViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Đăng nhập'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Đăng nhập!',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Nhập số điện thoại và mật khẩu.',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),

            SizedBox(height: 16.0),
            TextField(
              onChanged: (value) {
                setState(() {
                  _viewModel.username = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Số điện thoại',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              onChanged: (value) {
                setState(() {
                  _viewModel.password = value;
                });
              },
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Mật khẩu',
              ),
            ),
            SizedBox(height: 8.0),
            GestureDetector(
              onTap: () {
                // Add logic for forgot password
                print('Forgot Password');
                Get.to(() => ForgotPasswordPage());
              },
              child: Text(
                'Quên mật khẩu',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                if (_viewModel.username.isEmpty || _viewModel.password.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Lỗi: số điện thoại hoặc mật khẩu trống!'),
                      duration: Duration(seconds: 2), // Set the duration here]
                      backgroundColor: Color.fromARGB(255, 223, 129, 129),
                    ),
                  );
                  return;
                }

                // Add logic for sign-in button
                print('Sign In: ${_viewModel.username}, ${_viewModel.password}');

                bool success = await authService.login(_viewModel.username, _viewModel.password);
                if (success) {
                  // Navigate to home page
                  // Get.offAll(() => HomePage());
                  Get.toNamed('/home');
                } else {
                  // Show error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Lỗi: số điện thoại hoặc mật khẩu không đúng!'),
                      duration: Duration(seconds: 2), // Set the duration here]
                      backgroundColor: Color.fromARGB(255, 223, 129, 129),
                    ),
                  );
                }
              },
              child: Text('Đăng nhập'),
            ),
            SizedBox(height: 16.0),
            GestureDetector(
              onTap: () {
                // Add logic for navigating to sign-up page
                print('Navigate to Sign Up');
                Get.to(() => SignUpPage());
              },
              child: Center(
                child: Text(
                  "Chưa có tài khoản? Tạo tài khoản mới tại đây.",
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text('Hoặc đăng nhập bằng'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Add logic for Google sign-up
                    print('Sign Up with Google');
                  },
                  child: Text('Google'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Add logic for Facebook sign-up
                    print('Sign Up with Facebook');
                  },
                  child: Text('Facebook'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}