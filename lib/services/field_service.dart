import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/field.dart';

class FieldService {
  static Future<void> createField(String id, Field field) async {
    try {
      await FirebaseFirestore.instance
          .collection('field')
          .doc(id)
          .set(field.toMap());
    } catch (e) {
      print('Failed to create field: $e');
      rethrow;
    }
  }

  static Future<Field?> readField(String id) async {
    try {
      var doc =
          await FirebaseFirestore.instance.collection('field').doc(id).get();
      if (doc.exists) {
        return Field(
          fieldId: doc.id,
          field: doc['field'],
        );
      } else {
        return null;
      }
    } catch (e) {
      print('Failed to read field: $e');
      rethrow;
    }
  }

  static Future<void> updateField(String id, Field field) async {
    try {
      await FirebaseFirestore.instance
          .collection('field')
          .doc(id)
          .update(field.toMap());
    } catch (e) {
      print('Failed to update field: $e');
      rethrow;
    }
  }

  static Future<void> deleteField(String id) async {
    try {
      await FirebaseFirestore.instance.collection('field').doc(id).delete();
    } catch (e) {
      print('Failed to delete field: $e');
      rethrow;
    }
  }

  static Future<List<Field>> fetchFields() async {
    try {
      var querySnapshot =
          await FirebaseFirestore.instance.collection('field').get();
      List<Field> fields = [];
      for (var doc in querySnapshot.docs) {
        fields.add(Field(
          fieldId: doc.id,
          field: doc['field'],
        ));
      }
      return fields;
    } catch (e) {
      print('Failed to fetch fields: $e');
      return [];
    }
  }
}
