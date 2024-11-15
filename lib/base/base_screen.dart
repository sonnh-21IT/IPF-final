import 'package:flutter/material.dart';

import '../../utils/components/app_navigation.dart';
import '../../utils/components/app_toolbar.dart';

class BaseScreen extends StatelessWidget {
  final Widget body;
  final AppToolbar? toolbar;
  final AppNavigation? navigation;
  final Future<bool> Function()? onWillPop;
  final bool? resize;

  const BaseScreen({
    super.key,
    required this.body,
    this.toolbar,
    this.navigation,
    this.onWillPop,
    this.resize = false,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: resize,
        appBar: toolbar,
        body: body,
        bottomNavigationBar: navigation,
      ),
    );
  }
}
