import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:students_list/db/functions/db_functions.dart';
import 'package:students_list/model/data_model.dart';
import 'package:students_list/screens/home/student_list.dart';

class editlist extends StatefulWidget {
  editlist({Key? key, required this.student}) : super(key: key);

  studentmodel student;

  @override
  State<editlist> createState() => _editlistState();
}

// final _mycontroller = TextEditingController();

class _editlistState extends State<editlist> {
  String? image;
  Future<void> pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) {
      return;
    }
    setState(() {
      this.image = pickedImage.path;
    });
  }

  TextEditingController? _nameController;
  TextEditingController? _ageController;
  TextEditingController? _placeController;
  TextEditingController? _adharController;

  @override
  void initState() {
    image = widget.student.image;
    _nameController = TextEditingController(text: widget.student.name);
    _ageController = TextEditingController(text: widget.student.age);
    _placeController = TextEditingController(text: widget.student.place);
    _adharController = TextEditingController(text: widget.student.adhar);

    super.initState();
  }

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Students'),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const StudentDatabase(),
                )),
            icon: const Icon(
              Icons.home,
              size: 40,
            )),
      ),

      //   leading: IconButton(onPressed: ()=>Navigator.of(context)
      //   .push(MaterialPageRoute(builder:(context)=>StudentDatabase(),),
      //  icon   : Icon(Icons.home)),),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: _formkey,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Text(widget.listkey.toString()),
                Stack(children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: (image == null)
                        ? FileImage(File(widget.student.image))
                        : FileImage(File(image!)),

                    // backgroundImage: FileImage(File()),
                  ),
                  Positioned(
                    top: 60,
                    left: 70,
                    child: IconButton(
                      onPressed: () {
                        pickImage();
                      },
                      icon: const Icon(
                        Icons.arrow_circle_up,
                        size: 60,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                ]),
                SizedBox(
                  height: 30,
                ),
                // Image.asset("assest/image/images.png"),
                // SizedBox(
                //   height: 5,
                // ),

                // typeField(
                //   controller: _nameController,
                //   labeltext: widget.EditName,
                // ),
                // const SizedBox(
                //   height: 15,
                // ),
                // typeField(
                //   controller: _ageController,
                //   labeltext: widget.EditAge,
                // ),
                // SizedBox(
                //   height: 15,
                // ),
                // typeField(
                //   controller: _placeController,
                //   labeltext: widget.EditPlace,
                // ),

                // SizedBox(
                //   height: 15,
                // ),
                // typeField(
                //     controller: _adharController, labeltext: widget.EditAdhar),
                // TextField(
                //   onChanged:editlist(EditName:, EditAge: EditAge, EditPlace: EditPlace, EditAdhar: EditAdhar);
                // ),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40.0))),
                    hintText: "Name",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "The Name is empty";
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _ageController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40.0))),
                    hintText: "Age",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "The Age is empty";
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _placeController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40.0))),
                    hintText: "Place",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "The Place is empty";
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _adharController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40.0))),
                    hintText: "Adhar",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "The Adhar is empty";
                    }
                  },
                ),

                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton.icon(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        editStudentAlert(context);
                      }
                    },
                    // style: ButtonStyle(backgroundColor: Colors.),
                    icon: const Icon(Icons.save),
                    label: const Text('Save')),
              ],
            ),
          ),
        ),
      ),
    );
  }

//
  // Widget typeField({
  //   required TextEditingController controller,
  //   required String labeltext,
  // }) {
  //   return TextFormField(
  //     controller: TextEditingController(text: labeltext),
  //     decoration: InputDecoration(
  //       border: const OutlineInputBorder(
  //           borderRadius: BorderRadius.all(Radius.circular(40.0))),
  //       // hintText: labeltext,
  //       // labelText: controller.text,
  //     ),
  //   );
  // }

  Future<void> onEditListButtonClicked() async {
    final _name = _nameController!.text.trim();
    final _age = _ageController!.text.trim();
    final _place = _placeController!.text.trim();
    final _adhar = _adharController!.text.trim();
    if (_name.isEmpty || _age.isEmpty || _place.isEmpty || _adhar.isEmpty) {
      return;
    }

    final _edit = studentmodel(
        name: _name, age: _age, place: _place, adhar: _adhar, image: image!);

    final studentDB = await Hive.openBox<studentmodel>('student_db');
    studentListNotifier.notifyListeners();

    await studentDB.put(widget.student.key, _edit);
    getAllstudents();
    //editstudent(widget.listkey, _edit);
    print(_edit.name);
    // getAllstudents();
    // (_edit);
  }

  void editStudentAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text('Alert'),
            content: Text('Student edited successfuly'),
            actions: [
              TextButton(
                onPressed: () {
                  onEditListButtonClicked();
                  Navigator.pop(ctx);
                },
                child: Text('Ok'),
              )
            ],
          );
        });
  }
}
