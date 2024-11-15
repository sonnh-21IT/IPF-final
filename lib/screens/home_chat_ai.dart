
import 'dart:convert';

import 'package:config/utils/components/component.dart';
import 'package:config/utils/themes/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:http/http.dart' as http;
import '../base/base_screen.dart';
import '../models/message.dart';
import '../utils/components/app_toolbar.dart';

String _apiKey = "AIzaSyBON_Zzse4KVRGFCKOrz1oyLHdyDaOaoN4";

class HomeChatAI extends StatelessWidget {
  const HomeChatAI({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      resize: true,
      toolbar: AppToolbar(title: "Trò chuyện với AI"),
      body: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final GenerativeModel _generativeModel;
  late final ChatSession _chatSession;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();
  final List<ChatMessage> _message = [
    ChatMessage("Hi, Bạn cần hỗ trợ điều gì?", false)
  ];
  String valueQuestion = "";
  String feedBackAI =
      " Chào mừng bạn đến với ứng dụng hỗ trợ và tìm kiếm phiên dịch viên của chúng tôi, ở đây chúng tôi sẽ cung cấp và hỗ trợ cho bạn các dịch vụ với ưu điểm như:"

      "\n 1. Giúp giảm thiểu chi phí và thời gian tìm kiếm thông dịch viên, đồng thời tăng tính minh bạch và cạnh tranh của thị trường. "
      "\n 2. Giúp các doanh nghiệp và tổ chức Việt Nam dễ dàng tiếp cận thị trường quốc tế và ngược lại. "
      "\n 3. Thúc đẩy việc ứng dụng công nghệ thông tin trong các lĩnh vực dịch vụ."
      "\n 4. Mang đến một giải pháp hoàn toàn mới cho thị trường dịch thuật."
      "\n 5. Giúp kết nối thông dịch viên với khách hàng một cách nhanh chóng và hiệu quả trên nhiều thiết bị khác nhau (điện thoại, máy tính bảng, máy tính)"
      "\n 6. Giúp khách hàng tìm kiếm được thông dịch viên phù hợp với yêu cầu về ngôn ngữ, lĩnh vực chuyên môn và mức giá."
      "\n 7. Giúp các doanh nghiệp và tổ chức Việt Nam dễ dàng tiếp cận thị trường quốc tế và ngược lại. ";

  @override
  void initState() {
    super.initState();
    _generativeModel =
        GenerativeModel(model: "gemini-1.5-flash", apiKey: _apiKey);
    _chatSession = _generativeModel.startChat();
  }

  // to controll and manage screen auto scrolling when getting response
  void _scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 750), curve: Curves.easeOutCirc));
  }

  Future<void> _sendChatMessage(String message) async {
    setState(() {
      _message.add(ChatMessage(message, true));
      valueQuestion = message;
      _textEditingController.clear();
    });

    if (valueQuestion.contains("uu diem")) {
      _message.add(ChatMessage(feedBackAI, false));
    } else {
      try {
        final response = await _chatSession.sendMessage(Content.text(message));
        final text = response.text;
        setState(() {
          _message.add(ChatMessage(text!, false));
          _scrollDown();
        });
      } catch (e) {
        setState(() {
          _message.add(ChatMessage("Error occured", false));
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.only(top: 20, bottom: 10, left: 8, right: 8),
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  controller: _scrollController,
                  itemCount: _message.length,
                  itemBuilder: (Content, index) {
                    return ChatBubble(message: _message[index]);
                  }),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: 12, bottom: 16, left: 20, right: 20),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white, // Color
                  borderRadius: BorderRadius.circular(20), // Border Radius
                  border: Border.all(
                    color: AppColors.primaryColor,
                    width: 1,
                  ), // Boder
                ),
                child: Row(
                  children: [
                    Flexible(
                        child: TextField(
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Nhập nội dung tin nhắn...",
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    )),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.gif_box),
                      color: AppColors.primaryColor,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(FontAwesomeIcons.fileArrowUp),
                      color: AppColors.primaryColor,
                    ),
                    IconButton(
                      onPressed: () =>
                          _sendChatMessage(_textEditingController.text),
                      icon: Icon(Icons.send),
                      color: AppColors.primaryColor,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width / 1.25,
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        decoration: BoxDecoration(
          color: message.isUser ? Colors.grey[300] : AppColors.secondaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: CustomText(
          data: message.text,
          fontSize: 16,
        ),
      ),
    );
  }
}
