import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../services/database.dart';
import '../../services/utils.dart';

class AddCourseButton extends StatelessWidget {
  final List courseList;
  const AddCourseButton({
    Key? key,
    required this.courseList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
