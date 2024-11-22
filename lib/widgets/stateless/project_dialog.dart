import 'package:config/models/book_item.dart';
import 'package:config/models/field.dart';
import 'package:config/models/language.dart';
import 'package:config/services/field_service.dart';
import 'package:config/services/language_service.dart';
import 'package:flutter/material.dart';

class ProjectDialog extends StatefulWidget {
  final BookItem bookItem;
  final Function onCancel;
  final Function onConfirm;
  final Language lang;
  final Field field;

  const ProjectDialog(
      {super.key,
      required this.bookItem,
      required this.onConfirm,
      required this.onCancel,
      required this.lang,
      required this.field});

  @override
  State<ProjectDialog> createState() => _ProjectDialogState();
}

class _ProjectDialogState extends State<ProjectDialog> {
  late BookItem _bookItem;
  late Language _language;
  late Field _field;

  @override
  void initState() {
    super.initState();
    _bookItem = widget.bookItem;
    _language = widget.lang;
    _field = widget.field;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Thông tin chi tiết',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text("Thanh toán: ${_language.language}"),
              const SizedBox(height: 10),
              Text("Thanh toán: ${_bookItem.isPrepay ? 'Trước' : 'Sau'}"),
              const SizedBox(height: 10),
              Text("Lý do: ${_field.field}"),
              const SizedBox(height: 10),
              Text("Ngân sách(VND): ${_bookItem.salary}"),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red, // Text color
                          side: const BorderSide(
                              color: Colors.red), // Border color
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          widget.onCancel(_bookItem);
                        },
                        child: const Text('Hủy'),
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
                          widget.onConfirm(_bookItem);
                        },
                        child: const Text('Chấp nhận'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
