import 'dart:math';

import 'package:config/base/base_screen.dart';
import 'package:config/screens/home_chat_ai.dart';
import 'package:config/utils/themes/app_colors.dart';
import 'package:flutter/material.dart';

import '../home_chat.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool showNotification = true;
  bool showMessages = false;

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: Column(
        children: [
          const SizedBox(height: 12),
          // Phần nút
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    showMessages = true;
                    showNotification = false;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: showMessages
                      ? AppColors.primaryColor
                      : const Color.fromRGBO(129, 199, 132, 20),
                  minimumSize: const Size(150, 44),
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
                  setState(() {
                    showNotification = true;
                    showMessages = false;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: showNotification
                      ? AppColors.primaryColor
                      : const Color.fromRGBO(129, 199, 132, 20),
                  minimumSize: const Size(150, 44),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.notifications_outlined, color: Colors.white),
                    SizedBox(width: 8),
                    Text('Thông báo', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Phần nội dung
          Expanded(
            child: showNotification
                ? const AiMessPage()
                : const NotificationListPage(),
          ),
        ],
      ),
    );
  }
}

class AiMessPage extends StatelessWidget {
  const AiMessPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Danh sách các đoạn văn bản
    final List<String> messages = [
      '🙋Chào mừng bạn đến với IPF',
      '🙌 Hãy tham gia ngay các hoạt động hấp dẫn của chúng tôi.',
      '✌️ Chúc mừng bạn đã đăng ký tài khoản thành công!',
      '🎶 Hãy cùng nhau tạo nên những kỷ niệm đáng nhớ.'
    ];
    final List<String> messages_nav = [
      ' Dịch thuật chính xác và chuyên nghiệp chưa bao giờ dễ dàng đến thế. Hãy bắt đầu tìm kiếm ngay bây giờ.❤️',
      'Tài khoản của bạn đã được tạo thành công. Bắt đầu tìm kiếm phiên dịch viên phù hợp ngay thôi! ️🎉',
      'Việc tìm kiếm phiên dịch viên chưa bao giờ dễ dàng đến thế! Tài khoản của bạn đã được kích hoạt.💕',
      'Bạn có một thông báo mới từ IPF .😍'
    ];

    // Lấy đoạn văn bản ngẫu nhiên
    final String randomMessage = messages[Random().nextInt(messages.length)];

    final String randomMessage_nav =
        messages_nav[Random().nextInt(messages_nav.length)];

    // Lấy ngày hiện tại
    final String currentDate =
        DateTime.now().toLocal().toString().split(' ')[0];

    return Expanded(
      child: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side:
                  const BorderSide(color: Colors.green), // Thêm border màu xanh
            ),
            elevation: 2,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    randomMessage,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    randomMessage_nav,
                    style: TextStyle(color: Colors.grey),
                  ), // Nội dung phụ
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  const SizedBox(height: 8),
                  Text('Ngày: $currentDate'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class NotificationListPage extends StatelessWidget {
  const NotificationListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset('assets/images/app_img/AI_1.png'),
        // SizeBox
        const SizedBox(
          height: 45,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 50.0), // Tạo khoảng cách 20 đơn vị về 2 bên
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
        Container(
          child: Column(
            children: [
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    print('Button đã được nhấn!');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const HomeChatAI()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(35, 125, 49, 20),
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
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    print('Button đã được nhấn!');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => HomeChat()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.surfaceColor,
                    maximumSize: const Size(340, 70),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Tin nhắn của tôi',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black, // Màu chữ
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(height: 0),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}
