import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:students_list/model/data_model.dart';

import 'package:students_list/screens/home/student_list.dart';

class searchstudent extends StatefulWidget {
  const searchstudent({Key? key}) : super(key: key);

  @override
  State<searchstudent> createState() => _searchstudentState();
}

class _searchstudentState extends State<searchstudent> {
  String? image;
  Future<void> pickedImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) {
      return;
    }
    setState(() {
      this.image = pickedImage.path;
    });
  }

  List<studentmodel> studentList =
      Hive.box<studentmodel>('student_db').values.toList();
  late List<studentmodel> displayStudent = List<studentmodel>.from(studentList);

  void updateList(String value) {
    setState(() {
      displayStudent = studentList
          .where((element) =>
              element.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Students"),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => StudentDatabase())),
            icon: Icon(
              Icons.home,
              size: 40,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          TextFormField(
            onChanged: (value) {
              updateList(value);
            },
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(40)),
              ),
              hintText: "Search here",
            ),
          ),
          Expanded(
            child: (displayStudent.isNotEmpty)
                ? ListView.separated(
                    itemBuilder: (context, index) => ListTile(
                          leading: CircleAvatar(
                              backgroundImage: FileImage(
                            File(displayStudent[index].image),
                          )),
                          title: Text(displayStudent[index].name),
                        ),
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: displayStudent.length)
                : Center(child: Text("The name is not found")),
          )
        ]),
      ),
    );
  }
}
