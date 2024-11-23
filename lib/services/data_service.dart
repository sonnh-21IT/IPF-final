import 'package:cloud_firestore/cloud_firestore.dart';

class DataService {
  String collection;

  late CollectionReference connectData;
  DataService(this.collection){
    connectData = FirebaseFirestore.instance.collection(collection);
  }

  Future<void> addData(Map<String, dynamic> data) async {
    await connectData.add(data);

  }

  Future<void> updateData(String id, Map<String, dynamic> updatedData) async {
    await connectData.doc(id).update(updatedData);
  }

  Future<void> deleteData(String id) async {
    await connectData.doc(id).delete();
  }
}
