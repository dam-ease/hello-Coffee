import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helloCoffee/models/coffee.dart';
import 'package:helloCoffee/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  // collection reference
  final CollectionReference coffeeCollection =
      FirebaseFirestore.instance.collection('coffees');

  Future updateUserData(String sugars, int strength, String name) async {
    return await coffeeCollection.doc(uid).set({
      'sugars': sugars,
      'strength': strength,
      'name': name,
    });
  }

  // coffee list from snapshot
  List<Coffee> _coffeeListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Coffee(
          name: doc.data()['name'] ?? '',
          strength: doc.data()['strength'] ?? 0,
          sugars: doc.data()['sugars'] ?? '0');
    }).toList();
  }

  //userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data()['name'],
      sugars: snapshot.data()['sugars'],
      strength: snapshot.data()['strength'],
    );
  }

  //get coffee stream
  Stream<List<Coffee>> get coffees {
    return coffeeCollection.snapshots().map(_coffeeListFromSnapshot);
  }

  //get user doc stream
  Stream<UserData> get userData {
    return coffeeCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
