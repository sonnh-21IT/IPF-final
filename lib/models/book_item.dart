import 'package:cloud_firestore/cloud_firestore.dart';

class BookItem {
  final String? itemId;
  final String? idCustomer;
  final String? idTranslator;
  final String field;
  final String language;
  final double salary;
  final bool isPrepay;
  final int status;
  final Timestamp? timestamp;

  BookItem({
    this.itemId,
    required this.field,
    required this.language,
    required this.salary,
    required this.status,
    required this.isPrepay,
    this.idCustomer,
    this.idTranslator,
    this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': itemId,
      'field': field,
      'language': language,
      'salary': salary,
      'status': status,
      'isPrepay': isPrepay,
      'timestamp': timestamp,
      'idCustomer': idCustomer,
      'idTranslator': idTranslator,
    };
  }
}
