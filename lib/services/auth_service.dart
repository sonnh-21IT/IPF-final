import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  User? getCurrentUser(){
    return _auth.currentUser;
  }

  static Future<bool> createUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("Tài khoản đã được tạo: ${userCredential.user?.email}");
      return true;
    } on FirebaseAuthException catch (e) {
      print("Lỗi khi tạo tài khoản: ${e.message}");
      return false;
    }
  }

  static Future<bool> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("Đăng nhập thành công: ${userCredential.user?.email}");
      return true;
    } on FirebaseAuthException catch (e) {
      print("Lỗi khi đăng nhập: ${e.message}");
      return false;
    }
  }

  static Future<bool> checkLogin() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        print("User is logged in: ${user.email}");
        return true;
      } else {
        print("No user is logged in.");
        return false;
      }
    } catch (e) {
      print("Error checking login status: $e");
      return false;
    }
  }

  static Future<bool> signOut() async {
    try {
      await _auth.signOut();
      print("Đã đăng xuất thành công!");
      return true;
    } catch (e) {
      print("Lỗi khi đăng xuất: $e");
      return false;
    }
  }
}
