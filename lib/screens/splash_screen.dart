import 'package:flutter/material.dart';
import 'package:config/base/base_screen.dart';
import 'dart:async';

import 'app_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () async {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const AppScreen(currentIndex: 0)),
      );
    });

    return BaseScreen(
      body: Stack(
        children: [
          Container(
            color: const Color.fromRGBO(129, 199, 132, 20),
          ),
          Center(child: Image.asset('assets/images/app_img/splash.png')),
        ],
      ),
    );
  }
}
