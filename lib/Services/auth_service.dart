import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<bool> login(String email, String password) async {
    try {
      // Attempt to sign in with email and password.
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      // Check if the user is not null
      return user != null;
    } catch (e) {
      // If there's an error, print it (or handle it appropriately)
      print(e.toString());
      return false;
    }
  }

  
}
