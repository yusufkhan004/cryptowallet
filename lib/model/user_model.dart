class UserModel {
  String? uid;
  String? displayName;
  String? email;

  UserModel({this.uid, this.displayName, this.email});

  // data from the firebase
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      displayName: map['displayName'],
      email: map['email'],
    );
  }

  // sending data to firebase
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'displayName': displayName,
      'email': email,
    };
  }
}
