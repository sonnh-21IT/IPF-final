import 'dart:io';
import 'package:config/base/base_screen.dart';
import 'package:config/models/user.dart';
import 'package:config/screens/upload_project_screen.dart';
import 'package:config/services/account_service.dart';
import 'package:config/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app_screen.dart';
import '../list_inter_screen.dart';
import '../list_project_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Users? userInfo;
  File? _image_avata;
  String? _path_avata;
  final String _keyPath_avata = "img_avata";
  bool _isLogin = false;

  final String _fullname = "Trần Quang";
  String selectedCategory = 'Pháp lý';

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
    return BaseScreen(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.green, Colors.white],
              stops: [0.25, 0.28],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _isLogin
                    ? Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage:
                      _path_avata != null && _path_avata!.isNotEmpty
                          ? FileImage(File(_path_avata!))
                          : const AssetImage(
                          'assets/images/avata_default.png'),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Hello, Welcome 🎉',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          userInfo!.fullName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Stack(
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.facebookMessenger,
                          color: Colors.white,
                          size: 25,
                        ),
                        Positioned(
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 8,
                              minHeight: 8,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
                    : Container(),
                const SizedBox(height: 20),
//Form tìm kiếm
                Row(
                  children: [
                    SizedBox(
                      height: 53,
                      width: 240,
                      child: TextField(
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Tìm kiếm ...',
                          hintStyle: const TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.3),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          prefixIcon:
                          const Icon(Icons.search, color: Colors.white),
                        ),
                      ),
                    ),
// Đăng dự án
                    const SizedBox(width: 10),
                    Expanded(
                      child: SizedBox(
                        height: 53,
                        width: 125,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                    const UpdateProjectScreen()));
                            if (_isLogin) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                      const UpdateProjectScreen()));
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                      const AppScreen(
                                        currentIndex: 4,
                                      )));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: const Text(
                            'Đăng dự án',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
//Images
                Center(
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(50),
                        )),
                    //   color: Colors.green,
                    child: Image.asset('assets/images/app_img/slide_home.png'),
                  ),
                ),
                const SizedBox(height: 20),
// Số dư và Điểm thưởng
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(244, 245, 245, 20),
                          border: Border.all(color: Colors.black12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Số dư',
                                      style: TextStyle(color: Colors.black)),
                                  Text('0 Credit',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Image.asset(
                                'assets/images/credit_point/wallet.png',
                                height: 24,
                                width: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        height: 50,
                        width: 1,
                        color: Colors.black,
                      ),
                      const SizedBox(width: 10),
                      Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(244, 245, 245, 20),
                          border: Border.all(color: Colors.black12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Điểm thưởng',
                                      style: TextStyle(color: Colors.black)),
                                  Text('0 Điểm',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Image.asset(
                                'assets/images/credit_point/cup.png',
                                height: 24,
                                width: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
// Title Dự án đề xuất
                const SizedBox(height: 20),
                Container(
                  color: const Color.fromRGBO(
                      237, 237, 252, 150), // Background màu xám
                  padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15), // Optional: Padding cho đẹp hơn
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Dự án đề xuất',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                  const ListProjectScreen()));
                        },
                        child: Text(
                          'Xem thêm',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
// Các button List
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategory = 'Pháp lý';
                            });
                          },
                          child: Container(
                            width: 95,
                            height: 36,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              color: selectedCategory == 'Pháp lý'
                                  ? Colors.green
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.balance,
                                  size: 20,
                                  color: selectedCategory == 'Pháp lý'
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                const SizedBox(width: 5),
                                Text('Pháp lý',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: selectedCategory == 'Pháp lý'
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategory = 'Y tế';
                            });
                          },
                          child: Container(
                            width: 95,
                            height: 36,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              color: selectedCategory == 'Y tế'
                                  ? Colors.green
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.local_hospital,
                                  size: 20,
                                  color: selectedCategory == 'Y tế'
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                const SizedBox(width: 5),
                                Text('Y tế',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: selectedCategory == 'Y tế'
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategory = 'Du lịch';
                            });
                          },
                          child: Container(
                            width: 95,
                            height: 36,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              color: selectedCategory == 'Du lịch'
                                  ? Colors.green
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.travel_explore,
                                  size: 20,
                                  color: selectedCategory == 'Du lịch'
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                const SizedBox(width: 5),
                                Text('Du lịch',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: selectedCategory == 'Du lịch'
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategory = 'Dự án công ty';
                            });
                          },
                          child: Container(
                            width: 95,
                            height: 36,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              color: selectedCategory == 'Dự án công ty'
                                  ? Colors.green
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.shelves,
                                  size: 20,
                                  color: selectedCategory == 'Dự án công ty'
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                const SizedBox(width: 5),
                                Text('Dự án',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color:
                                        selectedCategory == 'Dự án công ty'
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
// List of projects Pháp lý
                const SizedBox(height: 5),
                if (selectedCategory == 'Pháp lý') ...[
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    // Added left margin
                    width: 370,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Right side: Image
                        Container(
                          width: 120,
                          height: 150,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage(
                                  'assets/images/list/phaplynhadat.png'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        // Left side: Details
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Pháp lý nhà đất',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    FaIcon(
                                      FontAwesomeIcons.ellipsis,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Tiếng Hàn | Pháp Lý',
                                  style: TextStyle(
                                    color: Color.fromRGBO(141, 135, 135, 20),
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Hình thức : Online & Offline',
                                  style: TextStyle(
                                    color: Color.fromRGBO(141, 135, 135, 20),
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromRGBO(
                                            102, 187, 105, 20),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(4),
                                        ),
                                        minimumSize: const Size(50, 30),
                                      ),
                                      child: const Text('7 -12 triệu',
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    const SizedBox(width: 10),
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromRGBO(
                                            102, 187, 105, 20),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(4),
                                        ),
                                        minimumSize: const Size(50, 30),
                                      ),
                                      child: const Text(
                                        'Đà Nẵng',
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Spacer(),
                                      Icon(
                                        Icons.remove_red_eye,
                                        color: Colors.yellow,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        '( 332 reviews )',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color:
                                          Color.fromRGBO(141, 135, 135, 20),
                                        ),
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
                ],
// List of project Y tế
                if (selectedCategory == 'Y tế') ...[
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    // Added left margin
                    width: 370,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Right side: Image
                        Container(
                          width: 120,
                          height: 150,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image:
                              AssetImage('assets/images/list/medical.png'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        // Left side: Details
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Bệnh viện Y Tế',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    FaIcon(
                                      FontAwesomeIcons.ellipsis,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Tiếng Hàn | Y Tế',
                                  style: TextStyle(
                                    color: Color.fromRGBO(141, 135, 135, 20),
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Hình thức : Offline',
                                  style: TextStyle(
                                    color: Color.fromRGBO(141, 135, 135, 20),
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromRGBO(
                                            102, 187, 105, 20),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(4),
                                        ),
                                        minimumSize: const Size(50, 30),
                                      ),
                                      child: const Text('7 -12 triệu',
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    const SizedBox(width: 10),
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromRGBO(
                                            102, 187, 105, 20),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(4),
                                        ),
                                        minimumSize: const Size(50, 30),
                                      ),
                                      child: const Text(
                                        'Đà Nẵng',
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Spacer(),
                                      Icon(
                                        Icons.remove_red_eye,
                                        color: Colors.yellow,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        '( 332 reviews )',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color:
                                          Color.fromRGBO(141, 135, 135, 20),
                                        ),
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
                ],
                if (selectedCategory == 'Du lịch') ...[
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    // Added left margin
                    width: 370,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Right side: Image
                        Container(
                          width: 120,
                          height: 150,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image:
                              AssetImage('assets/images/list/travel.png'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        // Left side: Details
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Du lịch vui chơi',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    FaIcon(
                                      FontAwesomeIcons.ellipsis,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Tiếng Anh | Du lịch',
                                  style: TextStyle(
                                    color: Color.fromRGBO(141, 135, 135, 20),
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Hình thức : Offline',
                                  style: TextStyle(
                                    color: Color.fromRGBO(141, 135, 135, 20),
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromRGBO(
                                            102, 187, 105, 20),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(4),
                                        ),
                                        minimumSize: const Size(50, 30),
                                      ),
                                      child: const Text('7 -12 triệu',
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    const SizedBox(width: 10),
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromRGBO(
                                            102, 187, 105, 20),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(4),
                                        ),
                                        minimumSize: const Size(50, 30),
                                      ),
                                      child: const Text(
                                        'Đà Nẵng',
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Spacer(),
                                      Icon(
                                        Icons.remove_red_eye,
                                        color: Colors.yellow,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        '( 332 reviews )',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color:
                                          Color.fromRGBO(141, 135, 135, 20),
                                        ),
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
                ],
                if (selectedCategory == 'Dự án công ty') ...[
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    // Added left margin
                    width: 370,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Right side: Image
                        Container(
                          width: 120,
                          height: 150,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image:
                              AssetImage('assets/images/list/project.jpg'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        // Left side: Details
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Dự án công ty',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    FaIcon(
                                      FontAwesomeIcons.ellipsis,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Tiếng Anh | Dự án công ty',
                                  style: TextStyle(
                                    color: Color.fromRGBO(141, 135, 135, 20),
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Hình thức : Offline',
                                  style: TextStyle(
                                    color: Color.fromRGBO(141, 135, 135, 20),
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromRGBO(
                                            102, 187, 105, 20),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(4),
                                        ),
                                        minimumSize: const Size(50, 30),
                                      ),
                                      child: const Text('7 -12 triệu',
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    const SizedBox(width: 10),
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromRGBO(
                                            102, 187, 105, 20),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(4),
                                        ),
                                        minimumSize: const Size(50, 30),
                                      ),
                                      child: const Text(
                                        'Đà Nẵng',
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Spacer(),
                                      Icon(
                                        Icons.remove_red_eye,
                                        color: Colors.yellow,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        '( 332 reviews )',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color:
                                          Color.fromRGBO(141, 135, 135, 20),
                                        ),
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
                ],
// Title Phiên dịch viên hàng đầu
                const SizedBox(height: 20),
                Container(
                  color: const Color.fromRGBO(
                      237, 237, 252, 150), // Background màu xám
                  padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15), // Optional: Padding cho đẹp hơn
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Phiên dịch viên hàng đầu',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                  const ListInterScreen()));
                        },
                        child: Text(
                          'Xem thêm',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
// List Interpreter
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(
                                color: const Color.fromARGB(255, 238, 236, 236),
                                width: 2),
                          ),
                          child: Column(
                            children: [
                              // Phần trên cùng
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        'assets/images/list/interpreter.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    const SizedBox(
                                      width: 250,
                                      child: Text(
                                        'Có kinh nghiệm phiên dịch các sự kiện tài chính, hội nghị về chứng khoán và bảo hiểm',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                        maxLines:
                                        null, // Cho phép text tự động xuống dòng
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              const Divider(
                                color: Colors.black,
                                thickness: 2, // Điều chỉnh độ dày
                              ),
                              const SizedBox(height: 4.0),
                              const Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: AssetImage(
                                        'assets/images/app_img/avatar.png'),
                                    // Đường dẫn đến ảnh cục bộ
                                    radius: 24.0,
                                  ),
                                  SizedBox(width: 18.0),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Trần Quang',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.star,
                                              color: Colors.yellow, size: 16.0),
                                          Text('4.7 (126 đánh giá)'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.star,
                                              color: Colors.blue, size: 16),
                                          Text(
                                            'Top rate',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(
                                color: const Color.fromARGB(255, 238, 236, 236),
                                width: 2),
                          ),
                          child: Column(
                            children: [
                              // Phần trên cùng
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        'assets/images/list/interpreter.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    const SizedBox(
                                      width: 250,
                                      child: Text(
                                        'Chuyên về phiên dịch các báo cáo tài chính, hợp đồng đầu tư và các cuộc họp của hội đồng quản trị',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                        maxLines:
                                        null, // Cho phép text tự động xuống dòng
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              const Divider(
                                color: Colors.black,
                                thickness: 2, // Điều chỉnh độ dày
                              ),
                              const SizedBox(height: 4.0),
                              const Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: AssetImage(
                                        "assets/images/img_interpreter.png"),
                                    // Đường dẫn đến ảnh cục bộ
                                    radius: 24.0,
                                  ),
                                  SizedBox(width: 18.0),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Nguyễn Hồng Sơn',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.star,
                                              color: Colors.yellow, size: 16.0),
                                          Text('4.8 (356 đánh giá)'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.star,
                                              color: Colors.blue, size: 16),
                                          Text(
                                            'Top rate',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
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
        ),
      ),
    );
  }
}
