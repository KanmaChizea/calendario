import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/model/userinfo.dart';
import 'package:project/services/database.dart';
import 'package:project/components/drawer.dart';
import 'package:provider/provider.dart';

class Courses extends StatelessWidget {
  const Courses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List courseList = Provider.of<UserInformation>(context).courses ?? [];

    return Scaffold(
      appBar: AppBar(title: const Text('Courses')),
      body: SingleChildScrollView(
        child: Column(children: [
          verticalSpace(10),
          buildCourseList(context),
          Center(
            child: addButton(context, courseList),
          ),
        ]),
      ),
    );
  }

  Container buildCourseList(BuildContext context) {
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

  TextButton addButton(BuildContext context, List courseList) {
    final DatabaseService _dbService = DatabaseService();
    TextEditingController _controller = TextEditingController();
    RegExp regExp = RegExp(r'^[A-Z]{3}[0-9]{3}$');
    final _formkey = GlobalKey<FormState>();
    return TextButton.icon(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  clipBehavior: Clip.hardEdge,
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Form(
                        key: _formkey,
                        child: TextFormField(
                            controller: _controller,
                            textCapitalization: TextCapitalization.characters,
                            maxLength: 6,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            validator: (value) {
                              if (!regExp.hasMatch(value!)) {
                                return 'Enter a valid course code';
                              } else if (courseList.contains(value)) {
                                return 'Already exists';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 1.0,
                              )),
                              hintText: 'Enter Course Code',
                            )),
                      ),
                      verticalSpace(10),
                      ElevatedButton(
                          child: const Text('Add'),
                          style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).primaryColor),
                          onPressed: () async {
                            if (_formkey.currentState!.validate()) {
                              _dbService.addNewCourse(_controller.text);
                              Navigator.pop(context);
                            }
                          })
                    ],
                  ),
                );
              });
        },
        icon: const Icon(
          Icons.add,
        ),
        label: const Text(
          'ADD COURSE',
        ));
  }
}
