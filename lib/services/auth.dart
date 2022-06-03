import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/routes/routes.dart';
import 'package:project/services/database.dart';
import 'package:flutter/material.dart';

import '../main.dart';

User? user = FirebaseAuth.instance.currentUser;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get user {
    return _auth.authStateChanges();
  }

  //sign in
  Future signIn(String email, String password, BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const Homepage()),
          (route) => false);
      return;
    } on FirebaseAuthException catch (e) {
      return e.toString().replaceAll(RegExp('\\[.*?\\]'), '');
    } catch (e) {
      return e.toString();
    }
  }

  //register
  Future register(String email, String password, String username,
      BuildContext context) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      // create document for user
      await user!.updateDisplayName(username);
      await user.updatePhotoURL(
          'https://firebasestorage.googleapis.com/v0/b/kanma-fyp.appspot.com/o/avi.png?alt=media&token=333280c7-24bb-40b6-bcd8-c56e0f204beb');
      await DatabaseService().updateUserData(
          courses: [],
          testColor: '0xffff0000',
          assignmentColor: '0xff0000ff',
          tutorialColor: '0xff00ff00',
          role: 'student');
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const Homepage()),
          (route) => false);

      return;
    } on FirebaseAuthException catch (e) {
      return e.toString().replaceAll(RegExp('\\[.*?\\]'), '');
    } catch (e) {
      return e.toString();
    }
  }

  //sign out
  Future signout(BuildContext context) async {
    try {
      await _auth.signOut();
      Navigator.of(context)
          .pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
    } catch (e) {
      return null;
    }
  }
}
