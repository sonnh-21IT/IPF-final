import 'package:config/base/base_screen.dart';
import 'package:config/utils/components/app_toolbar.dart';
import 'package:config/utils/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:config/services/data_service.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  // Removed duplicate build method

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      toolbar: AppToolbar(
        title: "Đánh giá phiên dịch viên",
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: const SingleChildScrollView(
          child: ContentApp(),
        ),
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
  int _selectedRating = 0;
  final TextEditingController _feedbackSpace = TextEditingController();
  DataService feedbackService = DataService('feedback');

  void _submitFeedback() {
    if (areFieldsEmpty()) {
      return;
    }
    var feedback = {
      'feedbackId': '',
      'content': _feedbackSpace.text,
      'rated': _selectedRating,
      'userId': '',
      'projectId': '',
      'userIdTake': '',
    };

    //feedbackService.addData(feedback.toMap());
  }

  bool areFieldsEmpty() {
    return _selectedRating == 0 || _feedbackSpace.text.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          const Text(
            'Rate the service',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 20),
          Image.asset(
            'assets/images/feedback.png',
            height: 200,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return IconButton(
                icon: Icon(
                  index < _selectedRating ? Icons.star : Icons.star_border,
                  size: 40,
                ),
                onPressed: () {
                  setState(() {
                    _selectedRating = index + 1;
                  });
                },
              );
            }),
          ),
          const SizedBox(height: 20),
          const Text(
            'LỜI ĐÁNH GIÁ CỦA BẠN VỀ PHIÊN DỊCH VIÊN',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _feedbackSpace,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Nhập đánh giá của bạn',
            ),
            maxLines: 5,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submitFeedback,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              // Đổi màu nền
              foregroundColor: Colors.white, // Đổi màu chữ thành màu trắng
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              // Thêm padding
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Giảm độ bo góc
              ),
              shadowColor: Colors.black,
              // Màu của bóng đổ
              elevation: 8,
            ),
            child: const Text('Gửi đánh giá'),
          ),
        ],
      ),
    );
  }
}
