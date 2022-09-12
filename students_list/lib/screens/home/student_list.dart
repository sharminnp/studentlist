import 'package:flutter/material.dart';
import 'package:students_list/screens/home/screen_home.dart';
import 'package:students_list/screens/home/widgets/list_student_widget.dart';
import 'package:students_list/screens/search_student.dart';

class StudentDatabase extends StatefulWidget {
  const StudentDatabase({Key? key}) : super(key: key);

  @override
  State<StudentDatabase> createState() => _StudentDatabaseState();
}

class _StudentDatabaseState extends State<StudentDatabase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Students"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => searchstudent(),
                    ),
                  ),
              icon: Icon(
                Icons.search,
                size: 35,
              )),
        ],
      ),
      body: SafeArea(child: ListStudentWidget()),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              ),
          icon: Icon(Icons.person_add_alt_rounded),
          label: Text('Add')),
    );
  }
}
