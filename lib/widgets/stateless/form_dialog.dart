import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:config/models/book_item.dart';
import 'package:config/models/field.dart';
import 'package:config/models/language.dart';
import 'package:config/services/field_service.dart';
import 'package:config/services/language_service.dart';
import 'package:flutter/material.dart';

class FormDialog extends StatefulWidget {
  final Function(BookItem) onDone;

  const FormDialog({
    Key? key,
    required this.onDone,
  }) : super(key: key);

  @override
  State<FormDialog> createState() => _FormDialogState();
}

class _FormDialogState extends State<FormDialog> {
  List<Field> _listField = [];
  List<Language> _listLanguage = [];
  late Language _selectedLanguage = Language(language: '');
  bool _selectedRepay = false;
  late Field _selectedField = Field(field: '');
  double _budget = 0.0;
  late TextEditingController _budgetController;

  @override
  void initState() {
    super.initState();
    _budgetController = TextEditingController(text: _budget.toString());
    _initData();
  }

  Future<void> _initData() async {
    List<Field> fields = await FieldService.fetchFields();
    List<Language> languages = await LanguageService.fetchLanguages();
    setState(() {
      _listField = fields;
      _listLanguage = languages;
      _selectedField = fields.first;
      _selectedLanguage = languages.first;
    });
  }

  @override
  void dispose() {
    _budgetController.dispose();
    super.dispose();
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
              _buildDropdown(
                title: 'Ngôn ngữ:',
                value: _selectedLanguage.language,
                items: _listLanguage.map((lang) => lang.language).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedLanguage = _listLanguage
                        .firstWhere((lang) => lang.language == newValue);
                  });
                },
              ),
              const SizedBox(height: 10),
              _buildDropdown(
                title: 'Thanh toán:',
                value: _selectedRepay ? 'Trước' : 'Sau',
                items: ['Trước', 'Sau'],
                onChanged: (newValue) {
                  setState(() {
                    _selectedRepay = newValue == 'Trước';
                  });
                },
              ),
              const SizedBox(height: 10),
              _buildDropdown(
                title: 'Lý do:',
                value: _selectedField.field,
                items: _listField.map((field) => field.field).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedField = _listField
                        .firstWhere((field) => field.field == newValue);
                  });
                },
              ),
              const SizedBox(height: 10),
              _buildTextField(
                title: 'Ngân sách(VND):',
                hintText: 'Nhập Ngân Sách',
                controller: _budgetController,
                onChanged: (value) {
                  setState(() {
                    _budget = double.tryParse(value) ?? 0;
                  });
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    widget.onDone(
                      BookItem(
                        fieldId: _selectedField.fieldId!,
                        languageId: _selectedLanguage.languageId!,
                        salary: _budget,
                        status: 0,
                        isPrepay: _selectedRepay,
                        timestamp: Timestamp.now(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Xác nhận tìm kiếm',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(24),
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
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
        const SizedBox(height: 5),
        SizedBox(
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
        const SizedBox(height: 5),
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
