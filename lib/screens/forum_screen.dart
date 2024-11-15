import 'dart:io';

import 'package:config/base/base_screen.dart';
import 'package:config/models/user.dart';
import 'package:config/screens/forum_detail_screen.dart';
import 'package:config/services/account_service.dart';
import 'package:config/services/auth_service.dart';
import 'package:config/utils/components/app_toolbar.dart';
import 'package:config/utils/themes/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForumScreen extends StatefulWidget {
  const ForumScreen({super.key});

  @override
  State<ForumScreen> createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  File? _image_avata;
  String? _path_avata;
  bool _isLogin = false;
  final String _keyPath_avata = "img_avata";
  void loadImage() async {
    SharedPreferences loadImg = await SharedPreferences.getInstance();
    setState(() {
      _path_avata = loadImg.getString("img_avata");
    });
  }

  final String _idPost = "1";
  final String _imgPost = "assets/images/background_interpreter.png";
  final List<String> _titles = [
    "Phiên dịch viên là gì? Công việc, mức lương và kỹ năng cần có",
    "Làm thế nào để trở thành một lập trình viên giỏi?",
    "Những kỹ năng cần thiết cho một nhà quản lý dự án",
    "Cách viết CV ấn tượng cho ngành công nghệ thông tin",
    "Tầm quan trọng của việc học ngoại ngữ trong công việc"
  ];
  final List<String> num_views = ["251", "1234", "132", "911"];
  final List<String> num_likes = ["213", "456", "789", "1011"];
  final List<String> num_comments = ["23", "45", "67", "89"];

  @override
  void initState() {
    super.initState();
    loadImage();
    setStatusLogin();
  }

  Future<void> setStatusLogin() async {
    bool isLogin = await AuthService.checkLogin();
    if (isLogin) {
      Users user = await AccountService.fetchUserByAccountId(
          FirebaseAuth.instance.currentUser!.uid);
      setState(() {
        _isLogin = isLogin;
      });
    } else {
      setState(() {
        _isLogin = isLogin;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      toolbar: AppToolbar(
        title: "Diễn đàn",
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      //Side bar
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                          AppColors.surfaceColor.withOpacity(0.5)),
                      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                          const EdgeInsets.all(10)),
                    ),
                    onPressed: () {},
                    child: const Row(
                      children: [
                        Icon(Icons.star, color: Colors.white),
                        SizedBox(width: 4),
                        Text('New', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                          AppColors.surfaceColor.withOpacity(0.5)),
                      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                          const EdgeInsets.all(10)),
                    ),
                    onPressed: () {
                      // Handle "Popular" button press
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.whatshot, color: Colors.white),
                        SizedBox(width: 4),
                        Text('Popular',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                          AppColors.surfaceColor.withOpacity(0.5)),
                      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                          const EdgeInsets.all(10)),
                    ),
                    onPressed: () {
                      // Handle "Following" button press
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.person, color: Colors.white),
                        SizedBox(width: 4),
                        Text('Following',
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            _isLogin ? Container(
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(15.0),
              ),
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  // Avatar người dùng
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: _path_avata != null &&
                        _path_avata!.isNotEmpty
                        ? FileImage(File(_path_avata!))
                        : const AssetImage('assets/images/avata_default.png'),
                  ),
                  const SizedBox(width: 10),
                  // Nơi điền text
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Nhập nội dung bài viết...',
                        hintStyle: const TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(
                            0.3), // Adjust the opacity value as needed
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Nút "Đăng bài"
                  ElevatedButton(
                    onPressed: () {
                      // Xử lý sự kiện khi nhấn nút "Đăng bài"
                    },
                    child: const Text(
                      'Đăng bài',
                      style: TextStyle(color: AppColors.primaryColor),
                    ),
                  ),
                ],
              ),
            ) : Container(),
            const SizedBox(height: 10),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            color: Colors.grey,
                            child: Image.asset(
                              'assets/images/default_image.png',
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                      const DetailForum()), // Replace with your detail forum page
                                );
                              },
                              child: Text(
                                _titles[0],
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          )
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  disabledForegroundColor:
                                  Colors.white.withOpacity(0.38),
                                  disabledBackgroundColor: Colors.white
                                      .withOpacity(0.12), // Text color
                                ),
                                child: const Text('Công việc',
                                    style: TextStyle(color: Colors.white)),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  disabledForegroundColor:
                                  Colors.white.withOpacity(0.38),
                                  disabledBackgroundColor: Colors.white
                                      .withOpacity(
                                      0.12), // Text color/ Text color
                                ),
                                child: const Text('Phiên dịch',
                                    style: TextStyle(color: Colors.white)),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  disabledForegroundColor:
                                  Colors.white.withOpacity(0.38),
                                  disabledBackgroundColor: Colors.white
                                      .withOpacity(
                                      0.12), // Text color// Text color
                                ),
                                child: const Text('Kĩ năng',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(""),
                              Text(num_likes[0] + ' Likes',
                                  style: const TextStyle(
                                      color: Colors.lightBlue, fontSize: 14)),
                              Text(num_comments[0] + ' Comments',
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 14)),
                              Text(num_views[0] + ' Views',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 14)),
                              const Text(""),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            color: Colors.grey,
                            child: Image.asset(
                              'assets/images/forum_2.png',
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                      const DetailForum()), // Replace with your detail forum page
                                );
                              },
                              child: Text(
                                _titles[1],
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          )
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  disabledForegroundColor:
                                  Colors.white.withOpacity(0.38),
                                  disabledBackgroundColor: Colors.white
                                      .withOpacity(0.12), // Text color
                                ),
                                child: const Text('Lập trình',
                                    style: TextStyle(color: Colors.white)),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  disabledForegroundColor:
                                  Colors.white.withOpacity(0.38),
                                  disabledBackgroundColor: Colors.white
                                      .withOpacity(
                                      0.12), // Text color/ Text color
                                ),
                                child: const Text('Hỏi đáp',
                                    style: TextStyle(color: Colors.white)),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  disabledForegroundColor:
                                  Colors.white.withOpacity(0.38),
                                  disabledBackgroundColor: Colors.white
                                      .withOpacity(
                                      0.12), // Text color// Text color
                                ),
                                child: const Text('Vấn đề',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(""),
                              Text(num_likes[1] + ' Likes',
                                  style: const TextStyle(
                                      color: Colors.lightBlue, fontSize: 14)),
                              Text(num_comments[1] + ' Comments',
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 14)),
                              Text(num_views[1] + ' Views',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 14)),
                              const Text(""),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            color: Colors.grey,
                            child: Image.asset(
                              'assets/images/forum_3.png',
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                      const DetailForum()), // Replace with your detail forum page
                                );
                              },
                              child: Text(
                                _titles[0],
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          )
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  disabledForegroundColor:
                                  Colors.white.withOpacity(0.38),
                                  disabledBackgroundColor: Colors.white
                                      .withOpacity(0.12), // Text color
                                ),
                                child: const Text('Tài chính',
                                    style: TextStyle(color: Colors.white)),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  disabledForegroundColor:
                                  Colors.white.withOpacity(0.38),
                                  disabledBackgroundColor: Colors.white
                                      .withOpacity(
                                      0.12), // Text color/ Text color
                                ),
                                child: const Text('Công việc',
                                    style: TextStyle(color: Colors.white)),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  disabledForegroundColor:
                                  Colors.white.withOpacity(0.38),
                                  disabledBackgroundColor: Colors.white
                                      .withOpacity(
                                      0.12), // Text color// Text color
                                ),
                                child: const Text('Tìm hiểu',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(""),
                              Text(num_likes[2] + ' Likes',
                                  style: const TextStyle(
                                      color: Colors.lightBlue, fontSize: 14)),
                              Text(num_comments[2] + ' Comments',
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 14)),
                              Text(num_views[2] + ' Views',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 14)),
                              const Text(""),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                      WidgetStateProperty.all<Color>(Colors.white),
                      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                          const EdgeInsets.all(10)),
                    ),
                    onPressed: () {
                      // Handle button press
                    },
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Button Text',
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                            width: 8), // Optional spacing between text and icon
                        Icon(Icons.arrow_forward, color: Colors.grey),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              width: 400,
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Podcasts',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
// Bàn luận về Bitcoin
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/img_interpreter.png',
                                width: 100,
                                height: 100,
                              ),
                              const SizedBox(
                                  width:
                                  10), // Add some spacing between the image and the column
                              const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Bàn luận về Bitcoin',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'by Michele Hansen',
                                    softWrap: true,
                                  ),
                                ],
                              ),

                              const Spacer(), // Push the icon to the right
                              const Icon(Icons.arrow_forward),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/education.jpg',
                                width: 100,
                                height: 100,
                              ),
                              const SizedBox(
                                  width:
                                  10), // Add some spacing between the image and the column
                              const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Công việc phiên dịch',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'by Trần Quang',
                                    softWrap: true,
                                  ),
                                ],
                              ),

                              const Spacer(), // Push the icon to the right
                              const Icon(Icons.arrow_forward),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
