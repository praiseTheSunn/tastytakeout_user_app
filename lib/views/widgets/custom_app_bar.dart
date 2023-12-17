

import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function() onMenuPressed;
  final Function() onSearchPressed;
  final Function() onNotificationPressed;
  final Function() onUserPressed;

  CustomAppBar({
    required this.title,
    required this.onMenuPressed,
    required this.onSearchPressed,
    required this.onNotificationPressed,
    required this.onUserPressed,
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
                  onPressed: onMenuPressed,
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: onSearchPressed,
                ),
              ],
            ),
            Text(title),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.notifications),
                  onPressed: onNotificationPressed,
                ),
                IconButton(
                  icon: Icon(Icons.person),
                  onPressed: onUserPressed,
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