import 'package:config/base/base_screen.dart';
import 'package:config/models/project.dart';
import 'package:config/services/data_service.dart';
import 'package:config/utils/components/app_toolbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/components/component.dart';
import 'list_project_screen.dart';

class UpdateProjectScreen extends StatelessWidget {
  const UpdateProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      toolbar: AppToolbar(
        title: "Đăng dự án",
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: const SingleChildScrollView(
        child: ContentApp(),
      ),
    );
  }
}

class ContentApp extends StatefulWidget {
  const ContentApp({super.key});

  @override
  _StateContent createState() => _StateContent();
}

class _StateContent extends State<ContentApp> {
  // === Final Variable ===
  final TextEditingController _nameProject = TextEditingController();
  final TextEditingController _note = TextEditingController();
  final TextEditingController _minSalary = TextEditingController();
  final TextEditingController _maxSalary = TextEditingController();
  DateTime _dateTime = DateTime.now();
  String _field = '';
  String _type = '';
  String _location = '';
  String? _language;
  String? _certificate;
  String _salaryType = '';
  bool _isChecked = false;
  String _message = '';
  String _idDocument = '';
  Map<String, List<String>> languageCertificates = {
    'Tiếng Anh': ['IELTS', 'TOEFL', 'Cambridge'],
    'Tiếng Pháp': ['DELF', 'DALF', 'TCF'],
    'Tiếng Nhật': [
      'JLPT N1',
      'JLPT N2',
      'JLPT N3',
      'JLPT N4',
      'JLPT N5',
      'J-Test',
      'TOPJ'
    ],
    'Tiếng Hàn': [
      'TOPIK I - level 1',
      'TOPIK I - level 2',
      'TOPIK II - level 3',
      'TOPIK II - level 4',
      'TOPIK II - level 5',
      'TOPIK II - level 6',
      'EPS-TOPIK'
    ],
    'Tiếng Trung': ['HSK 1', 'HSK 2', 'HSK 3', 'HSK 4', 'HSK 5', 'HSK 6'],
    'Tiếng Đức': [
      'Goethe-Zertifikat A1',
      'Goethe-Zertifikat A2',
      'Goethe-Zertifikat B1',
      'Goethe-Zertifikat B2',
      'Goethe-Zertifikat C1',
      'Goethe-Zertifikat C2'
    ],
    'Tiếng Tây Ban Nha': [
      'DELE A1',
      'DELE A2',
      'DELE B1',
      'DELE B2',
      'DELE C1',
      'DELE C2'
    ],
    'Tiếng Ý': ['CELI 1', 'CELI 2', 'CELI 3', 'CELI 4', 'CELI 5'],
    'Tiếng Bồ Đào Nha': ['CAPLE 1', 'CAPLE 2', 'CAPLE 3', 'CAPLE 4', 'CAPLE 5'],
    'Tiếng Nga': ['TORFL 1', 'TORFL 2', 'TORFL 3', 'TORFL 4', 'TORFL 5'],
    'Tiếng Thái': ['DEP 1', 'DEP 2', 'DEP 3', 'DEP 4', 'DEP 5'],
  };
  Color borderColor = Colors.black;

  AccountService projectService = AccountService('project');

  // === Final Function ===
  void _getValueDropDown(String? newValue, String? type) {
    if (newValue != null) {
      if (type == "field") {
        _field = newValue;
      } else if (type == "type") {
        _type = newValue;
      } else if (type == "location") {
        _location = newValue;
      } else if (type == "language") {
        _language = newValue;
      } else if (type == "certificate") {
        _certificate = newValue;
      } else {
        _salaryType = newValue;
      }
    }
  }

  void _handleCheckboxChange(bool? value) {
    setState(() {
      _isChecked = value!;
    });
  }

  void _handleDatetime(DateTime newDatetime) {
    setState(() {
      _dateTime = newDatetime;
    });
  }

  bool areFieldsEmpty() {
    return _nameProject.text.isEmpty ||
        _note.text.isEmpty ||
        _minSalary.text.isEmpty ||
        _maxSalary.text.isEmpty ||
        _field.isEmpty ||
        _type.isEmpty ||
        _location.isEmpty ||
        _language!.isEmpty ||
        _certificate!.isEmpty ||
        _salaryType.isEmpty;
  }

  // === UI/UX ===
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ==================== Phần I ===========================
          const CustomTitle("I. Tên và lĩnh vực dự án"),
          const SizedBox(height: 20),
          CustomTextField(
              controller: _nameProject,
              title: "Tên dự án",
              hintText: "Tên dự án của bạn..."),
          const SizedBox(height: 10),
          CustomDropdownButton(
            hint: '-- Lĩnh vực --',
            title: "Lĩnh vực",
            list: const [
              'Y tế',
              'Pháp luật',
              'Sự kiện',
              'Du lịch',
              'Kinh doanh',
              'Giáo dục',
              'Nghệ thuật',
              'Thể thao',
              'Công nghệ',
              'Khác'
            ],
            onChanged: _getValueDropDown,
          ),
          const SizedBox(height: 20),

          //================== Phần II =============================
          const CustomTitle(
              "II. Thông tin và yêu cầu dành cho phiên dịch viên"),
          const SizedBox(height: 20),
          const CustomText(
            data:
                "Nội dung chi tiết, và các đầu việc cần thực hiện (càng chi tiết phiên dịch viên càng có đầy đủ thông tin để gửi báo cáo chính xác hơn)",
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 20),
          const CustomText(
            data:
                "Vui lòng không điền các thông tin liên lạc như email, số điện thoại, skype, viber, facebook v.v.. trong nội dung bên dưới đây. Bạn có thể sẽ bị khóa tài khoản vĩnh viễn, nếu vi phạm quy định của chúng tôi",
            color: Colors.red,
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 10),
          CustomTextArea(
            num_line: 5,
            hint_text:
                "Nhập các yêu cầu của bạn đối với phiên dịch viên thực hiện dự án...",
            controller: _note,
          ),
          const SizedBox(height: 10),
          const CustomText(
            data: "Thêm tài liệu đính kèm",
            color: Colors.blueAccent,
            fontStyle: FontStyle.italic,
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 10),
          CustomDropdownButton(
              hint: "-- Loại hình làm việc --",
              list: const ["Parttime", "Fulltime"],
              title: "Loại hình làm việc",
              onChanged: _getValueDropDown),
          const SizedBox(height: 20),

          // ======================== Phần III ===========================
          const CustomTitle("III. Yêu cầu khác dành cho phiên dịch viên"),
          const SizedBox(height: 20),
          CustomDropdownButton(
            hint: "-- Nơi làm việc --",
            list: const [
              "Hà Nội",
              "Đà Nẵng",
              "TP.Hồ Chí Minh",
              "Hải Phòng",
              "Cần Thơ",
              "Quảng Bình",
              "Quảng Nam",
              "Quảng Ngãi",
              "Quảng Ninh",
              "Quảng Trị",
              "Nghệ An",
              "Hà Tĩnh",
              "Thanh Hóa",
              "Thừa Thiên Huế",
              "Đắk Lắk",
              "Đắk Nông",
              "Gia Lai",
              "Kon Tum",
              "Lâm Đồng",
              "Bình Định",
            ],
            title: "Nơi làm việc",
            onChanged: _getValueDropDown,
          ),
          const SizedBox(height: 10),
          // CustomDropdownButton(
          //   list: ["-- Ngôn ngữ --", "Tiếng Anh", "Tiếng Hàn", "  Tiếng Nhật"],
          //   title: "Ngôn Ngữ",
          //   onChanged: _getValueDropDown,
          // ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  data: "Ngôn ngữ",
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 5),
                Focus(
                  onFocusChange: (hasFocus) {
                    setState(() {
                      borderColor =
                          hasFocus ? const Color(0xFF4CAF4F) : Colors.black;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      // Màu nền của DropdownButton
                      border: Border.all(color: borderColor, width: 1),
                      // Màu và độ rộng của viền
                      borderRadius: BorderRadius.circular(10), // Bo góc viền
                    ),
                    child: DropdownButton<String>(
                      hint: const CustomText(
                          data: "-- Ngôn ngữ --",
                          fontSize: 16,
                          color: Colors.black),
                      value: _language,
                      items: languageCertificates.keys.map((String language) {
                        return DropdownMenuItem<String>(
                          value: language,
                          child: CustomText(
                              data: language,
                              fontSize: 16,
                              color: Colors.black),
                        );
                      }).toList(),
                      icon: const FaIcon(
                        FontAwesomeIcons.chevronDown,
                        color: Colors.black,
                        size: 16,
                      ),
                      elevation: 18,
                      style: const TextStyle(color: Colors.black),
                      underline: Container(),
                      isExpanded: true,
                      onChanged: (String? newValue) {
                        setState(() {
                          _language = newValue!;
                          _certificate =
                              null; // Reset chứng chỉ khi thay đổi ngôn ngữ
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // CustomDropdownButton(
          //     list: ['-- Chứng chỉ --','${_language}'],
          //     title: "Chứng chỉ",
          //     onChanged: _getValueDropDown),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  data: "Chứng chỉ",
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 5),
                Focus(
                  onFocusChange: (hasFocus) {
                    setState(() {
                      borderColor =
                          hasFocus ? const Color(0xFF4CAF4F) : Colors.black;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      // Màu nền của DropdownButton
                      border: Border.all(color: borderColor, width: 1),
                      // Màu và độ rộng của viền
                      borderRadius: BorderRadius.circular(10), // Bo góc viền
                    ),
                    child: DropdownButton<String>(
                      hint: const CustomText(
                          data: "-- Chứng chỉ --",
                          fontSize: 16,
                          color: Colors.black),
                      value: _certificate,
                      items: _language != null
                          ? languageCertificates[_language]!
                              .map((String certificate) {
                              return DropdownMenuItem<String>(
                                value: certificate,
                                child: Text(certificate),
                              );
                            }).toList()
                          : [],
                      icon: const FaIcon(
                        FontAwesomeIcons.chevronDown,
                        color: Colors.black,
                        size: 16,
                      ),
                      elevation: 18,
                      style: const TextStyle(color: Colors.black),
                      underline: Container(),
                      isExpanded: true,
                      onChanged: (String? newValue) {
                        setState(() {
                          _certificate = newValue;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // ======================= Phần IV ==============================
          const CustomTitle("III. Thời hạn và ngân sách dự án"),
          const SizedBox(height: 20),
          DatePickerWidget(
            date: _dateTime,
            onDateChanged: _handleDatetime,
            title: "Thời hạn",
          ),
          const SizedBox(height: 10),
          CustomDropdownButton(
            hint: "-- Hình thức trả lương --",
            list: const ["Theo giờ", "Theo dự án", "Thỏa thuận"],
            title: "Hình thức trả lương",
            onChanged: _getValueDropDown,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                  child: CustomTextField(
                controller: _minSalary,
                title: "Thấp nhất",
                hintText: "Min",
                sunfixIcon: FontAwesomeIcons.circleDollarToSlot,
                keyboardType: TextInputType.number,
              )),
              const SizedBox(width: 40),
              Expanded(
                  child: CustomTextField(
                controller: _maxSalary,
                title: "Cao nhất",
                hintText: "Max",
                sunfixIcon: FontAwesomeIcons.circleDollarToSlot,
                keyboardType: TextInputType.number,
              )),
            ],
          ),
          const SizedBox(height: 10),
          Center(
            child: CustomText(
              data: _message,
              fontSize: 14,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              color: Colors.red,
              textAlign: TextAlign.center,
            ),
          ),
          CustomCheckbox(
              content:
                  "Khi đăng việc, tôi xác nhận đồng ý các điều khoản sử dụng của IPF, và không để lộ bất kỳ thông tin liên lạc cá nhân nào trong phần mô tả nội dung công việc.",
              value: _isChecked,
              onChanged: _handleCheckboxChange),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity, // Chiếm hết chiều ngang
            child: ElevatedButton(
              onPressed: () {
                if (areFieldsEmpty()) {
                  _message =
                      "Bạn đã nhập thiếu dữ liệu, vui lòng kiểm tra lại và cập nhật đầy đủ thông tin dự án trước khi đăng tải";
                  setState(() {});
                } else {
                  if (_isChecked == true) {
                    String date =
                        "${_dateTime.day}/${_dateTime.month}/${_dateTime.year}";
                    Project project = Project(
                      nameProject: _nameProject.text,
                      field: _field,
                      note: _note.text,
                      type: _type,
                      location: _location,
                      language: _language!,
                      certificate: _certificate!,
                      date: date,
                      salaryType: _salaryType,
                      minSalary: num.parse(_minSalary.text),
                      maxSalary: num.parse(_maxSalary.text),
                      isChecked: _isChecked,
                      status: 0,
                    );

                    projectService.addData(project.toMap());
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Container(
                            width: 300,
                            color: const Color(0x0081c784),
                            child: Row(
                              children: [
                                Image.asset(
                                    'assets/images/congratulations.png'),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: RichText(
                                    text: const TextSpan(
                                      children: [
                                        TextSpan(
                                          text:
                                              "Bạn đã đăng tải dự án thành công! ",
                                          style: TextStyle(
                                            color: Color(0xFF4CAF4F),
                                            fontSize: 16,
                                          ),
                                        ),
                                        TextSpan(
                                            text:
                                                "Chúng tôi sẽ xác nhận và nhanh chóng cập nhật dự án của bạn trên INF.",
                                            style: TextStyle(
                                              color: Color(0xFF4CAF4F),
                                              fontSize: 16,
                                            )),
                                      ],
                                    ),
                                    softWrap: true,
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              ListProjectScreen()));
                                },
                                child: const CustomText(
                                  data: "OK",
                                  color: Color(0xFF4CAF4F),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        );
                      },
                    );
                    _message = "";
                    setState(() {});
                  } else {
                    _message =
                        "Vui lòng đọc và đồng ý các điều khoản để có thể đăng dự án của bạn lên hệ thống!!!";
                    setState(() {});
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF4F),
                padding: const EdgeInsets.all(18), // Thêm padding
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Bo tròn góc
                ),
              ),
              child: const CustomText(
                data: 'Đăng dự án',
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
