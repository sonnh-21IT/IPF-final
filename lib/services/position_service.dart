import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:location/location.dart';

import 'package:config/models/position.dart';
import 'package:config/models/user.dart';
import 'account_service.dart';

class PositionService {
  static Future<void> updateFireStoreLocation(
      LocationData locationData, String documentId) async {
    try {
      var collection = FirebaseFirestore.instance.collection('positions');
      Users user = await AccountService.fetchUserByAccountId(
          FirebaseAuth.instance.currentUser!.uid);
      Position position = Position(
          userId: user.userId!,
          latitude: locationData.latitude!,
          longitude: locationData.longitude!);
      await collection.doc(documentId).update(position.toMap());
    } catch (e) {
      print('Failed to update location: $e');
    }
  }

  static Future<String> createLocationInFireStore(LocationData location) async {
    var collection = FirebaseFirestore.instance.collection('positions');
    Users user = await AccountService.fetchUserByAccountId(
        FirebaseAuth.instance.currentUser!.uid);
    Position position = Position(
        userId: user.userId!,
        latitude: location.latitude!,
        longitude: location.longitude!);
    var docRef = await collection.add(position.toMap());
    print('Document created: $docRef.id');
    return docRef.id;
  }

  static Future<void> deleteLocation(String documentId) async {
    if (documentId.isNotEmpty) {
      var collection = FirebaseFirestore.instance.collection('positions');
      await collection.doc(documentId).delete();
      print('Deleted Location: $documentId');
    }
  }

  static Future<Position> getPositionByUserId(String userId) async {
    var collection = FirebaseFirestore.instance.collection('positions');
    var querySnapshot =
        await collection.where('userId', isEqualTo: userId).get();
    print(querySnapshot.docs);
    dynamic doc = querySnapshot.docs.first;
    Position position = Position(
      userId: doc['userId'],
      latitude: doc['latitude'],
      longitude: doc['longitude'],
    );

    return position;
  }
}