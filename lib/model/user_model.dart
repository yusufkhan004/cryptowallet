// import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late final String uid;
  late final String name;
  late final String? username;
  Uri? image;
  late final String? email;
  String? phone;
  String? aboutMeDescription;

  UserModel(
      {required this.uid,
      required this.name,
      required this.username,
      this.image,
      required this.email,
      this.phone,
      this.aboutMeDescription});

  // // data from the firebase
  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        name: map['name'],
        username: map['username'],
        image: map['image'],
        email: map['email'],
        phone: map['phone'],
        aboutMeDescription: map['aboutMeDescription']);
  }

  // sending data to firebase
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'username': username,
      'imagePath': image,
      'email': email,
      'phone': phone,
      'about': aboutMeDescription,
    };
  }

  // factory UserModel.fromDocument(DocumentSnapshot doc) {
  //   return UserModel(
  //       uid: doc.data()['uid'],
  //       username: doc.data()['username'],
  //       image: doc.data()['image'],
  //       email: doc.data()['email'],
  //       phone: doc.data()['phone'],
  //       aboutMeDescription: doc.data()['aboutMeDescription']);
  // }
}
