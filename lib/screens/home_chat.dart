import 'package:config/base/base_screen.dart';
import 'package:config/chat/chat_services.dart';
import 'package:config/screens/user_title.dart';
import 'package:config/utils/components/app_toolbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'chat_page.dart';

class HomeChat extends StatelessWidget {
  HomeChat({super.key});

  final ChatServices _chatServices = ChatServices();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final List<String> imageUrls = [
    'assets/images/avatar.jpg',
    'assets/images/avatar.jpg',
    'assets/images/img_interpreter.png',
    'assets/images/app_img/avatar.png',
    'assets/images/avatar.jpg',
    'assets/images/img_interpreter.png',
    'assets/images/app_img/avatar.png',
  ];
  int i = 0;

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        toolbar: const AppToolbar(title: "Danh sách tin nhắn của bạn"),
        body: _buildUsersList());
  }

  Widget _buildUsersList() {
    return StreamBuilder(
        stream: _chatServices.getUsersStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            // Error
            return const Text("Error");
          }

          // loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading...");
          }

          // return list view
          return Container(
            padding: const EdgeInsets.only(top: 10),
            child: SingleChildScrollView(
              child: ListView(
                shrinkWrap:
                    true, // Đặt shrinkWrap để ListView chỉ chiếm không gian cần thiết
                physics: const NeverScrollableScrollPhysics(),
                children: snapshot.data!
                    .map<Widget>(
                        (userData) => _buildUserListItem(userData, context))
                    .toList(),
              ),
            ),
          );
        });
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    // i++;
    if (_firebaseAuth.currentUser!.uid != userData["accountId"]) {
      return Usertile(
        text: userData["fullName"],
        imgavata: imageUrls[2],
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverEmail: userData["email"],
                receiverId: userData["accountId"],
                title: userData["fullName"],
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
