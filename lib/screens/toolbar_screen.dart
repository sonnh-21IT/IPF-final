import 'package:flutter/material.dart';
import 'package:config/utils/components/app_toolbar.dart';
import 'package:config/base/base_screen.dart';

class ToolbarScreen extends StatelessWidget {
  final Widget body;
  final String title;
  final List<Widget>? actions;
  const ToolbarScreen({super.key, required this.body, required this.title,this.actions});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    BaseScreen(
        toolbar: AppToolbar(title: title,actions:actions, leading: IconButton(onPressed: () {}, icon:const Icon(Icons.arrow_back), color: Colors.white,)),
        body: body)
    );
  }
}
