import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';

class AppNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<CurvedNavigationBarItem> items;
  final int? duration;

  const AppNavigation(
      {super.key,
      required this.currentIndex,
      required this.onTap,
      required this.items,
      this.duration});

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: currentIndex,
      onTap: onTap,
      items: items,
      animationDuration: Duration(milliseconds: duration ?? 600),
      color: Colors.green,
      animationCurve: Curves.easeInOut,
      backgroundColor: Colors.transparent,
    );
  }
}
