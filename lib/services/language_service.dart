import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:config/models/language.dart';

class LanguageService {
  static Future<void> createLanguage(String id, Language lang) async {
    try {
      await FirebaseFirestore.instance
          .collection('language')
          .doc(id)
          .set(lang.toMap());
    } catch (e) {
      print('Failed to create language: $e');
      rethrow;
    }
  }

  static Future<Language?> readLanguage(String id) async {
    try {
      var doc =
          await FirebaseFirestore.instance.collection('language').doc(id).get();
      if (doc.exists) {
        return Language(
          languageId: doc.id,
          language: doc['language'],
        );
      } else {
        return null;
      }
    } catch (e) {
      print('Failed to read language: $e');
      rethrow;
    }
  }

  static Future<void> updateLanguage(String id, Language lang) async {
    try {
      await FirebaseFirestore.instance
          .collection('language')
          .doc(id)
          .update(lang.toMap());
    } catch (e) {
      print('Failed to update language: $e');
      rethrow;
    }
  }

  static Future<void> deleteLanguage(String id) async {
    try {
      await FirebaseFirestore.instance.collection('language').doc(id).delete();
    } catch (e) {
      print('Failed to delete language: $e');
      rethrow;
    }
  }

  static Future<List<Language>> fetchLanguages() async {
    try {
      var querySnapshot =
          await FirebaseFirestore.instance.collection('language').get();
      List<Language> languages = [];
      for (var doc in querySnapshot.docs) {
        languages.add(Language(
          languageId: doc.id,
          language: doc['language'],
        ));
      }
      return languages;
    } catch (e) {
      print('Failed to fetch languages: $e');
      rethrow;
    }
  }

  static Future<Language?> getLanguageByValue(String languageValue) async {
    try {
      var collection = FirebaseFirestore.instance.collection('language');
      var querySnapshot =
          await collection.where('language', isEqualTo: languageValue).get();
      if (querySnapshot.docs.isNotEmpty) {
        var doc = querySnapshot.docs.first;
        return Language(
          languageId: doc.id,
          language: doc['language'],
        );
      } else {
        return null;
      }
    } catch (e) {
      print('Failed to get language by value: $e');
      rethrow;
    }
  }
}
