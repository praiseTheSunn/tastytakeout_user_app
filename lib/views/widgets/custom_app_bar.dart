import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastytakeout_user_app/service/auth_service.dart';
import 'package:tastytakeout_user_app/views/screens/signin_screen.dart';
import 'package:tastytakeout_user_app/views/widgets/search_delegate.dart';

import '../screens/user_infomation_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  // final AuthService authService = AuthService();
  final AuthService authService = Get.put(AuthService());
  final String title;
  final Function() onSearchPressed = () {
    // Get.to(() => SearchScreen(searchQuery: ''));
    // showSearch(
    //             context: context,
    //             delegate: SearchField()
    //           );
  };
  final Function() onNotificationPressed = () {};
  final Function() onUserPressed = () {
    if (Get.currentRoute != '/UserInfoPage') {
      Get.put(UserInfoController());
      Get.to(UserInfoPage());
    } else
      Get.back();
  };

  CustomAppBar({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    // Get.to(() => SearchScreen(searchQuery: ''));
                    showSearch(
                      context: context,
                      delegate: CustomSearchDelegate()
                    );
                  },
                ),
              ],
            ),
            Text(
              title,
              style: TextStyle(fontSize: 22),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.notifications),
                  onPressed: onNotificationPressed,
                ),
                IconButton(
                  icon: Icon(Icons.person),
                  onPressed: () async {
                    
                    // if (Get.currentRoute != '/UserInfoPage') {
                    //   Get.to(UserInfoPage());
                    // } else
                    //   Get.back();
                    authService.checkLoginStatus();
                    if (authService.isLoggedIn.value) {
                      // If logged in, navigate to the user info page
                      if (Get.currentRoute != '/UserInfoPage') {
                        Get.to(UserInfoPage());
                      } else {
                        Get.back();
                      }
                    } else {
                      // If not logged in, navigate to the login page
                      Get.to(() => SignInPage());
                    }
                  }
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
