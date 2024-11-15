import 'package:config/models/book_item.dart';
import 'package:flutter/material.dart';

class ProjectDialog extends StatelessWidget {
  final BookItem bookItem;
  final Function onCancel;
  final Function onConfirm;

  const ProjectDialog(
      {super.key,
      required this.bookItem,
      required this.onConfirm,
      required this.onCancel});

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
              _buildDropdown(
                title: 'Ngôn ngữ:',
                value: bookItem.language,
                items: ['Hàn Quốc', 'Anh', 'Pháp'],
                onChanged: (newValue) {},
              ),
              const SizedBox(height: 10),
              _buildDropdown(
                title: 'Thanh toán:',
                value: bookItem.isPrepay ? 'Trước' : 'Sau',
                items: ['Trước', 'Sau'],
                onChanged: (newValue) {},
              ),
              const SizedBox(height: 10),
              _buildDropdown(
                title: 'Lý do:',
                value: bookItem.field,
                items: ['Y tế', 'Pháp Lý'],
                onChanged: (newValue) {},
              ),
              const SizedBox(height: 10),
              Text("Ngân sách(VND): ${bookItem.salary}"),
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
                          onCancel(bookItem);
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
                          onConfirm(bookItem);
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

  Widget _buildDropdown({
    required String title,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        Container(
          width: double.infinity,
          child: InputDecorator(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: value,
                items: items.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String title,
    required String hintText,
    required TextEditingController controller,
    required ValueChanged<String> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        TextField(
          decoration: InputDecoration(
            hintText: hintText,
            border: const OutlineInputBorder(),
          ),
          onChanged: onChanged,
          controller: controller,
        ),
      ],
    );
  }
}
