import 'package:cloud_firestore/cloud_firestore.dart';

class BookItem {
  final String? itemId;
  final String? idCustomer;
  final String? idTranslator;
  final String fieldId;
  final String languageId;
  final double salary;
  final bool isPrepay;
  final int status;
  final Timestamp? timestamp;

  BookItem({
    this.itemId,
    required this.fieldId,
    required this.languageId,
    required this.salary,
    required this.status,
    required this.isPrepay,
    this.idCustomer,
    this.idTranslator,
    this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'fieldId': fieldId,
      'languageId': languageId,
      'salary': salary,
      'status': status,
      'isPrepay': isPrepay,
      'timestamp': timestamp,
      'idCustomer': idCustomer,
      'idTranslator': idTranslator,
    };
  }

// Convert BookItem from a Map factory
  static fromMap(Map<String, dynamic> map) {
    return BookItem(
      fieldId: map['fieldId'],
      languageId: map['languageId'],
      salary: map['salary'],
      status: map['status'],
      isPrepay: map['isPrepay'],
      idTranslator: map['idTranslator'],
      idCustomer: map['idCustomer'],
      timestamp: map['timestamp'],
    );
  }
}
