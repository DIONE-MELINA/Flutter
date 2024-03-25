// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_operation/pages/Register/model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
final _firestore = FirebaseFirestore.instance;
final _storage = FirebaseStorage.instance;

final userProvider = StateNotifierProvider<UserNotifier, Localuser>((ref) {
  return UserNotifier();
});

class Localuser {
  final Userclass user;
  final String uId;
  Localuser({
    required this.user,
    required this.uId,
  });
//helps us to keep note of the uid
  Localuser copyWith({
    Userclass? user,
    String? uId,
  }) {
    return Localuser(
      user: user ?? this.user,
      uId: uId ?? this.uId,
    );
  }
}

class UserNotifier extends StateNotifier<Localuser> {
  UserNotifier()
      : super(Localuser(
            user: Userclass(name: "", email: "", photoUrl: ""), uId: ""));

  Future<void> fetchUserData(String name, String email) async {
    //first we write to our repository in a particular collection
    DocumentReference ref = await FirebaseFirestore.instance
        .collection('users')
        .add(Userclass(
                name: name,
                email: email,
                photoUrl:
                    "https://th.bing.com/th/id/OIP.xo-BCC1ZKFpLL65D93eHcgHaGe?rs=1&pid=ImgDetMain")
            .toMap());
    // next we get this infromation from our backend
    DocumentSnapshot snapshot = await ref.get();
    //then we update the state since statenotifier is mutable we most update the initial state of the user
    state = Localuser(
        user: Userclass.fromMap(snapshot.data() as Map<String, dynamic>),
        uId: snapshot.id);
  }

  void signOut() {
    state =
        Localuser(user: Userclass(name: "", email: "", photoUrl: ""), uId: "");
  }

  Future<void> getUserData(String email) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where("email", isEqualTo: email)
        .get();
    if (snapshot.docs.isEmpty) {
      return debugPrint("");
    } else {
      state = Localuser(
          user: Userclass.fromMap(
              snapshot.docs[0].data() as Map<String, dynamic>),
          uId: snapshot.docs[0].id);
    }
  }

  Future<void> updateImage(File image) async {
    //storing the image in firebase storage
    Reference ref = _storage.ref().child('users').child(state.uId);
    TaskSnapshot snapshot = await ref.putFile(image);
    String PhotoPicUrl = await snapshot.ref.getDownloadURL();
    //writing image to our backend.
    await _firestore
        .collection('users')
        .doc(state.uId)
        .update({"photoUrl": PhotoPicUrl});
    state = state.copyWith(user: state.user.copyWith(photoUrl: PhotoPicUrl));
  }


Future<void> Updatename(String name) async {
    try {
      await _firestore.collection('users').doc(state.uId).update({
        'name': name,
      });
      //this is to ensure that the id is same thats why we user the copy with method
      state = state.copyWith(user: state.user.copyWith(name: name));
    } catch (error) {
      ScaffoldMessenger(
        child: Text(error.toString()),
      );
    }
  }

}

