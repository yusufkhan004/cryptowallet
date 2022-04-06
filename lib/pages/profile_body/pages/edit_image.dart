// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptowallet/model/user_model.dart';
import 'package:cryptowallet/pages/profile_body/widgets/appbar_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';

class EditImagePage extends StatefulWidget {
  const EditImagePage({Key? key}) : super(key: key);

  @override
  _EditImagePageState createState() => _EditImagePageState();
}

class _EditImagePageState extends State<EditImagePage> {
  // var user = UserData.myUser;

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  User? mainUser = FirebaseAuth.instance.currentUser;

  // UserModel userModel = UserModel(
  //   image: _imageFile,
  // );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
                width: 330,
                child: const Text(
                  "Upload a photo of yourself:",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            Padding(
                padding: EdgeInsets.only(top: 20),
                child: SizedBox(
                    width: 330,
                    child: GestureDetector(
                      onTap: () async {
                        final image = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
      
                        if (image == null) return;
      
                        final location = await getApplicationDocumentsDirectory();
                        final name = basename(image.path);
                        final imageFile = File('${location.path}/$name');
                        final newImage =
                            await File(image.path).copy(imageFile.path);
                        // setState(
                            // () => user = user.copy(imagePath: newImage.path));
                      },
                      // child: Image.network(user.image),
                    ))),
            Padding(
                padding: EdgeInsets.only(top: 40),
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: 160,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          'Update',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    )))
          ],
        ),
      ),
    );
  }
}
