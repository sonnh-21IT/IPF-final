import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:config/models/project.dart';

import 'package:config/models/user.dart';

class ProjectService {
  static Future<List<Project>> fetchData() async {
    var collection = FirebaseFirestore.instance.collection('project');
    var querySnapshot = await collection.get();
    List<Project> projects = [];
    for (var doc in querySnapshot.docs) {
      Project project = Project(
          idProject: doc.id,
          nameProject: doc['nameProject'],
          field: doc['field'],
          note: doc['note'],
          type: doc['type'],
          location: doc['location'],
          language: doc['language'],
          certificate: doc['certificate'],
          date: doc['date'],
          salaryType: doc['salaryType'],
          minSalary: doc['minSalary'],
          maxSalary: doc['maxSalary'],
          isChecked: doc['isChecked']);
      projects.add(project);
    }
    projects.forEach((element) {
      print("========= ${element.nameProject} ============");
    });
    return projects;
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
        fieldId: doc['field'],
        languageId: doc.data().containsKey('language') ? doc['language'] : '',
        imagePath: doc.data().containsKey('imagePath') ? doc['imagePath'] : '',
        credit: doc['credit']);

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
          languageId: doc['language'],
          imagePath: doc['imagePath'],
          fieldId: doc['field'],
          credit: doc['credit']);
      users.add(user);
    }
    return users;
  }
}
