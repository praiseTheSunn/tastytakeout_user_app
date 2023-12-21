import 'package:flutter/material.dart';

class ChatScreenDetailAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatScreenDetailAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
