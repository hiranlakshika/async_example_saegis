import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class AuthController {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get user => _auth.authStateChanges();

  Future<User> get getUser async => _auth.currentUser!;

  Future<String?> registerWithEmail(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'Weak password';
      } else if (e.code == 'email-already-in-use') {
        return 'Email already in use';
      }
    } catch (e) {
      return 'Unknown error';
    }
  }

  Future<String?> signInWithEmail(String email, String password) async {
    try {
      var response = _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
    } on PlatformException catch (e) {
      return e.message;
    } catch (e) {
      return 'Unknown error';
    }
  }

  Future resetPassword(String email) async {
    try {
      await _auth.sendSignInLinkToEmail(
        email: email,
        actionCodeSettings: ActionCodeSettings(
            // URL you want to redirect back to. The domain (www.example.com) for this
            // URL must be whitelisted in the Firebase Console.
            url: 'google.lk',
            // This must be true
            handleCodeInApp: true,
            androidPackageName: 'com.example.async_example_saegis',
            // installIfNotAvailable
            androidInstallApp: true,
            // minimumVersion
            androidMinimumVersion: '16'),
      );
    } on PlatformException catch (e) {
      return e.message.toString();
    } catch (e) {
      return "unknown_error";
    }
  }

  Future<void> signOut() {
    return _auth.signOut();
  }
}
