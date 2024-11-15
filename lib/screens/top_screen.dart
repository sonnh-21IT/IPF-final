import 'package:config/base/base_screen.dart';
import 'package:config/utils/components/app_toolbar.dart';
import 'package:flutter/material.dart';

class TopScreen extends StatelessWidget {
  final String title;
  final Widget body;
  const TopScreen({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      toolbar: AppToolbar(title: title),
      body: body,
    );
  }
}
