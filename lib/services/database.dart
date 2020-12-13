import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  // collection reference
  final CollectionReference coffeeCollection =
      FirebaseFirestore.instance.collection('coffees');

  Future updateUserData(String sugars, int strength, String name) async {
    return await coffeeCollection
        .doc(uid)
        .set({'sugars': sugars, 'name': name, 'strength': strength});
  }
}
