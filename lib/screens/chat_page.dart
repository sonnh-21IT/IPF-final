import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:config/base/base_screen.dart';
import 'package:config/chat/chat_services.dart';
import 'package:config/services/auth_service.dart';
import 'package:config/utils/components/app_toolbar.dart';
import 'package:config/utils/components/component.dart';
import 'package:config/utils/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverId;
  final String title;

  ChatPage({super.key, required this.receiverEmail, required this.receiverId, required this.title});

  // text controller
  final TextEditingController _messageController = TextEditingController();

  // chat & auth services
  final ChatServices _chatServices = ChatServices();
  final AuthService _authService = AuthService();

  // send message

  void sendMessage() async {
    // if there is something inside the textfield
    if (_messageController.text.isNotEmpty) {
      // send Message
      await _chatServices.sendMessage(receiverId, _messageController.text);

      // clear text
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      resize: true,
      toolbar: AppToolbar(title: title),
      body: Column(
        children: [
          // display all messae
          Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 20),
                child: _buildMessageList(),
              )),

          // user input
          _buildUserInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderId = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: _chatServices.getMessage(receiverId, senderId),
        builder: (context, snapshot) {
          // error
          if (snapshot.hasError) {
            return const Text("Error");
          }
          // loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading...");
          }

          return ListView(
            children: snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
          );
        });
  }

  // build message item
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // is current user
    bool isCurrentUser = data["senderId"] == _authService.getCurrentUser()!.uid;

    // align message to the right if sender is the current user, otherwise left
    var aligment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
        alignment: aligment,
        child: Column(
          crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              margin: isCurrentUser ? const EdgeInsets.only(right: 6) : const EdgeInsets.only(left: 6) ,
              width: 300,
              alignment:  isCurrentUser ? Alignment.centerRight :  Alignment.centerLeft,
              padding: const EdgeInsets.only(bottom: 4) ,
              child:Container(
                padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isCurrentUser ? AppColors.surfaceColor : AppColors.primaryColor,  // Color
                    borderRadius: BorderRadius.circular(10), // Border Radius// Boder// Vị trí bóng đổ (x, y)
                  ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomText(data: data["message"],
                        textAlign: isCurrentUser ?  TextAlign.right : TextAlign.left ,
                       color: isCurrentUser ? Colors.black : Colors.white)
                  ],
              ),
              ),
            ),
          ],
        ));
  }

  // build message input
  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, left: 20, right: 20),
      child: Container(
        padding: const EdgeInsets.all(10),
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
            Expanded(
                child: TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Nhập nội dung tin nhắn...",
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
              ),
            )),
            IconButton(onPressed: sendMessage, icon: const Icon(Icons.gif_box),color: AppColors.primaryColor,),
            IconButton(onPressed: sendMessage, icon: const Icon(FontAwesomeIcons.fileArrowUp),color: AppColors.primaryColor,),
            IconButton(onPressed: sendMessage, icon: const Icon(Icons.send),color: AppColors.primaryColor,),
          ],
        ),
      ),
    );
  }
}
