import 'package:firebase_auth/firebase_auth.dart';

class AuthFirebase {
  static Future<UserCredential> login(String email, String password) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    UserCredential user = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return user;
  }

  static Future<UserCredential> signUp(String email, String password) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    UserCredential user = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return user;
  }

  static signOut() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
  }
}
