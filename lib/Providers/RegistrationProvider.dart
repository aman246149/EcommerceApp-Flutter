import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegistrationProvider extends ChangeNotifier {
  late UserCredential userCredential;
  var noUserFoundForThismale = "";
  var wrongPassword = "";

  void registerUserByEmailAndPassword(var email, var password) async {
    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  void signInWithEmailAndPassword(var email, var password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        noUserFoundForThismale = "No user found for that email.";
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        wrongPassword = "Wrong password provided for that user.";
        print('Wrong password provided for that user.');
      }
    }
  }
}
