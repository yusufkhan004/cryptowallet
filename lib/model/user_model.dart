import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late final String uid;
  late final String? displayName;
  Uri? image;
  late final String? email;
  String? phone;
  String? aboutMeDescription;

  UserModel(
      {required this.uid,
      required this.displayName,
      this.image,
      required this.email,
      this.phone,
      this.aboutMeDescription});

  // // data from the firebase
  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        displayName: map['displayName'],
        image: map['image'],
        email: map['email'],
        phone: map['phone'],
        aboutMeDescription: map['aboutMeDescription']);
  }

  // sending data to firebase
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'displayName': displayName,
      'imagePath': image,
      'email': email,
      'phone': phone,
      'about': aboutMeDescription,
    };
  }

  // factory UserModel.fromDocument(DocumentSnapshot doc) {
  //   return UserModel(
  //       uid: doc.data()['uid'],
  //       displayName: doc.data()['displayName'],
  //       image: doc.data()['image'],
  //       email: doc.data()['email'],
  //       phone: doc.data()['phone'],
  //       aboutMeDescription: doc.data()['aboutMeDescription']);
  // }
}
