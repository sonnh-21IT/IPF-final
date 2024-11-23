import 'package:config/widgets/stateless/connected_dialog.dart';
import 'package:flutter/material.dart';

import '../../models/user.dart';

class TranslatorProfileDialog extends StatelessWidget {
  final Users users;
  final Function onConnect;
  final Function onFinish;

  const TranslatorProfileDialog(
      {super.key,
      required this.users,
      required this.onConnect,
      required this.onFinish});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/translator_photo.jpg'),
            ),
            const SizedBox(height: 16),
            Text(
              users.fullName,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            // const SizedBox(height: 8),
            // const Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Icon(Icons.star, color: Colors.yellow),
            //     Text('5.0 (122 reviews)'),
            //   ],
            // ),
            const SizedBox(height: 16),
            const Text(
              'Lý lịch',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              users.biography,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'Lĩnh vực',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      side: const BorderSide(color: Colors.green),
                      foregroundColor: Colors.green),
                  child: Text(users.field),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red, // Text color
                      side: const BorderSide(color: Colors.red), // Border color
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Bỏ qua'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: false,
                          builder: (context) => ConnectedDialog(
                            name: users.fullName,
                            onFinishJob: (){
                              onFinish();
                            },
                          ),
                        );
                        onConnect();
                      });
                    },
                    child: const Text('Kết nối ngay'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
