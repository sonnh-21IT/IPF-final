import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:config/models/certificate.dart';

class CertificateService {
  static Future<void> createCertificate(String id, Certificate cert) async {
    try {
      await FirebaseFirestore.instance
          .collection('certificate')
          .doc(id)
          .set(cert.toMap());
    } catch (e) {
      print('Failed to create certificate: $e');
      rethrow;
    }
  }

  static Future<Certificate?> readCertificate(String idUser) async {
    try {
      var docs =  await FirebaseFirestore.instance.collection('certificate').where('idUser', isEqualTo: idUser).get();
      if (docs.docs.isNotEmpty) {
        var doc = docs.docs.first;
        return Certificate(
          certificateId: doc.id,
          imgCheck: doc['imgCheck'],
          idLanguage: doc['idLanguage'],
          idUser: doc['idUser'],
          status: doc['status'],
          level: doc['level'],
        );
      } else {
        return null;
      }
    } catch (e) {
      print('Failed to read certificate: $e');
      rethrow;
    }
  }

  static Future<void> updateCertificate(String id, Certificate cert) async {
    try {
      await FirebaseFirestore.instance
          .collection('certificate')
          .doc(id)
          .update(cert.toMap());
    } catch (e) {
      print('Failed to update certificate: $e');
      rethrow;
    }
  }

  static Future<void> deleteCertificate(String id) async {
    try {
      await FirebaseFirestore.instance.collection('certificate').doc(id).delete();
    } catch (e) {
      print('Failed to delete certificate: $e');
      rethrow;
    }
  }

  static Future<List<Certificate>> fetchCertificates() async {
    try {
      var querySnapshot =
      await FirebaseFirestore.instance.collection('certificate').get();
      List<Certificate> certificates = [];
      for (var doc in querySnapshot.docs) {
        certificates.add(Certificate(
          certificateId: doc.id,
          imgCheck: doc['imgCheck'],
          idLanguage: doc['idLanguage'],
          idUser: doc['idUser'],
          status: doc['status'],
          level: doc['level'],
        ));
      }
      return certificates;
    } catch (e) {
      print('Failed to fetch certificates: $e');
      rethrow;
    }
  }

  static Future<Certificate?> getCertificateByValue(String imgCheckValue) async {
    try {
      var collection = FirebaseFirestore.instance.collection('certificate');
      var querySnapshot =
      await collection.where('imgCheck', isEqualTo: imgCheckValue).get();
      if (querySnapshot.docs.isNotEmpty) {
        var doc = querySnapshot.docs.first;
        return Certificate(
          certificateId: doc.id,
          imgCheck: doc['imgCheck'],
          idLanguage: doc['idLanguage'],
          idUser: doc['idUser'],
          status: doc['status'],
          level: doc['level'],
        );
      } else {
        return null;
      }
    } catch (e) {
      print('Failed to get certificate by value: $e');
      rethrow;
    }
  }
}