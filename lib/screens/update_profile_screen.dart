import 'dart:convert';
import 'dart:io';

import 'package:config/base/base_screen.dart';
import 'package:config/models/user.dart';
import 'package:config/screens/app_screen.dart';
import 'package:config/services/certificate_service.dart';
import 'package:config/services/data_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../models/certificate.dart';
import '../utils/components/component.dart';

class UpdateProfileScreen extends StatefulWidget {
  final Users user;

  const UpdateProfileScreen({super.key, required this.user});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  late Users userInfo;

  @override
  void initState() {
    super.initState();
    userInfo = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        body: SingleChildScrollView(
          child: ContentAppUpdate(userInfo: userInfo),
        ));
  }
}

class ContentAppUpdate extends StatefulWidget {
  final Users userInfo;

  const ContentAppUpdate({super.key, required this.userInfo});

  @override
  _StateContent createState() => _StateContent();
}

class _StateContent extends State<ContentAppUpdate> {
  // Final Variable
  late Users userInfo;
  late String _idUser;

  // Avatar
  File? _image_avatar;
  String? _path_avatar;
  final String _keyPath_avata = "img_avata";

  // Certificate
  File? _image_certificate;

  String? _path_certificate;
  final String _keyPath_certificate = "img_certificate";

  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _location = TextEditingController();
  final TextEditingController _description = TextEditingController(
      text:
      "Tôi có nhiều kinh nghiệm trong lĩnh vực dịch thuật có thể hỗ trợ tốt cho bạn trong các lĩnh vực mà bạn mong muốn.");

  String mode = '+84';
  String phonenumber = '0931368443';
  String? _language;
  String? _certificate;
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
    'Tiếng Ý': ['CELI 1', 'CELI 2', 'CELI 3', 'CELI 4', 'CELI 5'],
    'Tiếng Bồ Đào Nha': ['CAPLE 1', 'CAPLE 2', 'CAPLE 3', 'CAPLE 4', 'CAPLE 5'],
    'Tiếng Nga': ['TORFL 1', 'TORFL 2', 'TORFL 3', 'TORFL 4', 'TORFL 5'],
    'Tiếng Thái': ['DEP 1', 'DEP 2', 'DEP 3', 'DEP 4', 'DEP 5'],
  };

  Map<String, String> idLanguage = {
    'Tiếng Anh': 'iDRUHqE9moXNigg6ukJX',
    'Tiếng Pháp': 'mtEeK49x1ok5ZlXEq3A5',
    'Tiếng Nhật': 'zY4HaJX4MCHhNSoH8dSx',
    'Tiếng Hàn': 'ndXC1WAmvQBXjsSLaQJb',
    'Tiếng Ý': 'Z9PEd5g4FadOfvIE7JCy',
    'Tiếng Bồ Đào Nha': 'MJCU4RFTj6DVDCHye89E',
    'Tiếng Nga': 'Bv3UU2NmhSVY8AOUeCZd',
    'Tiếng Thái': 'N3hZEeDPYSSaJMXsZqBE',
  };

  Color borderColor = Colors.black;
  List<String> selectedField = ["Du lịch", "Pháp luật"];

  // Check xem đã cập nhật chứng chỉ chưa
  int _statusField = 0;

  String? selectedProvince = '48';
  String? selectedDistrict = '494';
  Map<String, String> city = {};
  Map<String, String> district = {};

  // DateTime _dateTime = DateTime.now();
  DateTime _dateTime = DateTime(
      2003,
      8,
      30,
      0,
      0,
      0,
      0,
      0);

  String _message = "";
  String _message_final = "";

  DataService profileService = DataService('user');
  late Certificate certificate;

  // Final Function
  // ** Upload 1 **
  Future<void> _pickImage(String type) async {
    try {
      var pickedFile =
      await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          if (type == "avata") {
            _image_avatar = File(pickedFile.path);
            saveImage(_keyPath_avata, _image_avatar!.path);
            _path_avatar = _image_avatar!.path;
          } else if (type == "certificate") {
            _image_certificate = File(pickedFile.path);
            // saveImage(_keyPath_certificate, _image_certificate!.path );
            _path_certificate = _image_certificate!.path;
          }
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> _pickImageCamera() async {
    try {
      var pickedFile =
      await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        setState(() {
          _image_certificate = File(pickedFile.path);
          // saveImage(_keyPath_certificate, _image_certificate!.path );
          _path_certificate = _image_certificate!.path;
        });
      }
    } catch (e) {
      print('Error picking image camera: $e');
    }
  }

  void saveImage(key, path) async {
    SharedPreferences saveImg = await SharedPreferences.getInstance();
    saveImg.setString(key, path);
  }

  void loadImage() async {
    SharedPreferences loadImg = await SharedPreferences.getInstance();
    setState(() {
      _path_avatar = loadImg.getString("img_avata");
    });
  }

  void _getValueDropDown(String? modeNumber, String? phoneNumber) {
    mode = modeNumber!;
    phonenumber = phoneNumber!;
  }

  void _getValueMultiSelectDropdown(List<String> items) {
    setState(() {
      selectedField = items;
    });
  }

  Future<void> fetchProvinces() async {
    final response =
    await http.get(Uri.parse('https://esgoo.net/api-tinhthanh/1/0.htm'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['data'];
      setState(() {
        city = Map.fromEntries(data.map((item) =>
            MapEntry(item['id'].toString(), item['name'].toString())));
        if (selectedProvince != null) {
          fetchDistricts(selectedProvince!);
        }
      });
    } else {
      throw Exception('Failed to load provinces');
    }
  }

  Future<void> fetchDistricts(String province) async {
    final response = await http
        .get(Uri.parse('https://esgoo.net/api-tinhthanh/2/$province.htm'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['data'];
      setState(() {
        district = Map.fromEntries(data.map((item) =>
            MapEntry(item['id'].toString(), item['full_name'].toString())));
      });
    } else {
      throw Exception('Failed to load districts');
    }
  }

  void _handleDatetime(DateTime newDatetime) {
    setState(() {
      _dateTime = newDatetime;
    });
  }

  void _updateStatusField() {
    setState(() {
      _statusField = 2;
      print("statusField updated to $_statusField");
    });
  }

    Future<void> _getStatus () async {
    certificate = (await CertificateService.readCertificate(_idUser))!;
    _statusField= certificate?.status ?? 0 ;
  }

  @override
  void initState() {
    super.initState();
    fetchProvinces();
    userInfo = widget.userInfo;
    _idUser = userInfo.userId!;
     _getStatus();
    loadImage();
  }

  void _showSuccessMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: [
              Image.asset('assets/images/congratulations.png'),
              const SizedBox(width: 10),
              Expanded(
                child: RichText(
                  text: const TextSpan(
                    text: "Cập nhật dữ liệu thành công!",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF4CAF4F),
                    ),
                  ),
                  softWrap: true,
                  overflow: TextOverflow.clip,
                ),
              ),
            ],
          ),
        );
      },
    );

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pop(); // Close the dialog
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) =>
            const AppScreen(
              currentIndex: 0,
            )), // Navigate to home screen
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      color: Colors.white,
      child: Column(
        children: [
          Center(
            child: GestureDetector(
                onTap: () async {
                  await _pickImage("avata");
                },
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
                      backgroundImage: _path_avatar != null &&
                          _path_avatar!.isNotEmpty
                          ? FileImage(File(_path_avatar!))
                          : const AssetImage('assets/images/avata_default.png')
                      as ImageProvider,
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              child: const Icon(
                                Icons.add_a_photo,
                                size: 30,
                                color: Color(0xFF4CAF4F),
                              ),
                            ),
                          ),
                        ],
                      )),
                )),
          ),
          const SizedBox(height: 20),
          CustomTextField(
              controller: _fullName,
              title: "Fullname",
              hintText: userInfo.fullName ?? "Cập nhật tên của bạn..."),
          const SizedBox(height: 10),
          CustomTextField(
              controller: _email,
              title: "Email",
              hintText: userInfo.email ?? "Cập nhật email của bạn..."),
          const SizedBox(height: 10),
          CustomContactNumber(
              modeNumber: mode,
              phoneNumber: userInfo.phone ?? phonenumber,
              onChanged: _getValueDropDown),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: CustomMultiSelectDropdown(
                  items: selectedField,
                  onSelectionChanged:
                  _getValueMultiSelectDropdown, // Cập nhật lĩnh vực...
                ), // Cập nhật lĩnh vực...
              ),
              const SizedBox(width: 20),
              Expanded(
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
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
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
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0,
                                                  right: 20.0,
                                                  top: 4,
                                                  bottom: 4),
                                              decoration: const BoxDecoration(
                                                  color: Color(0XFF979797),
                                                  borderRadius:
                                                  BorderRadius.only(
                                                    topLeft:
                                                    Radius.circular(10.0),
                                                    topRight:
                                                    Radius.circular(10.0),
                                                  )),
                                              child: Row(
                                                children: [
                                                  const Expanded(
                                                      child: CustomText(
                                                        data:
                                                        'Cập nhật chứng chỉ của bạn',
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        fontSize: 16,
                                                        textAlign: TextAlign
                                                            .center,
                                                      )),
                                                  IconButton(
                                                    icon: const Icon(
                                                        FontAwesomeIcons.xmark),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop(); // Đóng showDialog
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 20, right: 20),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  // === DROPDOWNBUTTON LANGUAGE ===
                                                  Expanded(
                                                    child: Container(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          const CustomText(
                                                            data: "Ngôn ngữ",
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            fontSize: 16,
                                                            textAlign:
                                                            TextAlign.left,
                                                          ),
                                                          const SizedBox(
                                                              height: 5),
                                                          Focus(
                                                            onFocusChange:
                                                                (hasFocus) {
                                                              setState(() {
                                                                borderColor =
                                                                hasFocus
                                                                    ? const Color(
                                                                    0xFF4CAF4F)
                                                                    : Colors
                                                                    .black;
                                                              });
                                                            },
                                                            child: Container(
                                                              padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10,
                                                                  right:
                                                                  10),
                                                              width: double
                                                                  .infinity,
                                                              decoration:
                                                              BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                border: Border
                                                                    .all(
                                                                    color:
                                                                    borderColor,
                                                                    width: 1),
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                              ),
                                                              child:
                                                              DropdownButton<
                                                                  String>(
                                                                hint: const CustomText(
                                                                    data:
                                                                    "-- Ngôn ngữ --",
                                                                    fontSize:
                                                                    16,
                                                                    color: Colors
                                                                        .black),
                                                                value:
                                                                _language,
                                                                items: languageCertificates
                                                                    .keys
                                                                    .map((String
                                                                language) {
                                                                  return DropdownMenuItem<
                                                                      String>(
                                                                    value:
                                                                    language,
                                                                    child: CustomText(
                                                                        data:
                                                                        language,
                                                                        fontSize:
                                                                        16,
                                                                        color: Colors
                                                                            .black),
                                                                  );
                                                                }).toList(),
                                                                icon:
                                                                const FaIcon(
                                                                  FontAwesomeIcons
                                                                      .chevronDown,
                                                                  color: Colors
                                                                      .black,
                                                                  size: 16,
                                                                ),
                                                                elevation: 18,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                                underline:
                                                                Container(),
                                                                isExpanded:
                                                                true,
                                                                onChanged: (
                                                                    String?
                                                                    newValue) {
                                                                  setState(() {
                                                                    _language =
                                                                    newValue!;
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
                                                  ),
                                                  // ===
                                                  const SizedBox(width: 20),
                                                  // === DROPDOWNBUTTON Certificate ===
                                                  Expanded(
                                                    child: Container(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          const CustomText(
                                                            data: "Chứng chỉ",
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            fontSize: 16,
                                                            textAlign:
                                                            TextAlign.left,
                                                          ),
                                                          const SizedBox(
                                                              height: 5),
                                                          Focus(
                                                            onFocusChange:
                                                                (hasFocus) {
                                                              setState(() {
                                                                borderColor =
                                                                hasFocus
                                                                    ? const Color(
                                                                    0xFF4CAF4F)
                                                                    : Colors
                                                                    .black;
                                                              });
                                                            },
                                                            child: Container(
                                                              padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10,
                                                                  right:
                                                                  10),
                                                              width: double
                                                                  .infinity,
                                                              decoration:
                                                              BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                border: Border
                                                                    .all(
                                                                    color:
                                                                    borderColor,
                                                                    width: 1),
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10), // Bo góc viền
                                                              ),
                                                              child:
                                                              DropdownButton<
                                                                  String>(
                                                                hint: const CustomText(
                                                                    data:
                                                                    "-- Chứng chỉ --",
                                                                    fontSize:
                                                                    16,
                                                                    color: Colors
                                                                        .black),
                                                                value:
                                                                _certificate,
                                                                items: _language !=
                                                                    null
                                                                    ? languageCertificates[
                                                                _language]!
                                                                    .map((String
                                                                certificate) {
                                                                  return DropdownMenuItem<
                                                                      String>(
                                                                    value:
                                                                    certificate,
                                                                    child: CustomText(
                                                                        data: certificate,
                                                                        fontSize: 16,
                                                                        color: Colors
                                                                            .black),
                                                                  );
                                                                }).toList()
                                                                    : [],
                                                                icon:
                                                                const FaIcon(
                                                                  FontAwesomeIcons
                                                                      .chevronDown,
                                                                  color: Colors
                                                                      .black,
                                                                  size: 16,
                                                                ),
                                                                elevation: 18,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                                underline:
                                                                Container(),
                                                                isExpanded:
                                                                true,
                                                                onChanged: (
                                                                    String?
                                                                    newValue) {
                                                                  setState(() {
                                                                    _certificate =
                                                                        newValue;
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                            Container(
                                              width: 260,
                                              padding: const EdgeInsets.only(
                                                  top: 2, bottom: 2),
                                              child: ElevatedButton.icon(
                                                onPressed: () {
                                                  _pickImageCamera();
                                                },
                                                icon: const Icon(
                                                    Icons.camera_alt),
                                                label: const Text(
                                                    'Chụp ảnh xác thực'),
                                                style: ElevatedButton.styleFrom(
                                                  foregroundColor: Colors.blue,
                                                  backgroundColor:
                                                  Colors.blue[100],
                                                  shadowColor: Colors.black,
                                                  // Màu của bóng đổ
                                                  elevation: 8,
                                                ),
                                              ),
                                            ),
                                            // SizedBox(height: 8),
                                            Container(
                                              width: 260,
                                              padding: const EdgeInsets.only(
                                                  top: 2, bottom: 2),
                                              child: ElevatedButton.icon(
                                                onPressed: () {
                                                  _pickImage("certificate");
                                                },
                                                icon: const Icon(
                                                    Icons.upload_file),
                                                label: const Text(
                                                    'Upload ảnh từ thiết bị'),
                                                style: ElevatedButton.styleFrom(
                                                  foregroundColor:
                                                  Colors.orange,
                                                  backgroundColor:
                                                  Colors.orange[100],
                                                  shadowColor: Colors.black,
                                                  // Màu của bóng đổ
                                                  elevation: 8,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Container(
                                              width: 300,
                                              height: 200,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(20),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                BorderRadius.circular(20),
                                                child: Image(
                                                  image: _path_certificate !=
                                                      null &&
                                                      _path_certificate!
                                                          .isNotEmpty
                                                      ? FileImage(File(
                                                      _path_certificate!))
                                                      : const AssetImage(
                                                      'assets/images/default_image.png')
                                                  as ImageProvider,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 20, right: 20),
                                              child: const Divider(
                                                color: Colors.grey,
                                                // Đặt màu sắc cho thanh ngang
                                                thickness:
                                                1, // Đặt độ dày của thanh ngang
                                              ),
                                            ),
                                            Center(
                                              child: CustomText(
                                                data: _message,
                                                fontSize: 12,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            SizedBox(
                                              width: 260,
                                              child: ElevatedButton(
                                                onPressed: () {

                                                  String idLang = idLanguage[_language] as String;
                                                  print("Language: $_language");
                                                  print(
                                                      "Certificate: $_certificate");
                                                  print("idLanguage: $idLang ");
                                                  print(
                                                      "Image_Certificate: $_image_certificate \nPath_Certificate: $_path_certificate ");

                                                  if (_language == null ||
                                                      _certificate == null ||
                                                      _image_certificate ==
                                                          null) {
                                                    setState(() {
                                                      _message =
                                                      "Vui lòng chọn đủ dữ liệu trước khi cập nhật";
                                                    });
                                                  } else {
                                                    DataService service = new DataService("certificate");
                                                    Certificate certificate = new Certificate(imgCheck: _path_certificate!, idLanguage: idLang, idUser:_idUser, status: 2, level: _certificate!);
                                                    service.addData(certificate.toMap());
                                                    Navigator.of(context).pop();
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                      context) {
                                                        return AlertDialog(
                                                          content:
                                                          IntrinsicHeight(
                                                            child: Container(
                                                              width: 300,
                                                              color: const Color(
                                                                  0x0081c784),
                                                              child: Row(
                                                                children: [
                                                                  Image.asset(
                                                                      'assets/images/congratulations.png'),
                                                                  const SizedBox(
                                                                      width:
                                                                      10),
                                                                  Expanded(
                                                                    child:
                                                                    RichText(
                                                                      text:
                                                                      const TextSpan(
                                                                        text:
                                                                        "Cập nhật chứng chỉ thành công! Chúng tôi sẽ xem xét chứng chỉ và phản hồi cho bạn. ",
                                                                        style:
                                                                        TextStyle(
                                                                          color:
                                                                          Color(
                                                                              0xFF4CAF4F),
                                                                        ),
                                                                      ),
                                                                      softWrap:
                                                                      true,
                                                                      overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                                onPressed: () {
                                                                  _updateStatusField();
                                                                  Navigator.of(
                                                                      context)
                                                                      .pop();
                                                                },
                                                                child:
                                                                const CustomText(
                                                                  data: "OK",
                                                                  color: Color(
                                                                      0xFF4CAF4F),
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                )),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                    setState(() {
                                                      print(
                                                          "Updating statusField");
                                                      _message = "";
                                                      _statusField = 2;
                                                      print(
                                                          "statusField updated to $_statusField");
                                                    });
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                  const Color(0xFF4CAF4F),
                                                ),
                                                child: const CustomText(
                                                  data: "Cập nhật chứng chỉ",
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                ),
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
                          backgroundColor: _statusField == 1
                              ? Colors.green
                              : _statusField == 0
                              ? Colors.red
                              : Colors.yellow,
                          padding: const EdgeInsets.all(12),
                          // Additional padding
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(10), // Rounded corners
                          ),
                          shadowColor: Colors.black,
                          // Màu của bóng đổ
                          elevation: 8,
                        ),
                        child: const CustomText(
                          data: 'Cập nhật chứng chỉ',
                          fontSize: 15,
                          color: Colors.white,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ), // Cập nhật chứng chỉ
                    const SizedBox(height: 2),
                    SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                _statusField == 1
                                    ? "Đã cập nhật"
                                    : _statusField == 0
                                    ? "Chưa cập nhật"
                                    : "Đang chờ xử lí",
                                style: TextStyle(
                                  color: _statusField == 1
                                      ? Colors.green
                                      : _statusField == 0
                                      ? Colors.red
                                      : Colors.yellow,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Icon(
                                _statusField == 1
                                    ? Icons.check_circle
                                    : _statusField == 0
                                    ? Icons.cancel
                                    : Icons.hourglass_empty,
                                color: _statusField == 1
                                    ? Colors.green
                                    : _statusField == 0
                                    ? Colors.red
                                    : Colors.yellow,
                                size: 15,
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Flexible(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(
                          data: "Thành phố",
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
                              borderRadius:
                              BorderRadius.circular(10), // Bo góc viền
                            ),
                            child: DropdownButton<String>(
                              hint: const Text("-- Tỉnh/Thành phố --"),
                              value: selectedProvince,
                              items: city.entries
                                  .map((MapEntry<String, String> entry) {
                                return DropdownMenuItem<String>(
                                  value: entry.key,
                                  child: Text(entry.value),
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
                              onChanged: (String? idcity) {
                                setState(() {
                                  selectedProvince = idcity;
                                  selectedDistrict = null;
                                  fetchDistricts(selectedProvince!);
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              const SizedBox(width: 20),
              Flexible(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        data: "Huyện",
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 5),
                      Focus(
                        onFocusChange: (hasFocus) {
                          setState(() {
                            borderColor = hasFocus
                                ? const Color(0xFF4CAF4F)
                                : Colors.black;
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
                            borderRadius:
                            BorderRadius.circular(10), // Bo góc viền
                          ),
                          child: DropdownButton<String>(
                            hint: const Text("-- Huyện --"),
                            value: selectedDistrict,
                            items: district.entries
                                .map((MapEntry<String, String> entry) {
                              return DropdownMenuItem<String>(
                                value: entry.key,
                                child: Text(entry.value),
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
                            onChanged: (String? iddistricts) {
                              setState(() {
                                selectedDistrict = iddistricts!;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          CustomTextField(
              controller: _location,
              title: "Địa chỉ",
              hintText: "Nhập địa chỉ của bạn..."),
          const SizedBox(height: 10),
          DatePickerWidget(
            date: _dateTime,
            onDateChanged: _handleDatetime,
            title: "Ngày/tháng/năm sinh",
          ),
          const SizedBox(height: 10),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  data: "Tiểu sử",
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 5),
                CustomTextArea(
                  num_line: 5,
                  hint_text: "Nhập tiểu sử của bạn...",
                  controller: _description,
                ),
              ],
            ),
          ),
          // const SizedBox(height: 10),
          // CustomTextField(controller: _password, title: "Mật khẩu", hintText: "Nhập mật khẩu của bạn..."),
          const SizedBox(height: 10),
          Center(
            child: CustomText(
              data: _message_final,
              fontSize: 14,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              color: Colors.red,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity, // Chiếm hết chiều ngang
            child: ElevatedButton(
              onPressed: () {
                String date =
                    "${_dateTime.day}/${_dateTime.month}/${_dateTime.year}";


                if (_fullName.text.trim() == "" ||
                    _email.text.trim() == "" ||
                    phonenumber.trim() == "" ||
                    _location.text.trim() == "") {
                  setState(() {
                    _message_final = "Vui lòng cập nhật đầy đủ dữ liệu!";
                  });
                } else {
                  Users user = Users(
                    userId: _idUser,
                    accountId: FirebaseAuth.instance.currentUser!.uid,
                    fullName: _fullName.text,
                    email: _email.text,
                    address: _location.text,
                    phone: phonenumber,
                    biography: _description.text,
                    status: true,
                    roleId: "ANBYtDv7W1A1GrkfJ61S",
                    birthday: date,
                    imagePath: "image.png",
                    fieldId: '',
                    languageId: '',
                    credit: userInfo.credit,
                  );
                  profileService.updateData(_idUser!, user.toMap());
                  setState(() {
                    _message_final = "";
                    _showSuccessMessage(context);
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF4F),
                padding: const EdgeInsets.all(18),
                // Thêm padding
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Bo tròn góc
                ),
                shadowColor: Colors.black,
                // Màu của bóng đổ
                elevation: 8,
              ),
              child: const CustomText(
                data: 'Cập nhật hồ sơ',
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
