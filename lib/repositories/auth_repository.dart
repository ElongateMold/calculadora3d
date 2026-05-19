
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<void> signInAnonymously();
}

class Login implements AuthRepository {
  @override
  Future<void> signInAnonymously() async {
    final anonimous_auth = await FirebaseAuth.instance.signInAnonymously();
  }
}