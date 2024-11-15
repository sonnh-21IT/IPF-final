import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/role.dart';

class RoleService {
  static Future<List<Role>> fetchRoles() async {
    var collection = FirebaseFirestore.instance.collection('role');
    var querySnapshot = await collection.get();
    List<Role> roles = [];
    for (var doc in querySnapshot.docs) {
      Role role = Role(
        roleId: doc.id,
        role: doc['role'],
      );
      roles.add(role);
    }
    return roles;
  }

  static Future<Role?> getRoleById(String roleId) async {
    var doc =
        await FirebaseFirestore.instance.collection('role').doc(roleId).get();
    if (doc.exists) {
      return Role(
        roleId: doc.id,
        role: doc['role'],
      );
    } else {
      return null;
    }
  }

  static Future<Role?> getRoleByValue(String roleValue) async {
    var collection = FirebaseFirestore.instance.collection('role');
    var querySnapshot =
        await collection.where('role', isEqualTo: roleValue).get();
    if (querySnapshot.docs.isNotEmpty) {
      var doc = querySnapshot.docs.first;
      return Role(
        roleId: doc.id,
        role: doc['role'],
      );
    } else {
      return null;
    }
  }
}
