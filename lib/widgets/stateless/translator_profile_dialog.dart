import 'package:config/services/field_service.dart';
import 'package:config/widgets/stateless/connected_dialog.dart';
import 'package:flutter/material.dart';

import 'package:config/models/user.dart';

import 'package:config/models/field.dart';

class TranslatorProfileDialog extends StatefulWidget {
  final Users users;
  final Function onConnect;
  final Function onFinish;
  final Function onBreak;

  const TranslatorProfileDialog(
      {super.key,
      required this.users,
      required this.onConnect,
      required this.onFinish,
      required this.onBreak});

  @override
  State<TranslatorProfileDialog> createState() =>
      _TranslatorProfileDialogState();
}

class _TranslatorProfileDialogState extends State<TranslatorProfileDialog> {
  late Users _user;
  late Field _field = Field(field: '');

  @override
  void initState() {
    super.initState();
    _user = widget.users;
    _initData();
  }

  Future<void> _initData() async {
    Field field = (await FieldService.readField(_user.fieldId))!;
    setState(() {
      _field = field;
    });
  }

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
              _user.fullName,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Lý lịch',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              _user.biography,
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
                  child: Text(_field.field),
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
                      widget.onBreak();
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
                            name: _user.fullName,
                            onFinishJob: () {
                              widget.onFinish();
                            },
                          ),
                        );
                        widget.onConnect();
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
