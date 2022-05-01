import 'package:flutter/material.dart';
import 'package:project/components/drawer.dart';

class Prioritee extends StatefulWidget {
  const Prioritee({Key? key}) : super(key: key);

  @override
  _PrioriteeState createState() => _PrioriteeState();
}

bool test = false;
bool ass = false;
bool tutorial = false;

class _PrioriteeState extends State<Prioritee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Set Priorities'),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20, left: 0),
          child: Column(
            children: [
              ListTile(
                leading: Checkbox(
                    value: test,
                    onChanged: (value) {
                      setState(() {
                        test = !test;
                      });
                    }),
                title: const Text('Test'),
              ),
              ListTile(
                leading: Checkbox(
                    value: ass,
                    onChanged: (value) {
                      setState(() {
                        ass = !ass;
                      });
                    }),
                title: const Text('Assignment'),
              ),
              ListTile(
                leading: Checkbox(
                    value: tutorial,
                    onChanged: (value) {
                      setState(() {
                        tutorial = !tutorial;
                      });
                    }),
                title: const Text('Tutorial'),
              ),
              verticalSpace(10),
              buildButton()
            ],
          ),
        ));
  }

  buildButton() {
    return Center(
      child: ElevatedButton(
        child: const Text('SAVE'),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
