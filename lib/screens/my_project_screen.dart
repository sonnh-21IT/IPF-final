import 'package:config/base/base_screen.dart';
import 'package:config/utils/components/app_toolbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../utils/components/component.dart';

class MyProjectScreen extends StatelessWidget {
  final String idProject;

  const MyProjectScreen({super.key, required this.idProject});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        toolbar: AppToolbar(
          title: "Chi tiết dự án",
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
        ),
        body: SingleChildScrollView(
          child: ContentApp(idProject: idProject),
        ));
  }
}

class ContentApp extends StatefulWidget {
  final String idProject;

  const ContentApp({super.key, required this.idProject});

  @override
  _StateContent createState() => _StateContent();
}

class _StateContent extends State<ContentApp> {
  // Final Variable
  late String _idProject;
  final String _nameProject = "Pháp lý nhà đất ";
  final String _language = "Tiếng Hàn";
  final String _field = "Pháp luật";
  final String _type = "Fulltime";
  final String _location = "Đà Nẵng";
  final String _setDatePost = "27/10/2024"; // Chuỗi ngày tháng ban đầu
  late DateTime _datePost;
  final String _setDeadline = "07/11/2024";
  late DateTime _deadline;
  final String _typeSalary = "Theo dự án";
  final String _requestForInterpreter =
      "Giỏi giao tiếp, thành thạo tin học văn phòng và có nhiều kinh nghiệm trong lĩnh vực pháp luật.";
  late num _daysRemaining;
  final num _minSalary = 12000000;
  final num _maxSalary = 25000000;
  final String _email = "tucongminh3008@gmail.com";
  final String _phoneNumber = "0931368443";

  // Final Function

  IconData _getFieldIcon(String field) {
    switch (field) {
      case 'Pháp luật':
        return Icons.gavel; // Icon pháp luật
      case 'Du lịch':
        return Icons.card_travel; // Icon du lịch
      case 'Y tế':
        return Icons.local_hospital; // Icon y tế
      case 'Dự án công ty':
        return Icons.business_center; // Icon dự án công ty
      case 'Đào tạo và tư vấn':
        return Icons.school; // Icon đào tạo và tư vấn
      case 'Dịch vụ công':
        return Icons.public; // Icon dịch vụ công
      case 'Kinh doanh và thương mại':
        return Icons.shopping_cart;
      case 'tổ chức sự kiện':
        return Icons.event;
      default:
        return Icons.help; // Icon mặc định
    }
  }

  @override
  void initState() {
    super.initState();
    _idProject = widget.idProject;
    _datePost = DateFormat("dd/MM/yyyy").parse(_setDatePost);
    _deadline = DateFormat("dd/MM/yyyy").parse(_setDeadline);
    Duration difference = _deadline.difference(_datePost);
    _daysRemaining = difference.inDays;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20.0),
        color: Colors.white,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // ==== Header ===
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFF4CAF4F), // Màu viền xanh
                      width: 2, // Độ dày của viền
                    ),
                    borderRadius:
                        BorderRadius.circular(20), // Bo góc cho viền và ảnh
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    // Điều chỉnh giá trị này theo ý muốn
                    child: Image.asset('assets/images/img_project.png'),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                      top: 6, bottom: 10, left: 30, right: 30),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                data: _nameProject,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                textAlign: TextAlign.left,
                              ),
                              CustomText(
                                data: "$_language | $_field",
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                                textAlign: TextAlign.left,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.grey, // Màu nền của Container
                          borderRadius:
                              BorderRadius.circular(50), // Đặt giá trị bo góc
                        ),
                        child: Icon(
                          _getFieldIcon(_field),
                          size: 28,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ==== Content ====
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // padding: EdgeInsets.only(left: 20, right: 20),
                  child: const Divider(
                    color: Colors.grey, // Đặt màu sắc cho thanh ngang
                    thickness: 1, // Đặt độ dày của thanh ngang
                  ),
                ),
                const CustomText(
                  data: "Thông tin dự án",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.left,
                ),
                Container(
                  padding: const EdgeInsets.only(
                      left: 30, right: 30, top: 10, bottom: 10),
                  child: Column(
                    children: [
                      CustomContentInfoProject("Hình thức làm việc: ", _type),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomContentInfoProject(
                          "Địa điểm làm việc: ", _location),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomContentInfoProject(
                          "Hình thức trả lương: ", _typeSalary),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomContentInfoProject("Ngày đăng tải: ", _setDatePost),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomContentInfoProject("Ngày kết thúc: ", _setDeadline),
                    ],
                  ),
                ),
                const CustomText(
                  data: "Yêu cầu dành cho phiên dịch viên",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.left,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 4),
                  child: CustomText(
                    data: _requestForInterpreter,
                    fontSize: 16,
                    textAlign: TextAlign.justify,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  // padding: EdgeInsets.only(left: 20, right: 20),
                  child: const Divider(
                    color: Colors.grey, // Đặt màu sắc cho thanh ngang
                    thickness: 1, // Đặt độ dày của thanh ngang
                  ),
                ),
              ],
            ),
          ),

          // ==== Footer ====
          Container(
              child: Column(
            children: [
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child:
                        CustomFooterProject("Lương tối thiểu", "$_minSalary"),
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        children: [
                          const CustomText(
                            data: "Chỉ còn",
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xFF4CAF4F),
                                // Màu viền xanh
                                width: 2, // Độ dày của viền
                              ),
                              borderRadius: BorderRadius.circular(
                                  10), // Bo góc cho viền và ảnh
                            ),
                            child: CustomText(
                              data: "$_daysRemaining ngày",
                              fontSize: 15,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: CustomFooterProject("Lương tối đa", "$_maxSalary"),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // ==== Button Contact ====
              ElevatedButton(
                onPressed: () {
                  // ==== Alert Contact 5Credit ====
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
                                            data:
                                                'Liên hệ trực tiếp khách hàng',
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
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10), // Điều chỉnh độ bo góc
                  ),
                  shadowColor: Colors.black,
                  // Màu của bóng đổ
                  elevation: 8, // Thêm padding
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
                      data: "Liên hệ khách hàng",
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),
            ],
          )),
        ]));
  }
}

class CustomContentInfoProject extends StatelessWidget {
  String key_content;
  var value;

  CustomContentInfoProject(this.key_content, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
              child: Row(
            children: [
              const Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
              const SizedBox(width: 4),
              CustomText(data: key_content, fontSize: 16)
            ],
          )),
          Container(
            child: CustomText(
              data: "$value",
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomFooterProject extends StatelessWidget {
  String key_content;
  var value;

  CustomFooterProject(this.key_content, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CustomText(
            data: key_content,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 6,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFF4CAF4F), // Màu viền xanh
                width: 2, // Độ dày của viền
              ),
              borderRadius: BorderRadius.circular(10), // Bo góc cho viền và ảnh
            ),
            child: CustomText(
              data: "$value",
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

//==========================APP BAR=================================
class CustomAppbarProject extends StatelessWidget {
  String title;

  CustomAppbarProject(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 6),
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: AppBar(
        backgroundColor: Colors.white,
        leading: Container(
          decoration: BoxDecoration(
            color: Colors.green, // Màu nền
            borderRadius: BorderRadius.circular(50), // Bo góc
          ),
          child: IconButton(
            icon: const FaIcon(
              FontAwesomeIcons.chevronLeft,
              color: Colors.white,
              size: 16, // Kích thước biểu tượng
            ),
            onPressed: () {
              // Xử lý sự kiện khi nhấn nút quay lại
            },
          ),
        ),
        title:
            CustomText(data: title, fontWeight: FontWeight.bold, fontSize: 20),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.more_vert,
              size: 30,
            ), // Icon ở cuối AppBar
            onPressed: () {
              // Xử lý sự kiện khi nhấn icon
            },
          ),
        ],
      ),
    );
  }
}
