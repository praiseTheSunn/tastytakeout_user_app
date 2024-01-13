import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastytakeout_user_app/service/auth_service.dart';

import '../screens/voucher_screen.dart';

class CustomDrawer extends StatelessWidget {
  final AuthService authService = Get.put(AuthService());
  // const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            height: 70,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Tasty Takeout',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          GestureDetector(
            child: ListTile(
              leading: Icon(Icons.card_giftcard),
              title: Text('Ví voucher'),
              trailing: Chip(
                label: Text('100+'),
              ),
            ),
            onTap: () {
              Get.to(VoucherScreen());
            },
          ),
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Thiết lập địa chỉ'),
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Cài đặt thông báo'),
          ),
          ListTile(
            leading: Icon(Icons.message),
            title: Text('Cài đặt chat'),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              'Hỗ trợ',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.article),
            title: Text('Điều khoản Tasty Takeout'),
          ),
          ListTile(
            leading: Icon(Icons.help_center),
            title: Text('Trung tâm hỗ trợ'),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              'Ứng dụng',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.update),
            title: Text('Cập nhật phiên bản mới'),
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Đăng xuất'),
            onTap: () {
              authService.logout();
            },
          ),
        ],
      ),
    );
  }
}
