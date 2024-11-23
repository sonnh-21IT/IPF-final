import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:config/models/book_item.dart';

class BookService {
  static Future<void> connect(
      String idCustomer, String idTranslator, BookItem bookItem) async {
    List<String> ids = [idCustomer, idTranslator];
    ids.sort();
    String bookId = ids.join("_");
    BookItem itemPush = BookItem(
      fieldId: bookItem.fieldId,
      languageId: bookItem.languageId,
      salary: bookItem.salary,
      status: bookItem.status,
      isPrepay: bookItem.isPrepay,
      idTranslator: idTranslator,
      idCustomer: idCustomer,
      timestamp: Timestamp.now(),
    );

    var bookingDocRef =
        FirebaseFirestore.instance.collection("booking").doc(bookId);

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      var docSnapshot = await transaction.get(bookingDocRef);

      if (!docSnapshot.exists) {
        transaction
            .set(bookingDocRef, {'createdAt': FieldValue.serverTimestamp()});
      }

      transaction.set(bookingDocRef.collection("item").doc(), itemPush.toMap());
    });
  }

  static Stream<QuerySnapshot> getConnect(
      String idCustomer, String idTranslator) {
    List<String> ids = [idCustomer, idTranslator];
    ids.sort();
    String bookId = ids.join("_");
    return FirebaseFirestore.instance
        .collection("booking")
        .doc(bookId)
        .collection("item")
        .orderBy("timestamp", descending: true)
        .limit(1)
        .snapshots();
  }

  static Stream<QuerySnapshot> trackBookings() {
    return FirebaseFirestore.instance.collection("booking").snapshots();
  }

  static Future<void> updateStatus(BookItem item, int status) async {
    List<String> ids = [item.idCustomer!, item.idTranslator!];
    ids.sort();
    String bookId = ids.join("_");
    await FirebaseFirestore.instance
        .collection("booking")
        .doc(bookId)
        .collection("item")
        .doc(item.itemId)
        .update({'status': status});
  }

  static Future<BookItem?> fetchLatestBookingByUserIdWithStatus(
      String userId, int status) async {
    var querySnapshot =
        await FirebaseFirestore.instance.collection("booking").get();

    for (var bookingDoc in querySnapshot.docs) {
      var itemCollection = bookingDoc.reference.collection("item");

      var itemSnapshot =
          await itemCollection.orderBy("timestamp", descending: true).get();

      for (var doc in itemSnapshot.docs) {
        var data = doc.data();
        if (data['idCustomer'] == userId && data['status'] == status) {
          return BookItem(
            itemId: doc.id,
            fieldId: data['fieldId'],
            languageId: data['languageId'],
            salary: data['salary'],
            status: data['status'],
            isPrepay: data['isPrepay'],
            idTranslator: data['idTranslator'],
            idCustomer: data['idCustomer'],
            timestamp: data['timestamp'],
          );
        }
      }
    }

    return null;
  }
}
