import 'package:flutter/cupertino.dart';

class NotificationProvider extends ChangeNotifier {
  String radiovalue = 'DateTime.now()';
  List interval = [];
  bool priority = true;
  bool others = false;

  void setRadioValue(String val) {
    radiovalue = val;
    notifyListeners();
  }

  void removeNotif(int index) {
    interval.remove(interval.toSet().toList()[index]);
    notifyListeners();
  }

  void setPriority() {
    priority = !priority;
  }

  void setOthers() {
    others = !others;
  }
}
