import 'dart:io';

import 'package:config/base/base_screen.dart';
import 'package:config/utils/components/app_toolbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailForum extends StatefulWidget {
  const DetailForum({super.key});

  @override
  State<DetailForum> createState() => _DetailForumState();
}

class _DetailForumState extends State<DetailForum> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        toolbar: AppToolbar(
          title: "Chi tiết bài viết",
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
        body: const ContentApp());
  }
}

class ContentApp extends StatefulWidget {
  const ContentApp({super.key});

  @override
  _StateContent createState() => _StateContent();
}

class _StateContent extends State<ContentApp> {
  File? _image_avata;
  String? _path_avata;
  final String _keyPath_avata = "img_avata";

  final String _fullname = "Trần Quang";
  final String _username = "@sonhong";
  final DateTime _date = DateTime.now();
  final String _content =
      "Phiên dịch viên là người kết nối ngôn ngữ, giúp cho những người nói các ngôn ngữ khác nhau có thể giao tiếp với nhau. Công việc của họ là chuyển đổi thông tin từ ngôn ngữ này sang ngôn ngữ khác một cách chính xác và nhanh chóng, có thể là phiên dịch nói hoặc phiên dịch văn bản.";

  void loadImage() async {
    SharedPreferences loadImg = await SharedPreferences.getInstance();
    setState(() {
      _path_avata = loadImg.getString("img_avata");
    });
  }

  final List<String> imageUrls = [
    'assets/images/avatar.jpg',
    'assets/images/img_interpreter.png',
    'assets/images/app_img/avatar.png',
    'assets/images/avatar.jpg',
    'assets/images/img_interpreter.png',
    'assets/images/app_img/avatar.png',
  ];

  final TextEditingController _commentController = TextEditingController();
  final List<String> _comments = [
    "Bài viết hay quá ạ!",
    "Tôi nghĩ phiên dịch viên là một công việc rất quan trọng.",
    "Thật sự là một công việc rất khó khăn.",
  ];

  void _addComment() {
    setState(() {
      if (_commentController.text.isNotEmpty) {
        _comments.insert(0, _commentController.text);
        _commentController.clear();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    loadImage();
  }

  int _likeCount = 0;
  int _shareCount = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 35,
                backgroundImage: _path_avata != null && _path_avata!.isNotEmpty
                    ? FileImage(File(_path_avata!))
                    : const AssetImage('assets/images/avata_default.png'),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_username,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(_date.toLocal().toString()),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            _content,
            style: const TextStyle(
              fontSize: 18.0,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _likeCount++;
                  });
                },
                child: Row(
                  children: [
                    const Icon(Icons.thumb_up),
                    const SizedBox(width: 5),
                    Text('$_likeCount'),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _shareCount++;
                  });
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Share'),
                        content: const Text('Chọn nguồn để chia sẻ:'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Facebook'),
                            onPressed: () {
                              // Xử lý chia sẻ lên Facebook
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text('Twitter'),
                            onPressed: () {
                              // Xử lý chia sẻ lên Twitter
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Row(
                  children: [
                    const Icon(Icons.share),
                    const SizedBox(width: 5),
                    Text('$_shareCount'),
                  ],
                ),
              ),
              const Text('Bài viết hay (21)'),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(),
          const SizedBox(height: 5),
          const Text('Bình luận (21)'),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: const InputDecoration(
                      labelText: 'Nhập bình luận...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _addComment,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _comments.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              AssetImage(imageUrls[index]) as ImageProvider,
                          child: Container()),
                      title: Text(_comments[index]),
                      trailing: IconButton(
                        icon: Icon(Icons.thumb_up),
                        onPressed: () {
                          // Thêm chức năng like của bạn ở đây
                        },
                      ),
                    ),
                    Divider(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
