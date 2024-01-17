import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastytakeout_user_app/service/auth_service.dart';
import 'package:tastytakeout_user_app/views/screens/notification_screen.dart';
import 'package:tastytakeout_user_app/views/screens/signin_screen.dart';
import 'package:tastytakeout_user_app/views/widgets/search_delegate.dart';

import '../../globals.dart';
import '../screens/user_infomation_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  // final AuthService authService = AuthService();
  final AuthService authService = Get.put(AuthService());
  final String title;
  final hasIcons;
  final Function() onSearchPressed = () {
    // Get.to(() => SearchScreen(searchQuery: ''));
    // showSearch(
    //             context: context,
    //             delegate: SearchField()
    //           );
  };
  final Function() onNotificationPressed = () {
    Get.to(() => NotificationScreen());
  };
  final Function() onUserPressed = () {
    if (Get.currentRoute != '/UserInfoPage') {
      Get.put(UserInfoController());
      Get.to(UserInfoPage());
    } else
      Get.back();
  };

  CustomAppBar({
    required this.title,
    this.hasIcons = true,
  });

  @override
  Widget build(BuildContext context) {
    var iconDrawer = IconButton(
      icon: Icon(Icons.menu),
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
    );

    var iconSearch = IconButton(
      icon: Icon(Icons.search),
      onPressed: () {
        // Get.to(() => SearchScreen(searchQuery: ''));
        showSearch(context: context, delegate: CustomSearchDelegate());
      },
    );

    var iconNoti = IconButton(
      icon: Icon(Icons.notifications),
      onPressed: onNotificationPressed,
    );

    var iconUser = IconButton(
        icon: Icon(Icons.person),
        onPressed: () async {
          // if (Get.currentRoute != '/UserInfoPage') {
          //   Get.to(UserInfoPage());
          // } else
          //   Get.back();
          await authService.checkLoginStatus();
          print(authService.isLoggedIn.value);
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
        });

    return SafeArea(
      child: Material(
        elevation: 0.0,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0.0),
            bottomRight: Radius.circular(0.0),
          ),
          child: Container(
            color: mainColor,
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    if (hasIcons) iconDrawer,
                    if (hasIcons) iconSearch,
                  ],
                ),
                Text(
                  title,
                  style: TextStyle(fontSize: 22),
                ),
                Row(
                  children: [
                    if (hasIcons) iconNoti,
                    if (hasIcons) iconUser,
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
