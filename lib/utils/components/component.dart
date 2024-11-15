import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:multi_dropdown/multi_dropdown.dart';


typedef ValueChangedTwoParams = void Function(String?, String?);

// ======================= TEXT ===========================================
class CustomText extends StatelessWidget {
  final String data;
  final FontWeight fontWeight;
  final Color color;
  final double fontSize;
  final TextAlign textAlign;
  final FontStyle fontStyle;

  const CustomText({
    super.key,
    required this.data,
    this.fontWeight = FontWeight.normal,
    this.color = Colors.black,
    this.fontSize = 14.0,
    this.textAlign = TextAlign.start,
    this.fontStyle = FontStyle.normal,
  });

  @override
  Widget build(BuildContext context) {
    return
      Text(
      data,
      style: TextStyle(
        fontWeight: fontWeight,
        color: color,
        fontSize: fontSize,
        fontStyle: fontStyle,
      ),
      textAlign: textAlign,
    );
  }
}

//==========================APP BAR=================================

class CustomAppbar extends StatelessWidget {
  String title;

  CustomAppbar(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 20),
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: AppBar(
        backgroundColor: Colors.white,
        leading: Container(
          decoration: BoxDecoration(
            color: Colors.green, // Màu nền
            borderRadius: BorderRadius.circular(50), // Bo góc
          ),
          child: IconButton(
            icon: const FaIcon(
              FontAwesomeIcons.chevronLeft,
              color: Colors.white,
              size: 16, // Kích thước biểu tượng
            ),
            onPressed: () {
              // Xử lý sự kiện khi nhấn nút quay lại
              if (Navigator.canPop(context)) {
                Navigator.pop(context); // Quay lại trang trước nếu có thể
              }
            },
          ),
        ),
        title: CustomText(data: title,fontWeight: FontWeight.bold,fontSize: 20),
        centerTitle: true,
      ),
    );
  }
}

//========================== TITLE ==========================================
class CustomTitle extends StatelessWidget {
  final String title;

  const CustomTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      width: double.infinity,
      color: const Color(0xFFEDEDFC),
      child: CustomText(data: title, fontSize: 20),
    );
  }
}

// ==========================TEXT FIELD =====================================
class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String title;
  final double fontSize;
  final TextInputType keyboardType;
  final IconData? sunfixIcon;
  final IconData? prefixIcon;

  const CustomTextField(
      {super.key,
        required this.controller,
        required this.title,
        required this.hintText,
        this.fontSize = 16.0,
        this.keyboardType = TextInputType.text,
        this.prefixIcon,
        this.sunfixIcon,
      });

  @override
  State<StatefulWidget> createState() {
    return _CustomTextFieldState();
  }
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(data: widget.title,fontSize: 18, fontWeight: FontWeight.bold,textAlign: TextAlign.left),
            const SizedBox(height: 5),
            TextField(
              controller: widget.controller,
              keyboardType: widget.keyboardType,
              inputFormatters: <TextInputFormatter>[
                widget.keyboardType != TextInputType.text ?
                FilteringTextInputFormatter.digitsOnly : FilteringTextInputFormatter.singleLineFormatter

              ],
              style: TextStyle(
                fontSize: widget.fontSize,
              ),
              decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: const TextStyle(
                    color: Color(0xFF939393),
                  ),
                  prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
                  suffixIcon: widget.sunfixIcon != null ? Icon(widget.sunfixIcon) : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 1.0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xFF4CAF4F), width: 2.0, ),
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
          ],
        ));
  }
}

// ========================== DropDownButton ===============================
class CustomDropdownButton extends StatefulWidget {

  final List<String> list;
  final String title;
  final String hint;
  final ValueChangedTwoParams onChanged;
  const CustomDropdownButton( {super.key, required this.list,
    required this.title,
    required this.hint,
    required this.onChanged,});

  @override
  State<StatefulWidget> createState() {
    return _CustomDropdownButtonState();
  }
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {

  late List<String> _list;
  late String value;
  late ValueNotifier<String> _valueNotifier;
  late String type;
  late String hint;
  Color borderColor = Colors.black;
  Color textColor = Colors.black;
  String? selectValue;
  Map<String, List<String>> languageCertificates = {
    'Tiếng Anh': ['IELTS', 'TOEFL', 'Cambridge'],
    'Tiếng Pháp': ['DELF', 'DALF', 'TCF'],
    'Tiếng Nhật': ['JLPT N1', 'JLPT N2', 'JLPT N3','JLPT N4','JLPT N5', 'J-Test','TOPJ'],
    'Tiếng Hàn': ['TOPIK I - level 1','TOPIK I - level 2','TOPIK II - level 3','TOPIK II - level 4','TOPIK II - level 5','TOPIK II - level 6', 'EPS-TOPIK'],
  };


  @override
  void initState() {
    super.initState();
    _list = widget.list;
    hint = widget.hint;
    _valueNotifier = ValueNotifier<String>(_list.isNotEmpty ? _list[0] : '');
    if(widget.title == "Lĩnh vực"){
      type = "field";
    }else if(widget.title == "Loại hình làm việc"){
      type = "type";
    }else if (widget.title == "Nơi làm việc"){
      type = "location";
    }else if(widget.title == "Ngôn Ngữ"){
      type = "language";
    }else if(widget.title == "Chứng chỉ"){
      type = "certificate";
    }else{
      type = "typeSalary";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          borderColor = hasFocus ? const Color(0xFF4CAF4F) :  Colors.black;
          // textColor = hasFocus ? Colors.black :  Color(0xFF939393);
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(data: widget.title,fontWeight: FontWeight.bold,fontSize: 18,textAlign: TextAlign.left,),
          const SizedBox(height: 5),

          Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white, // Màu nền của DropdownButton
              border: Border.all(color: borderColor, width: 1), // Màu và độ rộng của viền
              borderRadius: BorderRadius.circular(10), // Bo góc viền
            ),
            child:  ValueListenableBuilder<String>(
              valueListenable: _valueNotifier,
              builder: (context, value, child) {
                return DropdownButton<String>(
                  value: selectValue,
                  hint: CustomText(data: hint,fontSize: 16,color: textColor,),
                  icon: const FaIcon(
                    FontAwesomeIcons.chevronDown,
                    color: Colors.black,
                    size: 16,
                  ),
                  elevation: 18,
                  style: const TextStyle(color: Colors.black),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      // _valueNotifier.value = newValue;
                      selectValue = newValue;
                      widget.onChanged(newValue,type);
                    }
                  },
                  items: _list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: CustomText(data: value,fontSize: 16,color: textColor,),
                    );
                  }).toList() ,
                  underline: Container(),
                  isExpanded: true,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// =============================TEXTAREA=======================================
class CustomTextArea extends StatelessWidget{
  final TextEditingController controller;
  final int num_line;
  final String hint_text;

  const CustomTextArea(
      {super.key,
        required this.num_line,
        required this.hint_text,
        required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: [
            TextField(
              controller: controller,
              keyboardType: TextInputType.multiline,
              maxLines: num_line,
              decoration: InputDecoration(
                  hintText: hint_text,
                  hintStyle: const TextStyle(
                    color: Color(0xFF939393),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 1.0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xFF4CAF4F), width: 2.0, ),
                    borderRadius: BorderRadius.circular(10),
                  )),
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        )
    );
  }
}

// ============================DATEPICKER======================================
class DatePickerWidget extends StatefulWidget {
  late DateTime date;
  final Function(DateTime) onDateChanged;
  final String title;

  DatePickerWidget(
      {super.key,
        required this.date,
        required this.onDateChanged,
        required this.title});

  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  late DateTime selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1970),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        widget.date = picked;
      });
      widget.onDateChanged(picked);
    }
  }

  @override
  void initState() {
    super.initState();
    selectedDate = widget.date;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CustomText(data: widget.title , fontSize: 18,textAlign: TextAlign.left,fontWeight: FontWeight.bold,),
        const SizedBox(height: 5),
        GestureDetector(
          onTap: () => _selectDate(context),
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),

              ),
              child: Row(
                children: [
                  const Icon(FontAwesomeIcons.calendarDays),
                  const SizedBox(width: 10),
                  Text(
                    DateFormat('dd/MM/yyyy').format(selectedDate),
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              )
          ),
        ),
      ],
    );
  }
}

// =============================== CHECKBOX ==================================
class CustomCheckbox extends StatefulWidget {
  final String content;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const CustomCheckbox({super.key, 
    required this.content,
    required this.value,
    required this.onChanged,
  });
  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start, // Căn theo chiều ngang
          verticalDirection: VerticalDirection.down,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
              checkColor: Colors.white,
              fillColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return const Color(0xFF4CAF4F); // Màu nền khi Checkbox được chọn
                }
                return Colors.white; // Màu nền khi Checkbox không được chọn
              }),
              value: widget.value,
              onChanged: widget.onChanged,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 10),
                child: CustomText(
                  data: widget.content,
                  fontSize: 14,
                  color: Colors.grey,
                  textAlign: TextAlign.justify,
                ),
              )
            ),
          ],
        )
    );
  }
}

// ========================= CUSTOM CONTACTNUMBER ===========================
class CustomContactNumber extends StatefulWidget {
  final String modeNumber;
  final String phoneNumber;
  final ValueChangedTwoParams onChanged;

  const CustomContactNumber({
    super.key,
    required this.modeNumber,
    required this.phoneNumber,
    required this.onChanged,
  });

  @override
  _ContactNumberInputState createState() => _ContactNumberInputState();
}

class _ContactNumberInputState extends State<CustomContactNumber> {
  final List<String> _countryCodes = [
    '+84',
    '+1',
    '+91',
    '+82',
    '+81',
    '+86'
  ]; // Danh sách mã quốc gia
  String? _selectedCountryCode;
  TextEditingController? _controller;

  // Bản đồ ánh xạ mã quốc gia với đường dẫn tới biểu tượng quốc kỳ
  final Map<String, String> _countryFlags = {
    '+84': 'assets/images/vietnam.jpg',
    '+1': 'assets/images/usa.jpg',
    '+91': 'assets/images/india.jpg',
    '+82': 'assets/images/korean.jpg',
    '+81': 'assets/images/japan.jpg',
    '+86': 'assets/images/china.jpg',
  };

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.phoneNumber);
    _selectedCountryCode = widget.modeNumber; // Mã quốc gia mặc định
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(data: "Số điện thoại liên hệ",fontWeight: FontWeight.bold,fontSize: 18,textAlign: TextAlign.left,),
        const SizedBox(height: 5),

        Container(
          child: Row(
            children: [
              IntrinsicWidth(
                child: Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // Màu nền của DropdownButton
                    border: Border.all(color: Colors.black, width: 1),
                    // Màu và độ rộng của viền
                    borderRadius: BorderRadius.circular(10), // Bo góc viền
                  ),
                  child: DropdownButton<String>(
                    underline: Container(),
                    value: _selectedCountryCode,
                    items: _countryCodes.map((String code) {
                      return DropdownMenuItem<String>(
                        value: code,
                        child: Row(
                          children: [
                            if (_countryFlags.containsKey(code))
                              Image.asset(_countryFlags[code]!, width: 24),
                            // Sử dụng biểu tượng quốc kỳ tương ứng
                            const SizedBox(width: 8),
                            Text(code),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCountryCode = newValue!;
                        widget.onChanged(_selectedCountryCode, _controller!.text);
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _controller,
                  onChanged: (String? newValue) {
                    setState(() {
                      _controller = newValue! as TextEditingController?;
                      widget.onChanged(_selectedCountryCode, _controller!.text);
                    });
                  },
                  keyboardType: TextInputType.phone,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(
                      hintText: "Nhập số điện thoại của bạn...",
                      hintStyle: const TextStyle(
                        color: Color(0xFF939393),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black, width: 1.0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFF4CAF4F),
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
              ),
            ],
          ),
        )
      ],

    );
  }
}

// ======================== CustomMultiSelectDropdown - Lĩnh Vực =========================
class CustomMultiSelectDropdown extends StatefulWidget {
  final List<String> items;
  final Function(List<String>) onSelectionChanged;

  const CustomMultiSelectDropdown({
    super.key,
    required this.items,
    required this.onSelectionChanged,
  });

  @override
  _CustomMultiSelectDropdownState createState() => _CustomMultiSelectDropdownState();
}

class _CustomMultiSelectDropdownState extends State<CustomMultiSelectDropdown> {
  late List<DropdownItem<String>> dropdownItems;
  final controller = MultiSelectController<String>();
  late List<String> selectedItems;
  late List<String> initialItems;

  @override
  void initState() {
    super.initState();
    initialItems = ['Y tế', 'Pháp luật', 'Du lịch', 'Giao thông', 'Sự kiện',"Kinh doanh"];
    selectedItems = List.from(widget.items);
    _resetValueMultiSelectDropdown();
  }

  void _resetValueMultiSelectDropdown() {
    dropdownItems = initialItems
        .map((item) => DropdownItem(
      label: item,
      value: item,
      selected: selectedItems.contains(item),
    ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            data: "Lĩnh vực",
            fontWeight: FontWeight.bold,
            fontSize: 18,
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 5),
          Container(
            child:  Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: MultiDropdown<String>(
                      items: dropdownItems,
                      controller: controller,
                      enabled: true,
                      searchEnabled: true,
                      maxSelections: initialItems.length,
                      chipDecoration: ChipDecoration(
                        backgroundColor: Colors.indigo.withAlpha(30),
                        wrap: false,
                        runSpacing: 8,
                        spacing: 10,
                      ),
                      fieldDecoration: FieldDecoration(
                        hintText: '- Lĩnh vực -',
                        hintStyle: const TextStyle(color: Colors.black87, fontSize: 14),
                        prefixIcon: const Icon(FontAwesomeIcons.clipboardList),
                        showClearIcon: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF4CAF4F),
                            width: 2.0,
                          ),
                        ),
                      ),
                      dropdownDecoration: const DropdownDecoration(
                        header: Padding(
                          padding: EdgeInsets.all(8),
                          child: CustomText(
                            data: 'Chọn lĩnh vực của bạn: ',
                            textAlign: TextAlign.start,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      dropdownItemDecoration: DropdownItemDecoration(
                        selectedIcon: const Icon(FontAwesomeIcons.check, color: Colors.green),
                        disabledIcon: Icon(Icons.lock, color: Colors.grey.shade600),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng chọn lĩnh vực của bạn!!!';
                        }
                        return null;
                      },
                      onSelectionChange: (selectedItems) {
                        setState(() {
                          if (selectedItems.isEmpty) {
                            this.selectedItems = List.from([""]);
                            _resetValueMultiSelectDropdown();
                          } else {
                            this.selectedItems = selectedItems;
                          }
                        });
                        widget.onSelectionChanged(selectedItems);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
