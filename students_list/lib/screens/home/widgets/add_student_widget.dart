import 'dart:io';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:students_list/db/functions/db_functions.dart';
import 'package:students_list/model/data_model.dart';

class AddStudentWidget extends StatefulWidget {
  const AddStudentWidget({Key? key}) : super(key: key);

  @override
  State<AddStudentWidget> createState() => _AddStudentWidgetState();
}

class _AddStudentWidgetState extends State<AddStudentWidget> {
  final _formkey = GlobalKey<FormState>();

  String? image;
  Future<void> addImage() async {
    final pickedimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      this.image = pickedimage!.path;
    });
  }

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _placeController = TextEditingController();
  final _adharController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formkey,
        child: ListView(
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 60,
              backgroundImage: (image != null)
                  ? FileImage(File(image!))
                  : AssetImage("assest/image/images.png") as ImageProvider,
            ),
            IconButton(
              onPressed: () {
                addImage();
              },
              icon: Icon(Icons.add_a_photo),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40.0))),
                hintText: "Name",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Name is empty";
                }
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _ageController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40.0))),
                hintText: "Age",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Age is empty";
                }
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _placeController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40.0))),
                hintText: "Place",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Place is empty";
                }
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _adharController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40.0))),
                hintText: "Adhar",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Adhar is empty";
                }
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    addStudentAlert(context);
                  }
                },
                child: Text("Add Student")),
          ],
        ),
      ),
    );
  }

  Future<void> addButtonClicked() async {
    final _name = _nameController.text;
    final _age = _ageController.text;
    final _place = _placeController.text;
    final _adhar = _adharController.text;
    if (_name.isEmpty || _age.isEmpty || _place.isEmpty || _adhar.isEmpty) {
      return;
    }
    final _student = studentmodel(
        name: _name, age: _age, place: _place, adhar: _adhar, image: image!);

    await addstudent(_student);
  }

  void addStudentAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text('Alert'),
            content: Text('Student added successfuly'),
            actions: [
              TextButton(
                onPressed: () {
                  addButtonClicked();
                  Navigator.pop(ctx);
                },
                child: Text('Ok'),
              )
            ],
          );
        });
  }
}
