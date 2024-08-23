import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:souq_chemicals/pages/home/updatepro.dart';
import 'package:souq_chemicals/services/userdb.dart';

class Authservice {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //auth change userstream
  Stream<User?> get user {
    return _auth.authStateChanges();
  }

  //sign in with email and password
  Future signinwithemailandpassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email and password
  Future registerwithemailandpassword(
      String email, String password, String name, String number) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);

      User? user = result.user;

      await userdb(uid: user!.uid).updateuserdata(name, number);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signout() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Password reset
  Future passwordreset(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email.trim());
    } catch (e) {}
  }
}
