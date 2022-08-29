import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:students/getx%20/mycontroller.dart';
import 'package:students/screen/db/functions/db_funtions.dart';
import 'package:students/screen/db/models/dart_models.dart';
import 'package:students/screen/home_screen.dart';
import 'package:image_picker/image_picker.dart';

class Submitscreen extends StatefulWidget {
  Submitscreen({Key? key}) : super(key: key);

  @override
  State<Submitscreen> createState() => SubmitscreenState();
}

class SubmitscreenState extends State<Submitscreen> {
  String image = '';

  final _nameController = TextEditingController();

  final _ageController = TextEditingController();

  final _guardianController = TextEditingController();

  final _numberController = TextEditingController();

  MyController myController=Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 255, 248, 253),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 60, right: 60, bottom: 1, top: 10),
              child: image.isNotEmpty
                  ? CircleAvatar(
                    
                      backgroundImage: MemoryImage(
                        
                        Base64Decoder().convert(image),
                      ),
                      maxRadius: 70,
                    )
                  : CircleAvatar(
                      maxRadius: 90,
                      backgroundColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {
                                  addimage();
                                },
                                icon: const Icon(
                                  Icons.person,
                                  size: 90,
                                  color: Colors.black,
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            IconButton(
                                onPressed: () {
                                  addimage();
                                },
                                icon: Icon(
                                  Icons.add,
                                  color: Color.fromARGB(255, 66, 66, 66),
                                ))
                          ],
                        ),
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30, left: 20, top: 10),
              child: Container(
                child: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      hintText: 'enter your name',
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                      ),
                      filled: true,
                      fillColor: Colors.black,
                      contentPadding: EdgeInsets.all(10.0)),
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.text,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30, left: 20, top: 10),
              child: Container(
                child: TextField(
                  controller: _ageController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        )),
                    hintText: 'age',
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                    ),
                    filled: true,
                    fillColor: Colors.black,
                    contentPadding: EdgeInsets.all(10.0),
                  ),
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30, left: 20, top: 10),
              child: TextField(
                controller: _guardianController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  hintText: 'guardian name',
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
                  filled: true,
                  fillColor: Colors.black,
                  contentPadding: EdgeInsets.all(10.0),
                ),
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.text,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30, left: 20, top: 10),
              child: Container(
                child: TextField(
                  controller: _numberController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    hintText: 'mobile number',
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                    ),
                    filled: true,
                    fillColor: Colors.black,
                    contentPadding: EdgeInsets.all(10.0),
                  ),
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30, left: 20, top: 10),
              child: SizedBox(
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  onPressed: () {
                    onAddstudentButtonClicked();
                  },
                  child: const Text(
                    'S U B M I T',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'colonnamt',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  footer() {
    return Container(
      height: 70,
      color: Color.fromARGB(255, 80, 4, 65),
    );
  }

  Future<void> onAddstudentButtonClicked() async {
    final _name = _nameController.text.trim();
    final _age = _ageController.text.trim();
    final _number = _numberController.text.trim();
    final _guardion = _guardianController.text.trim();

    if (_name.isEmpty ||
        _age.isEmpty ||
        _number.isEmpty ||
        _guardion.isEmpty ||
        image.isEmpty) {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              backgroundColor: Colors.black,
              title: const Text(
                'Error',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              content: const Text(
                'Field is requid',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'colonnamt',
                  fontSize: 20,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Dismiss',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                )
              ],
            );
          });
      return;
    }

    final _student = StudentModel(
        name: _name,
        age: _age,
        guardion: _guardion,
        number: _number,
        image: image);
        
   myController.addstudent(_student);
    Navigator.pop(context);
  }

  addimage() async {
    final pickimage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickimage == null) {
      return;
    }
    final bytes = File(pickimage.path).readAsBytesSync();
    setState(() {
      image = base64Encode(bytes);
    });
    return image;
  }
}
