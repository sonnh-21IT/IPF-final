import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:config/base/base_screen.dart';
import 'package:config/models/user.dart';
import 'package:config/screens/app_screen.dart';
import 'package:config/services/auth_service.dart';
import 'package:config/services/role_service.dart';
import 'package:config/utils/components/component.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:config/models/role.dart';
import 'package:config/utils/themes/app_colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  String _errorMessage = '';
  String error = '';

  void _validateEmail() {
    String email = _emailController.text;
    setState(() {
      if (email.contains('@gmail.com')) {
        _errorMessage = '';
        _onRegisterButtonPressed();
      } else {
        _errorMessage = 'Email không hợp lệ. Vui lòng nhập lại.';
      }
    });
  }

  void _onRegisterButtonPressed() async {
    String name = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String passwordConfirm = _passwordConfirmController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      _showErrorDialog('Vui lòng điền đầy đủ thông tin.');
      return;
    }
    if (password != passwordConfirm) {
      _showErrorDialog('Mật khẩu và xác nhận mật khẩu không khớp.');
      return;
    }
    print(
        'Name: $name, Email: $email, Password: $password, Password Confirm: $passwordConfirm');
    try {
      bool isSuccess = await AuthService.createUser(email, password);
      Navigator.pop(context);
      if (isSuccess) {
        Role? roles = await RoleService.getRoleByValue('Khách hàng');
        String uid = FirebaseAuth.instance.currentUser!.uid;
        CollectionReference users =
            FirebaseFirestore.instance.collection('user');
        Users user = Users(
            accountId: uid,
            fullName: _nameController.text,
            email: _emailController.text,
            address: '',
            phone: '',
            biography: '',
            status: false,
            roleId: roles!.roleId,
            fieldId: '',
            languageId: '',
            imagePath: '',
            birthday: '');
        await users.add(user.toMap());

        print('Đăng kí và add thông tin người dùng thành công');
      } else {
        print('Đăng kí không thành công');
      }
      return;
    } catch (e) {
      print('Đăng kí ko đc: $e');
      setState(() {
        _errorMessage = 'Đăng kí người dùng ko đc: $e';
      });
    }
    setState(() {
      error = 'Đã có lỗi xảy ra. vui lòng thử lại sau';
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Lỗi'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: SingleChildScrollView(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: 370,
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset('assets/images/app_img/img_top_register.png'),

                    const SizedBox(height: 8), // Spacing between text
                    const Text(
                      'Đăng ký tài khoản',
                      style: TextStyle(
                        fontSize: 20,
                        //fontFamily: Inter,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Hãy tạo tài khoản và gia nhập nhanh vào cộng đồng chúng tôi',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 52.0,
                      width: 308.0,
                      child: TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Họ và tên',
                          suffixIcon: const Icon(Icons.person_2_outlined),
                          filled: true,
                          fillColor: Colors.grey[200],
                          // Màu xám nhạt
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.green),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 52.0,
                      width: 308.0,
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Nhập địa chỉ Email',
                          suffixIcon: const Icon(Icons.email_outlined),
                          filled: true,
                          fillColor: Colors.grey[200],
                          // Màu xám nhạt
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.green),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    if (_errorMessage.isNotEmpty)
                      Text(
                        _errorMessage,
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 52.0,
                      width: 308.0,
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Mật khẩu',
                          suffixIcon: const Icon(Icons.lock_outlined),
                          filled: true,
                          fillColor: Colors.grey[200],
                          // Màu xám nhạt
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.green),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 52.0,
                      width: 308.0,
                      child: TextField(
                        controller: _passwordConfirmController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Nhập lại mật khẩu',
                          suffixIcon: const Icon(Icons.lock_outlined),
                          filled: true,
                          fillColor: Colors.grey[200],
                          // Màu xám nhạt
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.green),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),
                    CustomText(
                      data: error,
                      color: Colors.red,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 35),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            print('U was prested Login Button');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const AppScreen(
                                          currentIndex: 4,
                                        )));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            minimumSize: const Size(130, 44),
                            side: const BorderSide(
                              color: Colors.green,
                              width: 1.5,
                            ),
                          ),
                          child: const Text('Đăng nhập',
                              style: TextStyle(color: Colors.green)),
                        ),
                        const SizedBox(width: 20), // Khoảng cách giữa hai nút
                        ElevatedButton(
                          onPressed: () {
                            _validateEmail();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(76, 175, 79, 20),
                            minimumSize: const Size(130, 44), // Màu nền xanh
                          ),
                          child: const Text('Đăng ký',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Hoặc đăng nhập bằng',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Xử lý khi người dùng nhấn vào nút Facebook
                            print('Đăng nhập bằng Facebook');
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            // Tạo hình tròn cho nút
                            backgroundColor: Colors.white,
                            minimumSize: const Size(39, 39),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/social/facebook.png',
                              height: 39,
                              width: 39,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Xử lý khi người dùng nhấn vào nút Facebook
                            print('Đăng nhập bằng Ig');
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            // Tạo hình tròn cho nút
                            backgroundColor: Colors.white,
                            minimumSize: const Size(39, 39),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/social/instagram.png',
                              height: 39,
                              width: 39,
                              fit: BoxFit
                                  .cover, // Đảm bảo ảnh lấp đầy toàn bộ hình tròn
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Xử lý khi người dùng nhấn vào nút Facebook
                            print('Đăng nhập bằng P');
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            // Tạo hình tròn cho nút
                            backgroundColor: Colors.white,
                            minimumSize: const Size(39, 39),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/social/pinterest.png',
                              height: 39,
                              width: 39,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
