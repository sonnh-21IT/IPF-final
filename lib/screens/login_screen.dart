import 'package:config/base/base_screen.dart';
import 'package:config/screens/app_screen.dart';
import 'package:config/screens/register_screen.dart';
import 'package:config/services/auth_service.dart';
import 'package:config/utils/components/component.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final int currentIndex;

  const LoginScreen({super.key, required this.currentIndex});

  @override
  State<LoginScreen> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';
  String error = '';
  int _currentIndex = 0;

  bool _rememberMe = false;

  void _validateEmail() {
    String email = _emailController.text;
    setState(() {
      if (email.contains('@gmail.com')) {
        _errorMessage = '';
        _handleLogin();
      } else {
        _errorMessage = 'Email không hợp lệ. Vui lòng nhập lại.';
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
  }

  Future<void> _handleLogin() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    bool rememberMe = _rememberMe;
    // Xử lý logic đăng nhập ở đây
    print('Email: $email');
    print('Mật khẩu: $password');
    bool isSuccess = await AuthService.signIn(email, password);
    if (isSuccess) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (content) => const AppScreen(
                currentIndex: 0
              )));
      return;
    }
    setState(() {
      error = 'Tài khoản không tồn tại hoặc Mật khẩu không chính xác';
    });
  }

  void _handleForgotPassword() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController forgotPasswordController =
            TextEditingController();
        return AlertDialog(
          title: const Text('Quên mật khẩu'),
          content: TextField(
            controller: forgotPasswordController,
            decoration: const InputDecoration(
              labelText: 'Nhập email của bạn',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Gửi'),
              onPressed: () {
                String email = forgotPasswordController.text;
                // Thực hiện logic gửi email đặt lại mật khẩu ở đây
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
        child: Container(
          padding: const EdgeInsets.all(10.0),
          // decoration: const BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage('assets/images/app_img/background_login.png'),
          //     fit: BoxFit.cover,
          //   ),
          // ),
          child: Stack(
            children: [
              // Rectangle 1
              SizedBox(
                width: 420,
                height: 780,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(22.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/app_img/img_top_login.png'),
                        const SizedBox(height: 14.0),
                        // Add some space between the image and the text
                        const Text(
                          'Chào mừng bạn đến với IPF',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        //Text Chào mừng bạn đến với IPF + Description
                        Container(
                          alignment: Alignment.center,
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: const TextSpan(
                              text: 'Cộng đồng phiên dịch viên ',
                              style: TextStyle(
                                color: Color.fromRGBO(107, 94, 94, 20),
                                fontSize: 20,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'chất lượng ',
                                  style: TextStyle(
                                      color: Color.fromRGBO(76, 175, 79, 20),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: 'và ',
                                  style: TextStyle(
                                    color: Color.fromRGBO(107, 94, 94, 20),
                                    fontSize: 20,
                                  ),
                                ),
                                TextSpan(
                                  text: 'uy tín',
                                  style: TextStyle(
                                      color: Color.fromRGBO(76, 175, 79, 20),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: ' số 1 tại Việt Nam',
                                  style: TextStyle(
                                    color: Color.fromRGBO(107, 94, 94, 20),
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Input Email
                        SizedBox(
                          height: 44.0,
                          child: TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Nhập địa chỉ Email',
                              suffixIcon: const Icon(Icons.email_outlined),
                              filled: true,
                              fillColor: Colors.grey[200],
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.green),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 2),
                        if (_errorMessage.isNotEmpty)
                          Text(
                            _errorMessage,
                            style: const TextStyle(
                                color: Colors.red, fontSize: 12),
                          ),

                        const SizedBox(height: 15),
                        SizedBox(
                          height: 44.0,
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
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.green),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        CustomText(
                          data: error,
                          color: Colors.red,
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 5),
                        //Ghi nho mat khau
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 200,
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: _rememberMe,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _rememberMe = value!;
                                      });
                                    },
                                  ),
                                  const Text(
                                    'Ghi nhớ mật khẩu',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        //Quen mat khau
                        Padding(
                          padding: const EdgeInsets.only(top: 0.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: _handleForgotPassword,
                              child: const Text(
                                'Quên mật khẩu',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Button Login and Register
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                _validateEmail();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(76, 175, 79, 20),
                                minimumSize: const Size(130, 44),
                                side: const BorderSide(
                                  color: Colors.green,
                                  width: 1.5,
                                ),
                              ),
                              child: const Text('Đăng nhập',
                                  style: TextStyle(color: Colors.white)),
                            ),
                            const SizedBox(width: 30),
                            ElevatedButton(
                              onPressed: () {
                                print('Đăng ký');

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const RegisterScreen()));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                minimumSize: const Size(130, 44),
                                side: const BorderSide(
                                  color: Colors.green,
                                  width: 1.5,
                                ),
                              ),
                              child: const Text('Đăng ký',
                                  style: TextStyle(
                                    color: Color.fromRGBO(76, 175, 79, 20),
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Hoặc đăng nhập bằng',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 20),
                        //Icon Social Media
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Xử lý khi người dùng nhấn vào nút Facebook
                                print('Đăng nhập bằng Facebook');
                              },
                              style: ElevatedButton.styleFrom(
                                shape:
                                    const CircleBorder(), // Tạo hình tròn cho nút
                                backgroundColor: Colors.white,
                                minimumSize: const Size(39, 39),
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/images/social/facebook.png',
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
                                print('Đăng nhập bằng Ig');
                              },
                              style: ElevatedButton.styleFrom(
                                shape:
                                    const CircleBorder(), // Tạo hình tròn cho nút
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
                                shape:
                                    const CircleBorder(), // Tạo hình tròn cho nút
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
            ],
          ),
        ),
      ),
    );
  }
}
