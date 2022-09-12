import 'package:flutter/cupertino.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:students_list/model/data_model.dart';

ValueNotifier<List<studentmodel>> studentListNotifier = ValueNotifier([]);
Future<void> addstudent(studentmodel value) async {
  // studentListNotifier.value.add(value);
  print(value.toString());

  final studentDB = await Hive.openBox<studentmodel>('student_db');
  await studentDB.add(value);

  studentListNotifier.value.add(value);
  studentListNotifier.notifyListeners();
}

Future<void> getAllstudents() async {
  final studentDB = await Hive.openBox<studentmodel>('student_db');
  studentListNotifier.value.clear();
  studentListNotifier.value.addAll(studentDB.values);
  studentListNotifier.notifyListeners();
}

Future<void> deleteStudent(int id) async {
  final studentDB = await Hive.openBox<studentmodel>('student_db');
  await studentDB.delete(id);
  getAllstudents();
// }
}

Future<void> editstudent(int key, studentmodel value) async {
  final studentDB = await Hive.openBox<studentmodel>('student_db');
  await studentDB.put(key, value);
  getAllstudents();
  // final _id = await studentDB.add(value);
  // value.id = _id;
  // studentListNotifier.value.add(value);
  // studentListNotifier.value.
  //studentListNotifier.notifyListeners();
}
