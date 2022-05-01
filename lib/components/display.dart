import 'package:project/model/userinfo.dart';
import 'package:project/pages/event_view.dart';
import 'package:flutter/material.dart';
import 'package:project/model/event_model.dart';
import 'package:provider/provider.dart';

class DisplaySchedule extends StatelessWidget {
  const DisplaySchedule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserInformation userInfo = Provider.of<UserInformation>(context);

    return Consumer<List<MyEvent>>(builder: (context, value, child) {
      if (value.isNotEmpty) {
        return ListView.builder(
            itemCount: value.length,
            itemBuilder: (context, index) {
              String _color = (value[index].type == 'Test')
                  ? userInfo.test
                  : ((value[index].type == 'Tutorial')
                      ? userInfo.tutorial
                      : userInfo.assignment);
              return Card(
                elevation: 2,
                child: ListTile(
                  title: Text(value[index].course),
                  subtitle: Text(value[index].by),
                  leading: Container(
                    width: 10,
                    color: Color(int.parse(_color)),
                  ),
                  minLeadingWidth: 1.0,
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OpenCourse(x: value[index]))),
                ),
              );
            });
      } else {
        return Container(
          margin: const EdgeInsets.only(top: 50),
          child: const Center(
            child: Text(
              'NO EVENT',
              style: TextStyle(fontSize: 18),
            ),
          ),
        );
      }
    });
  }
}
