import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/userinfo.dart';
import '../../services/database.dart';

class CourseListView extends StatelessWidget {
  const CourseListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DatabaseService _dbService = DatabaseService();
    return Container(
        padding: const EdgeInsets.only(left: 15),
        width: MediaQuery.of(context).size.width,
        child: Consumer<UserInformation>(builder: (_, value, __) {
          final List _courses = value.courses ?? [];
          return ListView.builder(
              shrinkWrap: true,
              itemCount: _courses.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_courses[index]),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _dbService.deleteCourse(_courses[index]),
                  ),
                );
              });
        }));
  }
}
