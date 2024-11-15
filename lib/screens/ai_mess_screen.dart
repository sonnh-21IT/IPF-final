import 'package:config/base/base_screen.dart';
import 'package:flutter/material.dart';

class AiMessPage extends StatelessWidget {
  const AiMessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: Column(
        children: [
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  print('Bạn đang ở Screen Tin nhắn');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(76, 175, 79, 20),

                  minimumSize: const Size(150, 44), // Màu nền xanh
                ),
                child: const Row(
                  children: [
                    Icon(Icons.messenger_outline_outlined, color: Colors.white),
                    SizedBox(width: 8),
                    Text('Tin nhắn', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(129, 199, 132, 20),
                  minimumSize: const Size(150, 44), // Màu nền xanh
                ),
                child: const Row(
                  children: [
                    Icon(Icons.notifications_outlined,
                        color: Colors.white), // Thay thế với icon mong muốn
                    SizedBox(width: 8), // Khoảng cách giữa icon và text
                    Text('Thông báo', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 120),
          Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/app_img/AI_1.png'),
                      // SizeBox
                      const SizedBox(
                        height: 45,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                50.0), // Tạo khoảng cách 20 đơn vị về 2 bên
                        child: Text(
                          'Xin chào Rất vui được gặp bạn ở đây! Bằng cách nhấn nút "Bắt đầu trò chuyện", bạn đồng ý xử lý dữ liệu cá nhân của mình như được mô tả trong Chính sách quyền riêng tư của chúng tôi',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromRGBO(102, 112, 133, 20),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 45,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          print('Button đã được nhấn!');
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (BuildContext context) =>
                          //             const AI_Messenger()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(35, 125, 49, 20),
                          maximumSize: const Size(340, 70),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Bắt đầu trò chuyện',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white, // Màu chữ
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            SizedBox(height: 0),
                          ],
                        ),
                      )
                    ]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
