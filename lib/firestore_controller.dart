import 'package:async_example_saegis/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreController {
  CollectionReference _users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser(User user) {
    return _users
        .add({
          'name': user.name,
          'age': user.age,
          'address': user.address,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<String?> getUserDocId(String name) async {
    String? userDocId;
    await _users.where('name', isEqualTo: name).get().then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.length > 0) {
        userDocId = querySnapshot.docs[0].id;
      }
    });
    return userDocId;
  }

  Future<void> updateUserAddress(String address, String documentId) {
    return _users
        .doc(documentId)
        .update({'address': address})
        .then((value) => print('User updated'))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> deleteUser(String documentId) {
    return _users.doc(documentId).delete().then((value) => print("User Deleted")).catchError((error) => print("Failed to delete user: $error"));
  }
}
