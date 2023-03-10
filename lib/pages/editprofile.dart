import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/services/auth.dart';
import 'package:project/services/database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/components/auth_screens/loadingwidget.dart';
import 'package:project/services/utils.dart';

class Editprofile extends StatefulWidget {
  const Editprofile({Key? key}) : super(key: key);

  @override
  _EditprofileState createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  late TextEditingController controller;
  late DatabaseService _dbService;
  late File? image;
  final imagePicker = ImagePicker();
  String? photoURL;
  String name = '';
  int count = 0;
  bool loading = false;

// function to select image
  Future imagePickerMethod() async {
    final pick = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pick != null) {
        image = File(pick.path);
      } else {
        showSnackBar(context, 'No file selected');
      }
    });
  }

  //function to upload image to firestore

  @override
  void initState() {
    _dbService = DatabaseService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String username = '';
    return loading
        ? const LoadingPage(
            isLogin: false,
          )
        : Scaffold(
            appBar: AppBar(
              actions: [
                TextButton.icon(
                  onPressed: () async {
                    setState(() {
                      loading = true;
                    });
                    if (username != '') {
                      await user!.updateDisplayName(username);
                      setState(() {
                        loading = false;
                      });
                    }
                    if (image != null) {
                      await _dbService.uploadImage(image, photoURL);
                      setState(() {
                        loading = false;
                      });
                    }

                    showSnackBar(context, 'Profile updated successfully');
                  },
                  icon: const Icon(Icons.done),
                  label: const Text('SAVE'),
                  style: Theme.of(context).textButtonTheme.style?.copyWith(
                      foregroundColor: MaterialStateProperty.all(Colors.white)),
                )
              ],
              leading: CloseButton(onPressed: () {
                Navigator.of(context).pop();
              }),
            ),
            body: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.fromLTRB(15, 30, 0, 0),
                child: Consumer<User?>(builder: (context, value, child) {
                  return Column(
                    children: [
                      TextFormField(
                        initialValue: value?.displayName,
                        onChanged: (value) => username = value,
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: name,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor)),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ),
                      Center(
                        heightFactor: 1.3,
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                          Container(
                              height: 300,
                              width: 300,
                              decoration: const BoxDecoration(),
                              child: CachedNetworkImage(
                                  imageUrl: user?.photoURL ?? '')),
                          verticalSpace(15),
                          ElevatedButton.icon(
                            icon: const Icon(Icons.add_a_photo),
                            label: const Text('Change profile picture'),
                            onPressed: () {
                              imagePickerMethod();
                            },
                          ),
                        ]),
                      ),
                    ],
                  );
                }),
              ),
            ),
          );
  }
}
