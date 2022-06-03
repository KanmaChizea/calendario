import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:project/model/event_model.dart';
import 'package:project/model/userinfo.dart';

final uid = FirebaseAuth.instance.currentUser!.uid;

class DatabaseService {
  DatabaseService();

  // collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future updateUserData(
      {required List<String> courses,
      required String testColor,
      required String assignmentColor,
      required String tutorialColor,
      required String role}) async {
    return await userCollection.doc(uid).set({
      'courses': courses,
      'test': testColor,
      'assignment': assignmentColor,
      'tutorial': tutorialColor,
      'role': role
    }, SetOptions(merge: true));
  }

  Future uploadImage(File? image, String? photoURL) async {
    Reference ref = FirebaseStorage.instance.ref().child('$uid/images');
    ref.putFile(image!);

    photoURL = await ref.getDownloadURL();
    await userCollection.doc(uid).update({'PhotoURL': photoURL});
  }

  Future addNewCourse(String course) async {
    List list = [course];
    await userCollection
        .doc(uid)
        .update({'courses': FieldValue.arrayUnion(list)});
  }

  Future deleteCourse(String course) async {
    List list = [course];
    await userCollection
        .doc(uid)
        .update({'courses': FieldValue.arrayRemove(list)});
  }

  Future changeColor(String color, String data) async {
    String fieldName = (data == 'Test')
        ? 'test'
        : ((data == 'Tutorial') ? 'tutorial' : 'assignment');
    String fieldValue = color.substring(6, 16);
    await userCollection.doc(uid).update({fieldName: fieldValue});
  }
}

class EventDatabase {
  User? currentUser = FirebaseAuth.instance.currentUser;

  Future updateEventData(
    String course,
    DateTime by,
    String description,
    String type,
  ) async {
    return await FirebaseFirestore.instance.collection('Events').doc().set(
        {'course': course, 'by': by, 'description': description, 'type': type},
        SetOptions(merge: true));
  }

  List<MyEvent> _converter(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return MyEvent(
          course: doc['course'],
          by: DateFormat.yMMMd().add_jm().format(doc['by'].toDate()).toString(),
          type: doc['type'],
          description: doc['description']);
    }).toList();
  }

  Stream<List<MyEvent>> get courseStream async* {
    DocumentSnapshot value =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final List x = value['courses'];

    yield* FirebaseFirestore.instance
        .collection('Events')
        .orderBy('by')
        .where('course', whereIn: x)
        .snapshots()
        .map(_converter);
  }
  // return FirebaseFirestore.instance
  //     .collection('Events')
  //     .orderBy('by')

  //     .snapshots()
  //     .map(_converter);

  deleteExpiredEvents() {
    FirebaseFirestore.instance
        .collection('Events')
        .where('by', isLessThan: DateTime.now())
        .get()
        // ignore: avoid_function_literals_in_foreach_calls
        .then((value) => value.docs.forEach((element) {
              element.reference.delete();
            }));
  }

  Stream<UserInformation> userDataStream() => FirebaseFirestore.instance
      .collection('users')
      .doc(currentUser?.uid)
      .snapshots()
      .map((event) => UserInformation(
          test: event['test'],
          assignment: event['assignment'],
          tutorial: event['tutorial'],
          role: event['role'],
          courses: event['courses']));
}
