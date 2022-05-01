import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/model/user.dart';
import 'package:project/services/database.dart';

User? user = FirebaseAuth.instance.currentUser;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  MyUser? _firebaseUser(User? user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

  Stream<User?> get user {
    return _auth.authStateChanges();
  }

  //sign in
  Future signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _firebaseUser(user);
    } on FirebaseAuthException catch (e) {
      return e.toString().replaceAll(RegExp('\\[.*?\\]'), '');
    } catch (e) {
      return e.toString();
    }
  }

  //register
  Future register(String email, String password, String username) async {
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

      return _firebaseUser(user);
    } on FirebaseAuthException catch (e) {
      return e.toString().replaceAll(RegExp('\\[.*?\\]'), '');
    } catch (e) {
      return e.toString();
    }
  }

  //sign out
  Future signout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
}
