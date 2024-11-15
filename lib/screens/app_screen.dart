import 'package:config/models/user.dart';
import 'package:config/screens/forum_screen.dart';
import 'package:config/screens/login_screen.dart';
import 'package:config/screens/pages/home_page.dart';
import 'package:config/screens/pages/map_page.dart';
import 'package:config/screens/pages/notification_page.dart';
import 'package:config/services/account_service.dart';
import 'package:config/services/auth_service.dart';
import 'package:config/screens/profile.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:config/base/base_screen.dart';
import 'package:config/utils/components/app_navigation.dart';

class AppScreen extends StatefulWidget {
  final int? currentIndex;

  const AppScreen({super.key, this.currentIndex});

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  int _currentIndex = 0;
  DateTime? _lastPressedAt;
  int _duration = 300;
  bool _isLogin = false;
  late Users _users;

  final _items = const <CurvedNavigationBarItem>[
    CurvedNavigationBarItem(
      child: Icon(
        Icons.home_rounded,
        color: Colors.white,
      ),
    ),
    CurvedNavigationBarItem(
      child: Icon(
        Icons.forum_rounded,
        color: Colors.white,
      ),
    ),
    CurvedNavigationBarItem(
      child: Icon(
        Icons.hub_rounded,
        color: Colors.white,
      ),
    ),
    CurvedNavigationBarItem(
      child: Icon(
        Icons.notifications_rounded,
        color: Colors.white,
      ),
    ),
    CurvedNavigationBarItem(
      child: Icon(
        Icons.supervisor_account_rounded,
        color: Colors.white,
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex ?? 0;
    _setLoginStatus();
  }

  void _setLoginStatus() async {
    bool isLogin = await AuthService.checkLogin();
    _isLogin = isLogin;
    if (_isLogin){
      _users = await AccountService.fetchUserByAccountId(
          FirebaseAuth.instance.currentUser!.uid);
    }
  }

  Future<bool> onBackPressed() async {
    if (_currentIndex != 0) {
      setState(() {
        _currentIndex = 0;
      });
      return false;
    }
    final currentTime = DateTime.now();
    final shouldExit = _lastPressedAt == null ||
        currentTime.difference(_lastPressedAt!) > const Duration(seconds: 1);
    if (shouldExit) {
      _lastPressedAt = currentTime;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Press again to exit')),
      );
      return false;
    }
    return true;
  }

  void onItemTapped(int index) {
    final distance = (_currentIndex - index).abs();
    _duration = 300 + (distance * 100);
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      const HomePage(),
      const ForumScreen(),
      _isLogin ? const MapPage() : const LoginScreen(currentIndex: 2),
      _isLogin ? const NotificationPage() : const LoginScreen(currentIndex: 3),
      _isLogin
          ? ProfilePage(
              user: _users,
            )
          : const LoginScreen(currentIndex: 4),
    ];
    return SafeArea(
      child: BaseScreen(
        body: children[_currentIndex],
        navigation: AppNavigation(
          currentIndex: _currentIndex,
          onTap: onItemTapped,
          items: _items,
          duration: _duration,
        ),
        onWillPop: onBackPressed,
      ),
    );
  }
}