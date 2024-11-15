import 'package:flutter/material.dart';

class ConnectedDialog extends StatelessWidget {
  final String name;
  final Function onFinishJob;

  const ConnectedDialog(
      {super.key, required this.name, required this.onFinishJob});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white, // Set background color
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      child: IntrinsicHeight(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Phiên dịch viên sẽ tới trong 10 phút',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            // const SizedBox(height: 8),
            // const Text('Tới nơi của Trần Quang'),
            const SizedBox(height: 16),
            const LinearProgressIndicator(
              value: 1,
              color: Colors.green,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    // Đặt màu và độ dày của viền
                    borderRadius:
                        BorderRadius.circular(8.0), // Đặt bán kính bo tròn
                  ),
                  padding: const EdgeInsets.all(16),
                  child: const Icon(
                    Icons.motorcycle,
                    color: Colors.black, // Đặt màu của biểu tượng nếu cần
                  ),
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Phiên dịch viên đang tới\nPhiên dịch viên hiện đang trên đường tới để làm việc. Bạn vui lòng đợi ít phút!',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // Ensure Row expands
              children: [
                const CircleAvatar(
                  backgroundImage:
                      NetworkImage('https://via.placeholder.com/150'),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: TextStyle(fontSize: 16)),
                    const Text('Phiên dịch viên',
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),
                const SizedBox(width: 4), // Thêm khoảng cách
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    // Đặt màu và độ dày của viền
                    borderRadius:
                        BorderRadius.circular(8.0), // Đặt bán kính bo tròn
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.phone_forwarded_rounded),
                    color: Colors.black, // Đặt màu của biểu tượng nếu cần
                    onPressed: (){},
                  ),
                ),
                const SizedBox(width: 4), // Thêm khoảng cách
                ElevatedButton(
                  onPressed: (){
                    onFinishJob();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text(
                    'Hoàn Thành',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
