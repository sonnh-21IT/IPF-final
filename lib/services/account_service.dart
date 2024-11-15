import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:config/models/user.dart';

class AccountService {
  static Future<List<Users>> fetchData() async {
    var collection = FirebaseFirestore.instance.collection('user');
    var querySnapshot = await collection.get();
    List<Users> users = [];
    for (var doc in querySnapshot.docs) {
      Users user = Users(
          roleId: doc['roleId'],
          userId: doc.id,
          accountId: doc['accountId'],
          fullName: doc['fullName'],
          email: doc['email'],
          address: doc['address'],
          phone: doc['phone'],
          biography: doc['biography'],
          status: doc['status'],
          birthday: doc['birthday'],
          language: doc['language'],
          imagePath: doc['imagePath'],
          field: doc['field']);
      users.add(user);
    }
    return users;
  }

  static Future<Users> fetchUserByAccountId(String accountId) async {
    var collection = FirebaseFirestore.instance.collection('user');
    var querySnapshot =
        await collection.where('accountId', isEqualTo: accountId).get();

    dynamic doc = querySnapshot.docs.first;

    Users user = Users(
        roleId: doc['roleId'],
        userId: doc.id,
        accountId: doc['accountId'],
        fullName: doc['fullName'],
        email: doc['email'],
        address: doc['address'],
        phone: doc['phone'],
        biography: doc['biography'],
        status: doc['status'],
        birthday: doc['birthday'],
        field: doc['field'],
        language: doc.data().containsKey('language') ? doc['language'] : '',
        imagePath: doc.data().containsKey('imagePath') ? doc['imagePath'] : '');

    return user;
  }

  static Future<void> updateUserStatus(String userId, bool newStatus) async {
    try {
      await FirebaseFirestore.instance.collection('user').doc(userId).update({
        'status': newStatus,
      });
    } catch (e) {
      print(e);
    }
  }

  static Future<String?> getUserStatus(String userId) async {
    try {
      DocumentSnapshot doc =
          await FirebaseFirestore.instance.collection('user').doc(userId).get();
      if (doc.exists) {
        return doc['status'];
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<List<Users>> fetchActiveUsers(
      bool status, String roleId) async {
    var collection = FirebaseFirestore.instance.collection('user');
    var querySnapshot = await collection
        .where('status', isEqualTo: status)
        .where('roleId', isEqualTo: roleId)
        .get();
    List<Users> users = [];
    for (var doc in querySnapshot.docs) {
      Users user = Users(
          userId: doc.id,
          roleId: doc['roleId'],
          accountId: doc['accountId'],
          fullName: doc['fullName'],
          email: doc['email'],
          address: doc['address'],
          phone: doc['phone'],
          biography: doc['biography'],
          status: doc['status'],
          birthday: doc['birthday'],
          language: doc['language'],
          imagePath: doc['imagePath'],
          field: doc['field']);
      users.add(user);
    }
    return users;
  }

// Thêm hàm lấy dữ liệu bằng userId
  static Future<Users> fetchUserById(String userId) async {
    var doc =
        await FirebaseFirestore.instance.collection('user').doc(userId).get();
    if (doc.exists) {
      return Users(
        userId: doc.id,
        roleId: doc['roleId'],
        accountId: doc['accountId'],
        fullName: doc['fullName'],
        email: doc['email'],
        address: doc['address'],
        phone: doc['phone'],
        biography: doc['biography'],
        status: doc['status'],
        birthday: doc['birthday'],
        field: doc['field'],
        imagePath: doc['imagePath'],
        language: doc['language']
      );
    } else {
      throw Exception("User not found");
    }
  }
}
