import 'package:cryptowallet/domain/auth/firebase_auth_result.dart';
import 'package:flutter/material.dart';

abstract class IAuthFacade {
  Future<FirebaseAuthResult> registerWithEmailAndPassword({
     String emailAddress,
    @required String password,
  });

  Future<FirebaseAuthResult> signInWithEmailAndPassword({
    @required String emailAddress,
    @required String password,
  });
}
