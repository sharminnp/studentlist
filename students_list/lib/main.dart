import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:students_list/db/functions/db_functions.dart';
import 'package:students_list/model/data_model.dart';
import 'package:students_list/screens/home/screen_home.dart';
import 'package:students_list/screens/home/student_list.dart';
import 'package:students_list/screens/home/widgets/list_student_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(studentmodelAdapter().typeId)) {
    Hive.registerAdapter(studentmodelAdapter());
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.purpleAccent, primarySwatch: Colors.deepPurple),
      home: StudentDatabase(),
    );
  }
}
