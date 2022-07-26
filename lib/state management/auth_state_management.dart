import 'package:flutter/material.dart';

enum Status { loading, register, login }

class AuthScreenStateManagement extends ChangeNotifier {
  Status status = Status.login;
  String error = '';

  setStatus(Status newStatus) {
    status = newStatus;
    notifyListeners();
  }

  setError(String e) {
    error = e;
    notifyListeners();
  }

  resetError() {
    error = '';
    notifyListeners();
  }
}
