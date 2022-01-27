import 'package:cryptowallet/infrastructure/auth/auth_failure_or_success.dart';

class FirebaseAuthResult {
  final bool isSuccess;
  final AuthFailureOrSuccess authFailureOrSuccess;

  FirebaseAuthResult({
    required this.isSuccess,
    required this.authFailureOrSuccess,
  });
}
