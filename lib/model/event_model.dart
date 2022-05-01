import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyEvent {
  final String course;
  final String by;
  final String type;
  final String description;
  final Timestamp? when;
  Color? color;

  MyEvent(
      {required this.course,
      required this.by,
      required this.type,
      required this.description,
      this.when,
      this.color});
}
