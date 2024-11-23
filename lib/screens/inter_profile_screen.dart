import 'package:config/base/base_screen.dart';
import 'package:config/utils/components/app_toolbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/user.dart';
import '../services/account_service.dart';
import '../services/auth_service.dart';
import '../services/data_service.dart';
import '../utils/components/component.dart';

class InterProfileScreen extends StatelessWidget {
  final String idInterpreter;

  const InterProfileScreen({super.key, required this.idInterpreter});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        toolbar: AppToolbar(
          title: "Chi tiết hồ sơ phiên dịch viên ",
          leading: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
        ),
        body: SingleChildScrollView(
          child: ContentApp(
            idInterpreter: idInterpreter,
          ),
        ));
  }
}

class ContentApp extends StatefulWidget {
  final String idInterpreter;

  const ContentApp({super.key, required this.idInterpreter});

  @override
  _StateContent createState() => _StateContent();
}

class _StateContent extends State<ContentApp> {
  // Final Variable
  Users? userInfo;
  DataService profileService = DataService('user');
  late String _idInterpreter;
  final String _fullname = "Từ Công Minh";
  final String _role = "Phiên dịch viên";
  final num _countCustomer = 120;
  final num _experience = 7;
  final num _vote = 5.0;
  final num _comment = 100;
  final String _aboutMe =
      "Tôi đã có nhiều kinh nghiệm phiên dịch trên lĩnh vực Pháp luật và Y tế, thành thạo các kỹ năng tin học văn phòng.";
  final String _field = "Pháp luật";
  final String _email = "tucongminh3008@gmail.com";
  final String _phoneNumber = "0931368443";
  String colorrr = "0xFF4CAF4F";


  Future<void> getDataUser() async {
    bool isLogin = await AuthService.checkLogin();
    if (isLogin) {
      Users user = await AccountService.fetchUserByAccountId(FirebaseAuth.instance.currentUser!.uid);
      setState(() {
        userInfo = user;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _idInterpreter = widget.idInterpreter;
    getDataUser();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top:20, left: 20, right: 20, bottom: 20),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ==== Header ====
          Container(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2), // Màu của bóng đổ
                  spreadRadius: 5, // Bán kính lan của bóng đổ
                  blurRadius: 7, // Bán kính mờ của bóng đổ
                  offset: const Offset(0, 3),
                )
              ], // Vị trí bóng đổ (x, y)
            ),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    // Điều chỉnh giá trị này theo ý muốn
                    child: Image.asset('assets/images/img_interpreter.png'),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.only(left: 25, right: 20),
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // ==== Name and Role ====
                      Expanded(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                data: _fullname,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              CustomText(
                                data: _role,
                                fontSize: 16,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      ),

                      // ==== Vote ====
                      Expanded(
                        child: Container(
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
                                data: " (122 reviews)",
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          // ==== Content ====
          Container(
            child: Column(
              children: [
                const SizedBox(height: 10),
                // ==== Count Info ====
                Container(
                  child: Row(
                    children: [
                      Expanded(
                          child: InfoInterpreter(
                              Icons.supervisor_account_outlined,
                              _countCustomer,
                              "Khách hàng")),
                      Expanded(
                          child: InfoInterpreter(
                              Icons.call_merge, _experience, "Kinh nghiệm")),
                      Expanded(
                          child: InfoInterpreter(
                              Icons.comment, _comment, "Bình luận")),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                // ==== AboutMe ====
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        data: "Tiểu sử chi tiết",
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 4),
                      CustomText(
                        data: _aboutMe,
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                // Field and chứng chỉ
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
              ],
            ),
          ),
          // ==== Hr =====
          Container(
            // padding: EdgeInsets.only(left: 20, right: 20),
            child: const Divider(
              color: Colors.grey, // Đặt màu sắc cho thanh ngang
              thickness: 1, // Đặt độ dày của thanh ngang
            ),
          ),
          const SizedBox(height: 6),
          // ==== Button ====
          Container(
            alignment: Alignment.center,
            child: ElevatedButton(
                onPressed: () {
                  // Xử lý sự kiện khi nhấn nút
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(builder:
                          (BuildContext context, StateSetter setState) {
                        return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: IntrinsicHeight(
                              child: SizedBox(
                                width: 340,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // ==== Header Dialog ====
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 20.0,
                                          right: 20.0,
                                          top: 4,
                                          bottom: 4),
                                      decoration: const BoxDecoration(
                                          color: Color(0xFF4CAF4F),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10.0),
                                            topRight: Radius.circular(10.0),
                                          )),
                                      child: Row(
                                        children: [
                                          const Expanded(
                                              child: CustomText(
                                            data: 'Liên hệ đến phiên dịch viên',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            textAlign: TextAlign.center,
                                            color: Colors.white,
                                          )),
                                          IconButton(
                                            icon: const Icon(
                                              FontAwesomeIcons.xmark,
                                              color: Colors.white,
                                            ),
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(); // Đóng showDialog
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    // ==== Content Dialog ====
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: Row(
                                        children: [
                                          const Expanded(
                                              child: CustomText(
                                            data:
                                                "Để xem thông tin liên hệ bạn phải tốn 5 Credit? Bạn có chấp nhận?",
                                            textAlign: TextAlign.justify,
                                            fontSize: 15,
                                          )),
                                          Expanded(
                                              child: Image.asset(
                                                  'assets/images/info_contact.png')),
                                        ],
                                      ),
                                    ),
                                    // ==== Button Dialog =====
                                    const SizedBox(height: 8),
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: Row(
                                        children: [
                                          //==== Button Quay Lại ====
                                          Expanded(
                                            child: ElevatedButton(
                                              onPressed: () {
                                                // Xử lý sự kiện khi nhấn nút
                                                Navigator.of(context).pop();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                // backgroundColor: Colors.green, // Đổi màu nền
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 18,
                                                        vertical: 12),
                                                // Thêm padding
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16), // Điều chỉnh độ bo góc
                                                ),
                                                shadowColor: Colors.black,
                                                // Màu của bóng đổ
                                                elevation: 8,
                                              ),
                                              child: const CustomText(
                                                data: "Quay lại",
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          //==== Button Tiếp Tục Xem ====
                                          Expanded(
                                            child: ElevatedButton(
                                              onPressed: () {
                                                // Xử lý sự kiện khi nhấn nút
                                                Users user = Users(
                                                  accountId: userInfo!.accountId,
                                                  fullName: userInfo!.fullName,
                                                  email: userInfo!.email,
                                                  address: userInfo!.address,
                                                  phone: userInfo!.phone,
                                                  biography: userInfo!.biography,
                                                  status: userInfo!.status,
                                                  roleId: userInfo!.roleId,
                                                  birthday: userInfo!.birthday,
                                                  imagePath: "image.png",
                                                  fieldId: userInfo!.fieldId,
                                                  languageId: userInfo!.languageId,
                                                  credit: userInfo!.credit - 5,
                                                );
                                                profileService.updateData(userInfo!.userId ?? userInfo!.accountId, user.toMap());

                                                Navigator.of(context).pop();
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return StatefulBuilder(
                                                        builder: (BuildContext
                                                                context,
                                                            StateSetter
                                                                setState) {
                                                      return Dialog(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: IntrinsicHeight(
                                                          child: SizedBox(
                                                            width: 340,
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                // ==== Header =====
                                                                Container(
                                                                  padding: const EdgeInsets
                                                                      .only(
                                                                      left:
                                                                          20.0,
                                                                      right:
                                                                          20.0,
                                                                      top: 4,
                                                                      bottom:
                                                                          4),
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                          color: Colors
                                                                              .white,
                                                                          borderRadius:
                                                                              BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(10.0),
                                                                            topRight:
                                                                                Radius.circular(10.0),
                                                                          )),
                                                                  child: Column(
                                                                    children: [
                                                                      // ==== Icon Close ====
                                                                      Container(
                                                                        alignment:
                                                                            Alignment.centerRight,
                                                                        child:
                                                                            IconButton(
                                                                          icon:
                                                                              const Icon(
                                                                            FontAwesomeIcons.xmark,
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.of(context).pop(); // Đóng showDialog
                                                                          },
                                                                        ),
                                                                      ),
                                                                      // ===== Title ====
                                                                      Container(
                                                                        child:
                                                                            const Row(
                                                                          children: [
                                                                            CustomText(
                                                                              data: 'Thông tin liên hệ',
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 16,
                                                                              textAlign: TextAlign.center,
                                                                              color: Color(0xFF4CAF4F),
                                                                            ),
                                                                            SizedBox(width: 4),
                                                                            Icon(
                                                                              Icons.account_box_rounded,
                                                                              color: Color(0xFF4CAF4F),
                                                                              size: 24,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      // ==== Hr =====
                                                                      Container(
                                                                        // padding: EdgeInsets.only(left: 20, right: 20),
                                                                        child:
                                                                            const Divider(
                                                                          color:
                                                                              Colors.black,
                                                                          // Đặt màu sắc cho thanh ngang
                                                                          thickness:
                                                                              2, // Đặt độ dày của thanh ngang
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),

                                                                // ==== Content ====
                                                                Container(
                                                                  padding: const EdgeInsets
                                                                      .only(
                                                                      left:
                                                                          20.0,
                                                                      right:
                                                                          20.0),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      // ==== Email ====
                                                                      Container(
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            const CustomText(
                                                                              data: "Email",
                                                                              fontWeight: FontWeight.bold,
                                                                              textAlign: TextAlign.left,
                                                                            ),
                                                                            const SizedBox(height: 4),
                                                                            Container(
                                                                              padding: const EdgeInsets.only(top: 6, bottom: 6, left: 10, right: 10),
                                                                              decoration: BoxDecoration(
                                                                                color: Colors.grey,
                                                                                // Màu nền của Container
                                                                                borderRadius: BorderRadius.circular(10),
                                                                                boxShadow: [
                                                                                  BoxShadow(
                                                                                    color: Colors.black.withOpacity(0.2),
                                                                                    // Màu của bóng đổ
                                                                                    spreadRadius: 5,
                                                                                    // Bán kính lan của bóng đổ
                                                                                    blurRadius: 7,
                                                                                    // Bán kính mờ của bóng đổ
                                                                                    offset: const Offset(0, 3), // Vị trí bóng đổ (x, y)
                                                                                  ),
                                                                                ], // Đặt giá trị bo góc
                                                                              ),
                                                                              child: Row(
                                                                                children: [
                                                                                  Expanded(
                                                                                      child: CustomText(
                                                                                    data: _email,
                                                                                    color: Colors.white,
                                                                                    textAlign: TextAlign.left,
                                                                                  )),
                                                                                  Container(
                                                                                      alignment: Alignment.centerRight,
                                                                                      child: const Icon(
                                                                                        Icons.email,
                                                                                        color: Colors.white,
                                                                                      )),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              10),
                                                                      // ==== Phone Number ====
                                                                      Container(
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            const CustomText(
                                                                              data: "Số điện thoại",
                                                                              fontWeight: FontWeight.bold,
                                                                              textAlign: TextAlign.left,
                                                                            ),
                                                                            const SizedBox(height: 4),
                                                                            Container(
                                                                              padding: const EdgeInsets.only(top: 6, bottom: 6, left: 10, right: 10),
                                                                              decoration: BoxDecoration(
                                                                                color: Colors.grey,
                                                                                // Màu nền của Container
                                                                                borderRadius: BorderRadius.circular(10),
                                                                                boxShadow: [
                                                                                  BoxShadow(
                                                                                    color: Colors.black.withOpacity(0.2),
                                                                                    // Màu của bóng đổ
                                                                                    spreadRadius: 5,
                                                                                    // Bán kính lan của bóng đổ
                                                                                    blurRadius: 7,
                                                                                    // Bán kính mờ của bóng đổ
                                                                                    offset: const Offset(0, 3), // Vị trí bóng đổ (x, y)
                                                                                  ),
                                                                                ], // Đặt giá trị bo góc
                                                                              ),
                                                                              child: Row(
                                                                                children: [
                                                                                  Expanded(
                                                                                      child: CustomText(
                                                                                    data: _phoneNumber,
                                                                                    color: Colors.white,
                                                                                    textAlign: TextAlign.left,
                                                                                  )),
                                                                                  Container(
                                                                                      alignment: Alignment.centerRight,
                                                                                      child: const Icon(
                                                                                        Icons.wifi_calling_3,
                                                                                        color: Colors.white,
                                                                                      )),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              6),
                                                                      // ==== Hr ====
                                                                      Container(
                                                                        // padding: EdgeInsets.only(left: 20, right: 20),
                                                                        child:
                                                                            const Divider(
                                                                          color:
                                                                              Colors.black,
                                                                          // Đặt màu sắc cho thanh ngang
                                                                          thickness:
                                                                              2, // Đặt độ dày của thanh ngang
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),

                                                                // ==== Footer ====
                                                                Container(
                                                                  width: double
                                                                      .infinity,
                                                                  padding: const EdgeInsets
                                                                      .only(
                                                                      top: 4,
                                                                      bottom:
                                                                          20,
                                                                      left: 20,
                                                                      right:
                                                                          20),
                                                                  child:
                                                                      ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      // Xử lý sự kiện khi nhấn nút
                                                                    },
                                                                    style: ElevatedButton
                                                                        .styleFrom(
                                                                      backgroundColor:
                                                                          const Color(
                                                                              0xFF4CAF4F),
                                                                      // Đổi màu nền
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          horizontal:
                                                                              24,
                                                                          vertical:
                                                                              12),
                                                                      // Thêm padding
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10), // Giảm độ bo góc
                                                                      ),
                                                                      shadowColor:
                                                                          Colors
                                                                              .black,
                                                                      // Màu của bóng đổ
                                                                      elevation:
                                                                          8,
                                                                    ),
                                                                    child:
                                                                        const Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      // Đảm bảo nút không chiếm toàn bộ chiều rộng
                                                                      children: [
                                                                        CustomText(
                                                                          data:
                                                                              "Nhắn tin ngay",
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                        SizedBox(
                                                                            width:
                                                                                8),
                                                                        // Khoảng cách giữa icon và text
                                                                        Icon(
                                                                          FontAwesomeIcons
                                                                              .comments,
                                                                          size:
                                                                              24,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    });
                                                  },
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.green,
                                                // Đổi màu nền
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 18,
                                                        vertical: 12),
                                                // Thêm padding
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16), // Điều chỉnh độ bo góc
                                                ),
                                                shadowColor: Colors.black,
                                                // Màu của bóng đổ
                                                elevation: 8,
                                              ),
                                              child: const CustomText(
                                                data: "Tiếp tục xem",
                                                color: Colors.white,
                                                fontSize: 15,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                  ],
                                ),
                              ),
                            ));
                      });
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF4F),
                  // Đổi màu nền
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  // Thêm padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Giảm độ bo góc
                  ),
                  shadowColor: Colors.black,
                  // Màu của bóng đổ
                  elevation: 8,
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  // Đảm bảo nút không chiếm toàn bộ chiều rộng
                  children: [
                    Icon(
                      Icons.wifi_calling_3_sharp,
                      size: 24,
                      color: Colors.white,
                    ), // Thêm icon trước nội dung
                    SizedBox(width: 6), // Khoảng cách giữa icon và text
                    CustomText(
                      data: "Liên hệ ngay (8:00 - 17h00 PM)",
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                )),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class InfoInterpreter extends StatelessWidget {
  IconData icon;
  num value;
  String title;

  InfoInterpreter(this.icon, this.value, this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          // Icon
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: const Color(0xFFEDEDFC), // Color
                borderRadius: BorderRadius.circular(50)),
            child: Icon(
              icon,
              color: const Color(0xFF4CAF4F),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          CustomText(
            data: "$value+",
            fontSize: 16,
          ),
          CustomText(
            data: title,
            fontSize: 16,
            color: Colors.grey,
          ),
        ],
      ),
    );
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
