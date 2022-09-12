import 'dart:io';

import 'package:flutter/material.dart';

import 'package:students_list/db/functions/db_functions.dart';
import 'package:students_list/model/data_model.dart';
import 'package:students_list/screens/edit_list.dart';
import 'package:students_list/screens/view_student_details.dart';

class ListStudentWidget extends StatefulWidget {
  const ListStudentWidget({Key? key}) : super(key: key);

  @override
  State<ListStudentWidget> createState() => _ListStudentWidgetState();
}

class _ListStudentWidgetState extends State<ListStudentWidget> {
  @override
  Widget build(BuildContext context) {
    getAllstudents();

    return ValueListenableBuilder(
        valueListenable: studentListNotifier,
        builder:
            (BuildContext ctx, List<studentmodel> studentList, Widget? child) {
          return ListView.separated(
              itemBuilder: (context, index) {
                final data = studentList[index];
                return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: FileImage(File(data.image)),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewStudentDetails(
                            student: data,
                          ),
                        ),
                      );
                    },
                    title: Text(data.name),
                    subtitle: Text(data.age),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                            onPressed: () {
                              if (data.key != null) {
                                deleteStudentAlert(context, data.key);
                                print("worked");
                              } else {
                                print('student id is null.unable to delete');
                              }
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.deepPurple,
                            )),
                        IconButton(
                            // onPressed: () => Navigator.pushReplacement(
                            //       context,
                            //       MaterialPageRoute(
                            //         builder: (BuildContext context) => editlist(
                            //             EditName: data.name,
                            //             EditAge: data.age,
                            //             EditPlace: data.place,
                            //             EditAdhar: data.adhar,
                            //             listkey: data.key),
                            //       ),
                            //     ),
                            onPressed: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        editlist(student: data),
                                  ),
                                ),
                            icon: Icon(
                              Icons.edit,
                              color: Colors.deepPurple,
                            ))
                      ],
                    )

                    // IconButton(
                    //     onPressed: () {
                    //       if (data.key != null) {
                    //         deleteStudent(data.key);
                    //         print("worked");
                    //       } else {
                    //         print('student id is null.unable to delete');
                    //       }
                    //     },
                    //     icon: Icon(
                    //       Icons.delete,
                    //       color: Colors.deepPurple,
                    //     )),
                    );
              },
              separatorBuilder: ((context, index) {
                return const Divider();
              }),
              itemCount: studentList.length);
        });
  }

  void deleteStudentAlert(BuildContext context, key) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text('Confirm Deletion'),
            content: Text('Do you want to delete'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: Text('No'),
              ),
              TextButton(
                onPressed: () {
                  deleteStudent(key);
                  Navigator.pop(ctx);
                },
                child: Text('Yes'),
              )
            ],
          );
        });
  }
}
