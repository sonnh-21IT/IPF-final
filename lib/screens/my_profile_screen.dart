import 'dart:io';

import 'package:config/base/base_screen.dart';
import 'package:config/models/user.dart';
import 'package:config/screens/update_profile_screen.dart';
import 'package:config/services/account_service.dart';
import 'package:config/services/auth_service.dart';
import 'package:config/utils/components/app_toolbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/components/component.dart';

class MyProfileScreen extends StatefulWidget {
  late Users user;
  MyProfileScreen({super.key, required this.user});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  late Users _userInfo;
  @override
  initState() {
    super.initState();
    _userInfo = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      toolbar: AppToolbar(
        title: "Thông tin của tôi",
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: ContentApp(userInfo: _userInfo),
      ),
    );
  }
}

class ContentApp extends StatefulWidget {
  late Users userInfo;
  ContentApp({super.key, required this.userInfo});

  @override
  _StateContent createState() => _StateContent();
}

class _StateContent extends State<ContentApp> {
  late Users userInfo;
  String? _path_avatar;
  final num _vote = 4.7;
  bool _isLogin = false;

  Map<String, String> idLanguage = {
    'iDRUHqE9moXNigg6ukJX' :  'Tiếng Anh',
    'mtEeK49x1ok5ZlXEq3A5' : 'Tiếng Pháp',
    'zY4HaJX4MCHhNSoH8dSx': 'Tiếng Nhật',
    'ndXC1WAmvQBXjsSLaQJb': 'Tiếng Hàn',
    'Z9PEd5g4FadOfvIE7JCy': 'Tiếng Ý',
    'MJCU4RFTj6DVDCHye89E' : 'Tiếng Bồ Đào Nha' ,
    'Bv3UU2NmhSVY8AOUeCZd' : 'Tiếng Nga',
    'N3hZEeDPYSSaJMXsZqBE' : 'Tiếng Thái',
  };

  // Final Function
  void loadImage() async {
    SharedPreferences loadImg = await SharedPreferences.getInstance();
    setState(() {
      _path_avatar = loadImg.getString("img_avata");
    });
  }

  @override
  void initState() {
    super.initState();
    loadImage();
    userInfo = widget.userInfo;
    setStatusLogin();
  }

  Future<void> setStatusLogin() async {
    bool isLogin = await AuthService.checkLogin();
    if (isLogin) {
      Users user = await AccountService.fetchUserByAccountId(
          FirebaseAuth.instance.currentUser!.uid);
      setState(() {
        _isLogin = isLogin;
        userInfo = user;
      });
    } else {
      setState(() {
        _isLogin = isLogin;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        color: Colors.white,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // ==== Avata ====
          const SizedBox(
            height: 15,
          ),
          _isLogin
              ? Center(
                  child: GestureDetector(
                      child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black, // Border color
                        width: 1.0, // Border width
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: CircleAvatar(
                        radius: 80,
                        backgroundImage:
                        _path_avatar != null && _path_avatar!.isNotEmpty
                                ? FileImage(File(_path_avatar!))
                                : const AssetImage(
                                        'assets/images/avata_default.png')
                                    as ImageProvider,
                        child: Container()),
                  )),
                )
              : const SizedBox(
                  height: 10,
                ),
          // ==== Username ====
          _isLogin
              ? Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        child: CustomText(
                          data: userInfo.fullName,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Container(
                        child: CustomText(
                          data: userInfo.email,
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox(
                  height: 10,
                ),
          const SizedBox(
            height: 5,
          ),
          // ==== Vote and Top Rated
          Container(
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 24,
                        color: Colors.yellow,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      CustomText(
                        data: "$_vote",
                        fontSize: 16,
                      ),
                      const CustomText(
                        data: " (4355)",
                        color: Colors.grey,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                const SizedBox(
                  height: 20,
                  width: 1,
                  child: VerticalDivider(
                    color: Colors.grey, // Đặt màu sắc cho thanh ngang
                    thickness: 1, // Đặt độ dày của thanh ngang
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                Container(
                  child: const CustomText(
                    data: "Top Rated",
                    color: Color(0xFF4CAF4F),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          // ==== About Me ====
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: CustomText(
              data: userInfo.biography ?? 'No biography available',
              textAlign: TextAlign.justify,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          // ==== Location and language
          Container(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Color(0xFF4CAF4F),
                          size: 24,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        CustomText(
                          data: userInfo.address ?? 'No address available',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          FontAwesomeIcons.language,
                          color: Color(0xFF4CAF4F),
                          size: 24,
                        ),
                        const SizedBox(
                          width: 14,
                        ),
                        CustomText(
                          data: idLanguage[userInfo.languageId] ?? '',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          // ==== Hr ====
          Container(
            // padding: EdgeInsets.only(left: 20, right: 20),
            child: const Divider(
              color: Colors.grey, // Đặt màu sắc cho thanh ngang
              thickness: 1, // Đặt độ dày của thanh ngang
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          // Chứng chỉ và lĩnh vực
          Container(
            child: Row(
              children: [
                // Chửng chỉ
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        const CustomText(
                          data: "Chứng chỉ",
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(height: 6),
                        ItemInterpreter("Topik 5"),
                        ItemInterpreter("Toeic"),
                      ],
                    ),
                  ),
                ),
                // Lĩnh vực
                Expanded(
                    child: Container(
                        child: Column(
                  children: [
                    const CustomText(
                      data: "Lĩnh vực",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(height: 6),
                    ItemInterpreter("Pháp luật"),
                    ItemInterpreter("Y tế"),
                  ],
                ))),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          // ==== Hr ====
          Container(
            // padding: EdgeInsets.only(left: 20, right: 20),
            child: const Divider(
              color: Colors.grey, // Đặt màu sắc cho thanh ngang
              thickness: 1, // Đặt độ dày của thanh ngang
            ),
          ),
          // ==== Project Done ====
          Container(
            child: Column(
              children: [
                // ==== Title ====
                Container(
                  alignment: Alignment.center,
                  child: const CustomText(
                    data: "Dự án đã hoàn thành",
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 10),
                // ===== List Project ====
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                          fit: FlexFit.loose,
                          child: ItemProject("Project 1", 4.7)),
                      Flexible(
                          fit: FlexFit.loose,
                          child: ItemProject("Project 2", 4.8)),
                      Flexible(
                          fit: FlexFit.loose,
                          child: ItemProject("Project 3", 4.6)),
                      Flexible(
                          fit: FlexFit.loose,
                          child: ItemProject("Project 4", 4.5)),
                      Flexible(
                          fit: FlexFit.loose,
                          child: ItemProject("Project 5", 5.0)),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          // ==== Hr ====
          Container(
            // padding: EdgeInsets.only(left: 20, right: 20),
            child: const Divider(
              color: Colors.grey, // Đặt màu sắc cho thanh ngang
              thickness: 1, // Đặt độ dày của thanh ngang
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          // ==== Button ====
          Container(
            child: Row(
              children: [
                // ==== Update Profile ====
                Expanded(
                  child: Container(
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFBC02D),
                          // Đổi màu nền
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          // Thêm padding
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10), // Giảm độ bo góc
                          ),
                          shadowColor: Colors.black,
                          // Màu của bóng đổ
                          elevation: 8,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      UpdateProfileScreen(user: userInfo)),
                            );
                          },
                          child: const CustomText(
                            data: "Chỉnh sửa hồ sơ",
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        )),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                // ==== Project Done ====
                Expanded(
                  child: Container(
                    child: ElevatedButton(
                      onPressed: () {
                        // Xử lý sự kiện khi nhấn nút
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2EA2F8),
                        // Đổi màu nền
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        // Thêm padding
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Giảm độ bo góc
                        ),
                        shadowColor: Colors.black,
                        // Màu của bóng đổ
                        elevation: 8,
                      ),
                      child: const CustomText(
                        data: "Dự án hoàn thành",
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ]));
  }
}

class ItemInterpreter extends StatelessWidget {
  String content;

  ItemInterpreter(this.content, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: 100,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: Colors.white, // Color
                border: Border.all(
                  color: const Color(0xFF4CAF4F),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10)),
            child: CustomText(
              data: content,
              fontSize: 16,
              color: const Color(0xFF4CAF4F),
              textAlign: TextAlign.center,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
        ],
      ),
    );
  }
}

class ItemProject extends StatelessWidget {
  String nameProject;
  num ratingProject;

  ItemProject(this.nameProject, this.ratingProject, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: const Color(0xFF4CAF4F), // Color
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                CustomText(
                  data: nameProject,
                  color: Colors.white,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    CustomText(
                      data: "$ratingProject",
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.star,
                      size: 24,
                      color: Colors.yellow,
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
    );
  }
}
