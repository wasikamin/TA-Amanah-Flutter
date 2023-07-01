import 'package:amanah/constants/app_theme.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title, this.actions = const []});
  final String title;
  final List<Widget>? actions;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(title, style: bodyTextStyle.copyWith(fontSize: 20)),
      foregroundColor: Colors.black,
      actions: actions,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize {
    return const Size.fromHeight(50);
  }
}
