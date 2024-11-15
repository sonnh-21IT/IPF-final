import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:config/models/message.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ChatServices {
  //get instance of firebase
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // List<Map<String, dynamic>> =
  // [
  // {
  //   'email': 'test2@gmail.com';
  //   'id': '...'
  // },
  // {
  //   'email': 'test3@gmail.com';
  //   'id': '...'
  // },
  // ]

  // get user steam
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firebaseFirestore.collection('user').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

// send message

  Future<void> sendMessage(String receiverId, contentMessage) async {
    // get current user info
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String? currentUserEmail = _firebaseAuth.currentUser!.email;
    final Timestamp timestamp = Timestamp.now();

    // create a new message
    Message message = Message(senderId: currentUserId, senderEmail: currentUserEmail!, receiverId: receiverId, message: contentMessage, timestamp: timestamp);

    // construct chat room ID for the two  users (sorted to ensure uniqueness)
    List<String> ids = [currentUserId, receiverId];
    ids.sort(); // sort the ids (this ensure the chatroomId is the same for any 2 people)
    String chatRoomId = ids.join("_");

    // add new message to database
    await _firebaseFirestore.collection("chat_room").doc(chatRoomId).collection("message").add(message.toMap());
  }

  // get messages
  Stream<QuerySnapshot> getMessage(String userId, otherUserId) {
    // construct a chatroom ID for the two users
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoom = ids.join("_");

    return _firebaseFirestore
        .collection("chat_room").doc(chatRoom)
        .collection("message")
        .orderBy("timestamp", descending: false).snapshots();
  }
}
