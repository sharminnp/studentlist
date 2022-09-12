import 'dart:io';

import 'package:flutter/material.dart';
import 'package:students_list/model/data_model.dart';

class ViewStudentDetails extends StatelessWidget {
  studentmodel student;
  ViewStudentDetails({Key? key, required this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            CircleAvatar(
              radius: 60,
              backgroundImage: FileImage(File(student.image)),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Colors.deepPurple,
              ),
              child: Text(
                "Name : ${student.name}",
                style: const TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Colors.deepPurple),
                child: Text(
                  "Age:${student.age}",
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Colors.deepPurple),
                child: Text(
                  "Place:${student.place}",
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(const Radius.circular(30)),
                    color: Colors.deepPurple),
                child: Text(
                  "Adhar:${student.adhar}",
                  style: const TextStyle(fontSize: 30, color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }
}
