import 'package:flutter/material.dart';

class AppToolbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool center;
  final Color backgroundColor;
  final Widget? leading;

  const AppToolbar({
    super.key,
    required this.title,
    this.actions,
    this.center = true,
    this.backgroundColor = Colors.green,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: const TextStyle(color: Colors.white),),
      centerTitle: center,
      backgroundColor: backgroundColor,
      actions: actions,
      leading: leading,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}