import 'package:flutter/material.dart';

class HandleItemChange {

  static void showDialogOnChange(String title, Color color, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: IntrinsicHeight(
            child: Container(
              width: 300,
              color: const Color(0x0081c784),
              child: Row(
                children: [
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: title,
                        style: TextStyle(
                          color: color,
                        ),
                      ),
                      softWrap: true,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static void displayNewItem(Map<String, dynamic>? itemData) {
    if (itemData == null) return;
    print("Item Details:");
    print("Field ID: ${itemData['fieldId']}");
    print("Language ID: ${itemData['languageId']}");
    print("Salary: ${itemData['salary']}");
    print("Status: ${itemData['status']}");
    print("Is Prepay: ${itemData['isPrepay']}");
    print("ID Translator: ${itemData['idTranslator']}");
    print("ID Customer: ${itemData['idCustomer']}");
    print("Timestamp: ${itemData['timestamp']}");
  }

  static void handleModifiedItem(Map<String, dynamic>? itemData) {
    if (itemData == null) return;
  }
}
