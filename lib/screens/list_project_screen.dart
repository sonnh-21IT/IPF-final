import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:config/base/base_screen.dart';
import 'package:config/models/project.dart';
import 'package:config/services/project_service.dart';
import 'package:config/utils/components/app_toolbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/components/component.dart';
import 'my_project_screen.dart';

class ListProjectScreen extends StatefulWidget {
  const ListProjectScreen({super.key});

  @override
  State<ListProjectScreen> createState() => _ListProjectScreenState();
}

class _ListProjectScreenState extends State<ListProjectScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      toolbar: AppToolbar(
        title: "Danh sách dự án",
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: ContentApp(),
    );
  }
}

// ND Trang
class ContentApp extends StatefulWidget {
  const ContentApp({super.key});

  @override
  _StateContentApp createState() => _StateContentApp();
}

class _StateContentApp extends State<ContentApp> {
  // Final Variable
  final TextEditingController _valueSearch = TextEditingController();
  late final List<String> _list = [
    "Lĩnh vực",
    "Ngôn ngữ",
    "Đánh giá",
  ];
  late ValueNotifier<String> _valueNotifier;
  String? selectValue;
  final String _idProject = "1";
  final String _img = "assets/images/img_interpreter.png";
  final List<String> imageUrls = [
    'assets/images/travel.jpg',
    'assets/images/yte.png',
    'assets/images/education.jpg',
    'assets/images/img_project.png',
    'assets/images/kinhdoanh.jpg',
    'assets/images/img_interpreter.png',
    'assets/images/img_interpreter.png',
    'assets/images/img_interpreter.png',
  ];
  int _countList = 0;

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==== Search ====
              Container(
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
                            onChanged: (val) {
                              setState(() {
                                _valueSearch.text = val;
                              });
                            },
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
              )
            ),
              const SizedBox(height: 20),
              // ==== List Project ====
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                // height: ,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ==== Title ====
                    Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.list_alt_outlined,
                            color: Color(0xFF4CAF4F),
                            size: 28,
                          ),
                          SizedBox(width: 4),
                          CustomText(
                            data: "Danh sách dự án nổi bật",
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color(0xFF4CAF4F),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // ==== List ====
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('project')
                          .snapshots(),
                      builder: (context, snapshots) {
                        if (snapshots.connectionState ==
                            ConnectionState.waiting) {
                          print("========== Waiting ========");
                          return CircularProgressIndicator();
                        } else if (snapshots.hasError) {
                          print("========== Error: ${snapshots.error} ========");
                          return Text('Có lỗi xảy ra');
                        } else if (snapshots.hasData) {
                          print(
                              "========== Data received: ${snapshots.data!.docs.length} documents ========");
                          return ListView.builder(
                              itemCount: snapshots.data!.docs.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                var data = snapshots.data!.docs[index].data();
                                if (_valueSearch.text.isEmpty) {
                                  return ItemProject(
                                    _idProject,
                                    _img,
                                    data['nameProject'],
                                    data['language'],
                                    data['field'],
                                    data['type'],
                                    data['minSalary'],
                                    data['maxSalary'],
                                    data['date'],
                                  );
                                }
                                if (data['nameProject']
                                    .contains(_valueSearch.text)) {
                                  return ItemProject(
                                    _idProject,
                                    _img,
                                    data['nameProject'],
                                    data['language'],
                                    data['field'],
                                    data['type'],
                                    data['minSalary'],
                                    data['maxSalary'],
                                    data['date'],
                                  );
                                } else {
                                  return Container();
                                }
                              });
                        } else {
                          return Text('Không có dữ liệu');
                        }
                      },
                    ),
        
                    // ==== Button Show Continue ====
                  ],
                ),
              ),
            ],
          ),
      ));
  }
}

// 1. Item Project
class ItemProject extends StatelessWidget {
  String idProject;
  String img;
  String nameProject;
  String language;
  String field;
  String type;
  num minSalary;
  num maxSalary;
  String time;

  ItemProject(this.idProject, this.img, this.nameProject, this.language,
      this.field, this.type, this.minSalary, this.maxSalary, this.time,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding:
                const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
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
                Row(
                  children: [
                    // ==== Avata ====
                    Expanded(
                        child: SizedBox(
                      height: 150,
                      child: Image.asset(img),
                    )),
                    const SizedBox(width: 6),
                    // ==== Info ====
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              data: nameProject,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              textAlign: TextAlign.left,
                            ),
                            CustomText(
                              data: "$language | $field",
                              fontSize: 16,
                              textAlign: TextAlign.left,
                            ),
                            CustomText(
                              data: "Hình thức: $type",
                              fontSize: 16,
                              textAlign: TextAlign.left,
                            ),
                            CustomText(
                              data: "Thời gian: ${time} ",
                              fontSize: 16,
                              textAlign: TextAlign.left,
                              color: Colors.grey,
                              fontStyle: FontStyle.italic,
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 6, bottom: 6, left: 40, right: 40),
                              decoration: BoxDecoration(
                                color: Colors.grey, // Color
                                borderRadius:
                                    BorderRadius.circular(6), // Border Radius
                              ),
                              child: CustomText(
                                data: "$minSalary - ${maxSalary}tr",
                                color: Colors.white,
                                textAlign: TextAlign.center,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
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
                                  MyProjectScreen(
                                    idProject: idProject,
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
                      data: "Xem dự án",
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
