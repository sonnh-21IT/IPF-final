import 'dart:io';

import 'package:config/models/user.dart';
import 'package:config/screens/my_profile_screen.dart';
import 'package:config/services/account_service.dart';
import 'package:config/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_screen.dart';

class ProfilePage extends StatefulWidget {
  final Users user;
  const ProfilePage({super.key, required this.user});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Users _userInfo;
  bool _isFaceIdEnabled = false;
  File? _image_avata;
  String? _path_avata;
  final String _keyPath_avata = "img_avata";

  void loadImage() async {
    SharedPreferences loadImg = await SharedPreferences.getInstance();
    setState(() {
      _path_avata = loadImg.getString("img_avata");
    });
  }

  @override
  void initState() {
    super.initState();
    loadImage();
    _userInfo = widget.user;
    setStatusLogin();
  }

  Future<void> setStatusLogin() async {
    bool isLogin = await AuthService.checkLogin();
    if (isLogin) {
      Users user = await AccountService.fetchUserByAccountId(
          FirebaseAuth.instance.currentUser!.uid);
      setState(() {
        _userInfo = user;
      });
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.all(6.0),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(8), // Bo tròn
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage:
                      _path_avata != null && _path_avata!.isNotEmpty
                          ? FileImage(File(_path_avata!))
                          : const AssetImage('assets/images/avata_default.png'),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _userInfo.fullName,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _userInfo.email,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          // Menu Items
          _buildMenuItem(
            Icons.account_circle,
            'Tài khoản của bạn',
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyProfileScreen(user: _userInfo)),
              );
            },
          ),
          const Divider(),
          _buildMenuItem(
            Icons.payment,
            'Phương thức thanh toán',

            trailing: const Icon(Icons.arrow_forward_ios),
            // onTap: () {
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (context) => PaymentMethodsPage()),
            //   );
            // },
          ),
          const Divider(),
          _buildMenuItem(
            Icons.fingerprint,
            'Face ID / Touch ID',
            trailing: Switch(
              value: _isFaceIdEnabled,
              onChanged: (bool value) {
                setState(() {
                  _isFaceIdEnabled = value;
                });
              },
            ),
          ),
          const Divider(),
          _buildMenuItem(
            Icons.security,
            'Bảo mật thiết bị 2 bước',
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
          const Divider(),
          _buildMenuItem(
            Icons.lock,
            'Chỉnh sửa mật khẩu',
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
          const Divider(),
          _buildMenuItem(
            Icons.logout,
            'Đăng xuất',
            iconColor: Colors.red,
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () async {
              await AuthService.signOut();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (content) => const AppScreen(
                            currentIndex: 0,
                          )));
            },
          ),
          const Divider(),
          const Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'More',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const Divider(),
          // Help & Support and About App
          _buildMenuItem(
            Icons.help,
            'Help & Support',
            trailing: const Icon(Icons.arrow_forward_ios),
          ),

          _buildMenuItem(
            Icons.info,
            'About App',
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
          const Divider(),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title,
      {Color iconColor = Colors.green, VoidCallback? onTap, Widget? trailing}) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(title),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
