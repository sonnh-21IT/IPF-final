import 'package:config/base/base_screen.dart';
import 'package:config/utils/components/app_toolbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/components/component.dart';
import 'inter_profile_screen.dart';

class ListInterScreen extends StatefulWidget {
  const ListInterScreen({super.key});

  @override
  State<ListInterScreen> createState() => _ListInterScreenState();
}

class _ListInterScreenState extends State<ListInterScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        toolbar: AppToolbar(
          title: "Danh sách phiên dịch viên",
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
        ),
        body: const ContentApp());
  }
}

class ContentApp extends StatefulWidget {
  const ContentApp({super.key});

  @override
  _StateContent createState() => _StateContent();
}

class _StateContent extends State<ContentApp> {
  // Final Variable
  final TextEditingController _valueSearch = TextEditingController();
  late final List<String> _list = [
    "Lĩnh vực",
    "Ngôn ngữ",
    "Đánh giá",
  ];
  late ValueNotifier<String> _valueNotifier;
  String? selectValue;
  final String _idInterpreter = "1";
  final String _imgBackgground = "assets/images/background_interpreter.png";
  final String _aboutMe =
      "Tôi đã có nhiều kinh nghiệm phiên dịch trên lĩnh vực Pháp luật và Y tế, thành thạo các kỹ năng tin học văn phòng.";
  final String _avata = "assets/images/avatar.jpg";
  final String _fullname = "Từ Công Minh";
  final num _vote = 4.7;
  final num _review = 275;
  final String _language = "Tiếng Hàn";

  final String _idInterpreter2 = "2";
  final String _imgBackgground2 = "assets/images/interpreter-2.png";
  final String _aboutMe2 =
      "Có kinh nghiệm phiên dịch các tài liệu kỹ thuật, hướng dẫn sử dụng phần mềm và các bài báo khoa học về AI, Big Data.";
  final String _avata2 = "assets/images/app_img/avatar.png";
  final String _fullname2 = "Trần Quang";
  final num _vote2 = 4.8;
  final num _review2 = 125;
  final String _language2 = "Tiếng Pháp";

  final String _idInterpreter3 = "3";
  final String _imgBackgground3 = "assets/images/iterpreter_bg_3.jpg";
  final String _aboutMe3 =
      "Thành thạo phiên dịch các cuộc họp, hội thảo về khởi nghiệp, phát triển ứng dụng và bảo mật thông tin.";
  final String _avata3 = "assets/images/img_interpreter.png";
  final String _fullname3 = "Nguyễn Hồng Sơn";
  final num _vote3 = 4.4;
  final num _review3 = 212;
  final String _language3 = "Tiếng Anh";
  String colorrr = "0xFF4CAF4F";

  @override
  void initState() {
    super.initState();
    _valueNotifier = ValueNotifier<String>(_list.isNotEmpty ? _list[0] : '');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // padding: const EdgeInsets.only(top: 10 ,left: 20, right: 20, bottom: 20),
        color: Colors.white,
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // ==== Search ====
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Color
                  borderRadius: BorderRadius.circular(50), // Border Radius
                  border: Border.all(
                    color: const Color(0xFF4CAF4F),
                    width: 1,
                  ), // Boder
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2), // Màu của bóng đổ
                      spreadRadius: 5, // Bán kính lan của bóng đổ
                      blurRadius: 7, // Bán kính mờ của bóng đổ
                      offset: const Offset(0, 3),
                    )
                  ], // Vị trí bóng đổ (x, y)
                ),
                child: Row(
                  children: [
                    //==== Input Search ====
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: TextField(
                          controller: _valueSearch,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                          decoration: const InputDecoration(
                              hintText: "Nhập thông tin tìm kiếm",
                              hintStyle: TextStyle(
                                color: Color(0xFF939393),
                              ),
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  // Bo góc trên bên trái
                                  bottomLeft: Radius.circular(
                                      50), // Bo góc dưới bên trái
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF4CAF4F),
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  // Bo góc trên bên trái
                                  bottomLeft: Radius.circular(
                                      50), // Bo góc dưới bên trái
                                ),
                              )),
                        ),
                      ),
                    ),
                    // ==== Button ====
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          // Xử lý sự kiện khi nhấn nút
                          print("Value_Seach: ${_valueSearch.text}");
                          print("Select Filter: $selectValue");
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4CAF4F),
                          // Đổi màu nền
                          padding: const EdgeInsets.only(
                              top: 12, bottom: 12, left: 10, right: 10),
                          // Thêm padding
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(50),
                              // Bo góc trên bên trái
                              bottomRight:
                                  Radius.circular(50), // Bo góc dưới bên trái
                            ), // Giảm độ bo góc
                          ),
                        ),
                        child: const Row(
                          children: [
                            CustomText(
                                data: "Tìm kiếm",
                                fontSize: 16,
                                color: Colors.white),
                            SizedBox(
                              width: 4,
                            ),
                            Icon(
                              FontAwesomeIcons.searchengin,
                              color: Colors.white,
                              size: 24,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            // ==== Filter ====
            Container(
              width: 220,
              margin: EdgeInsets.only(left: 20, right: 20),
              padding: const EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                color: Colors.white, // Color
                borderRadius: BorderRadius.circular(10), // Border Radius
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ), // Boder
                // Vị trí bóng đổ (x, y)
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.filter_list_alt,
                    color: Colors.grey,
                    size: 24,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  const CustomText(
                    data: "Lọc theo: ",
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white, // Màu nền của DropdownButton
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ValueListenableBuilder<String>(
                        valueListenable: _valueNotifier,
                        builder: (context, value, child) {
                          return DropdownButton<String>(
                            value: selectValue,
                            hint: const CustomText(
                                data: "Lĩnh vực",
                                fontSize: 16,
                                color: Colors.black),
                            icon: const FaIcon(
                              FontAwesomeIcons.chevronDown,
                              color: Colors.black,
                              size: 16,
                            ),
                            elevation: 18,
                            style: const TextStyle(color: Colors.black),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  selectValue = newValue;
                                });
                              }
                            },
                            items: _list
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: CustomText(
                                  data: value,
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              );
                            }).toList(),
                            underline: Container(),
                            isExpanded: true,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // ==== Top Rated ====
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ==== Title ====
                  const Row(
                    children: [
                      Icon(
                        Icons.local_fire_department,
                        color: Colors.red,
                        size: 28,
                      ),
                      CustomText(
                        data: "Top Rated",
                        color: Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  // ==== List ====
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(width: 4),
                        Flexible(
                            fit: FlexFit.loose,
                            child: ItemInterpreterTopRate(
                                _idInterpreter,
                                _imgBackgground,
                                _aboutMe,
                                _avata,
                                _fullname,
                                _language,
                                _vote,
                                _review)),
                        Flexible(
                            fit: FlexFit.loose,
                            child: ItemInterpreterTopRate(
                                _idInterpreter2,
                                _imgBackgground2,
                                _aboutMe2,
                                _avata2,
                                _fullname2,
                                _language2,
                                _vote2,
                                _review2)),
                        Flexible(
                            fit: FlexFit.loose,
                            child: ItemInterpreterTopRate(
                                _idInterpreter3,
                                _imgBackgground3,
                                _aboutMe3,
                                _avata3,
                                _fullname3,
                                _language3,
                                _vote3,
                                _review3)),
                        Flexible(
                            fit: FlexFit.loose,
                            child: ItemInterpreterTopRate(
                                _idInterpreter2,
                                _imgBackgground2,
                                _aboutMe2,
                                _avata2,
                                _fullname2,
                                _language2,
                                _vote2,
                                _review2)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // ==== Content List Interpreter ====
            const ContentListInterpreter(),
          ]),
        ));
  }
}

class ItemInterpreterTopRate extends StatelessWidget {
  String idInterpreter;
  String imgBackground;
  String aboutMe;
  String avata;
  String fullName;
  String language;
  num vote;
  num review;

  ItemInterpreterTopRate(this.idInterpreter, this.imgBackground, this.aboutMe,
      this.avata, this.fullName, this.language, this.vote, this.review,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => InterProfileScreen(
                      idInterpreter: idInterpreter,
                    )));
      },
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          children: [
            Container(
              width: 240,
              decoration: BoxDecoration(
                color: Colors.white, // Color
                borderRadius: BorderRadius.circular(10), // Border Radius
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // Màu của bóng đổ
                    spreadRadius: 2, // Bán kính lan của bóng đổ
                    blurRadius: 5, // Bán kính mờ của bóng đổ
                    offset: const Offset(0, 3),
                  )
                ], // Vị trí bóng đổ (x, y)
              ),
              child: Column(
                children: [
                  // ==== Background and AboutMe ====
                  Container(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 4),
                    // color: Colors.white,
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          // Điều chỉnh giá trị này theo ý muốn
                          child: Image.asset(imgBackground),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          aboutMe,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.justify,
                          maxLines: 3,
                          overflow: TextOverflow
                              .ellipsis, // Hiển thị dấu "..." khi văn bản vượt quá số dòng tối đa
                        ),
                      ],
                    ),
                  ),
                  // ==== Hr ====
                  Container(
                    child: const Divider(
                      color: Colors.grey, // Đặt màu sắc cho thanh ngang
                      thickness: 1, // Đặt độ dày của thanh ngang
                    ),
                  ),
                  // ==== Info ====
                  Container(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 4, bottom: 10),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: CircleAvatar(
                              radius: 80,
                              backgroundImage:
                                  AssetImage(avata) as ImageProvider,
                              child: Container()),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  data: fullName,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  textAlign: TextAlign.left,
                                ),
                                CustomText(
                                  data: language,
                                  fontSize: 16,
                                  textAlign: TextAlign.left,
                                  color: Colors.grey,
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                        size: 24,
                                      ),
                                      CustomText(
                                        data: "$vote",
                                        fontWeight: FontWeight.bold,
                                      ),
                                      const SizedBox(width: 4),
                                      CustomText(data: "($review)"),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                          "assets/images/star_toprate.png"),
                                      const CustomText(
                                        data: "Top Rated",
                                        color: Color(0xFF4CAF4F),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ],
                                  ),
                                ),
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
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}

class ItemInterpreter extends StatelessWidget {
  String idInterpreter;
  String location;
  String avata;
  String fullName;
  String language;
  num vote;
  num review;

  ItemInterpreter(this.idInterpreter, this.location, this.avata, this.fullName,
      this.language, this.vote, this.review,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            decoration: BoxDecoration(
              color: Colors.white, // Color
              borderRadius: BorderRadius.circular(10), // Border Radius
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2), // Màu của bóng đổ
                  spreadRadius: 5, // Bán kính lan của bóng đổ
                  blurRadius: 5, // Bán kính mờ của bóng đổ
                  offset: const Offset(0, 3),
                )
              ], // Vị trí bóng đổ (x, y)
            ),
            child: Column(
              children: [
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // ==== Avata ====
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 150,
                          child: Image.asset(avata),
                        ),
                      ),
                      const SizedBox(width: 6),
                      // ==== Info ====
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          width: 220,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                data: fullName,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                textAlign: TextAlign.left,
                              ),
                              CustomText(
                                data: language,
                                fontSize: 16,
                                textAlign: TextAlign.left,
                              ),
                              CustomText(
                                data: "Địa điểm: $location ",
                                fontSize: 16,
                                textAlign: TextAlign.left,
                                color: Colors.grey,
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                      size: 24,
                                    ),
                                    CustomText(
                                      data: "$vote",
                                      fontWeight: FontWeight.bold,
                                    ),
                                    const SizedBox(width: 4),
                                    CustomText(data: "($review)"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                // ==== Button ====
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  InterProfileScreen(
                                    idInterpreter: idInterpreter,
                                  )));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4CAF4F),
                      // Đổi màu nền
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      // Thêm padding
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8), // Giảm độ bo góc
                      ),
                      shadowColor: Colors.black,
                      // Màu của bóng đổ
                      elevation: 8,
                    ),
                    child: const CustomText(
                      data: "Xem hồ sơ",
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class ContentListInterpreter extends StatefulWidget {
  const ContentListInterpreter({super.key});

  @override
  _StateContentListInterpreter createState() => _StateContentListInterpreter();
}

class _StateContentListInterpreter extends State<ContentListInterpreter> {
  // Final Variable
  final String _idInterpreter = "1";
  final String _aboutMe =
      "Tôi đã có nhiều kinh nghiệm phiên dịch trên lĩnh vực Pháp luật và Y tế, thành thạo các kỹ năng tin học văn phòng.";
  final String _avata = "assets/images/img_interpreter.png";
  final String _fullname = "Nguyễn Hồng Sơn";
  final num _vote = 4.7;
  final num _review = 275;
  final String _language = "Tiếng Hàn";
  final String _location = "Đà nẵng";

  final String _idInterpreter1 = "2";
  final String _avata1 = "assets/images/avatar.jpg";
  final String _fullname1 = "Từ Công Minh";
  final num _vote1 = 4.8;
  final num _review1 = 135;
  final String _language1 = "Tiếng Anh";
  final String _location1 = "Quảng Bình";

  final String _idInterpreter2 = "3";
  final String _avata2 = 'assets/images/app_img/avatar.png';
  final String _fullname2 = "Trần Quang";
  final num _vote2 = 4.5;
  final num _review2 = 150;
  final String _language2 = "Tiếng Anh";
  final String _location2 = "Hà Nội";

  final String _idInterpreter3 = "4";
  final String _avata3 = "assets/images/img_interpreter.png";
  final String _fullname3 = "Nguyễn Thanh Minh";
  final num _vote3 = 4.8;
  final num _review3 = 320;
  final String _language3 = "Tiếng Nhật";
  final String _location3 = "Hồ Chí Minh";

  final String _idInterpreter4 = "5";
  final String _avata4 = "assets/images/img_interpreter.png";
  final String _fullname4 = "Nguyễn Thanh Quang";
  final num _vote4 = 4.6;
  final num _review4 = 200;
  final String _language4 = "Tiếng Trung";
  final String _location4 = "Hải Phòng";
  late int _countList;
  late List<Map<String, dynamic>> interpreters;

  @override
  void initState() {
    super.initState();
    interpreters = [
      {
        "idInterpreter": _idInterpreter,
        "location": _location,
        "avata": _avata,
        "fullName": _fullname,
        "language": _language,
        "vote": _vote,
        "review": _review
      },
      {
        "idInterpreter": _idInterpreter1,
        "location": _location1,
        "avata": _avata1,
        "fullName": _fullname1,
        "language": _language,
        "vote": _vote1,
        "review": _review1
      },
      {
        "idInterpreter": _idInterpreter2,
        "location": _location2,
        "avata": _avata2,
        "fullName": _fullname2,
        "language": _language2,
        "vote": _vote2,
        "review": _review2
      },
      {
        "idInterpreter": _idInterpreter3,
        "location": _location3,
        "avata": _avata3,
        "fullName": _fullname3,
        "language": _language3,
        "vote": _vote3,
        "review": _review3
      },
      {
        "idInterpreter": _idInterpreter4,
        "location": _location4,
        "avata": _avata4,
        "fullName": _fullname4,
        "language": _language4,
        "vote": _vote4,
        "review": _review4
      },
      {
        "idInterpreter": _idInterpreter1,
        "location": _location1,
        "avata": _avata1,
        "fullName": _fullname1,
        "language": _language1,
        "vote": _vote1,
        "review": _review1
      },
      {
        "idInterpreter": _idInterpreter2,
        "location": _location2,
        "avata": _avata2,
        "fullName": _fullname2,
        "language": _language2,
        "vote": _vote2,
        "review": _review2
      },
      // Thêm nhiều phần tử hơn nếu cần
    ];
    _countList = 5;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // ==== Title ====
            Container(
              child: const Row(
                children: [
                  Icon(
                    Icons.list_alt_outlined,
                    color: Color(0xFF4CAF4F),
                    size: 28,
                  ),
                  SizedBox(width: 4),
                  CustomText(
                    data: "Danh sách phiên dịch viên",
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(0xFF4CAF4F),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // ==== List ====
            ListView.builder(
              itemCount: _countList,
              shrinkWrap: true,
              // Cho phép ListView điều chỉnh chiều cao theo nội dung
              physics: const NeverScrollableScrollPhysics(),
              // Vô hiệu hóa cuộn riêng của ListView
              itemBuilder: (context, index) {
                final interpreter = interpreters[index];
                return ItemInterpreter(
                  interpreter['idInterpreter'],
                  interpreter['location'],
                  interpreter['avata'],
                  interpreter['fullName'],
                  interpreter['language'],
                  interpreter['vote'],
                  interpreter['review'],
                );
              },
            ),
            // ==== Button Show Continue ====
            Container(
              padding: const EdgeInsets.only(left: 40, right: 40),
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  // Xử lý sự kiện khi nhấn nút
                  setState(() {
                    int total = interpreters.length;
                    if (total - _countList >= 5) {
                      _countList += 5;
                    } else {
                      _countList += (total - _countList);
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF4F),
                  // Đổi màu nền
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  // Thêm padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Giảm độ bo góc
                  ),
                  shadowColor: Colors.black,
                  // Màu của bóng đổ
                  elevation: 8,
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomText(
                      data: "Xem tiếp",
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.add,
                      size: 24,
                      color: Colors.white,
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
