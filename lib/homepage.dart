import 'package:flutter/material.dart';
import 'package:flutter_exam_student_app/class.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<StudentData> studentList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Home Page",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
        itemCount: studentList.length,
        itemBuilder: (context, index) {
          StudentData student = studentList[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: FileImage(student.image),
              ),
              title: Text(student.name),
              subtitle: Text('GR-ID: ${student.grId} | Std: ${student.std}'),
              trailing: Text(student.contact),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.pushNamed(context, 'data');
          if (result != null && result is StudentData) {
            setState(() {
              studentList.add(result);
            });
          }
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
        shape: CircleBorder(),
      ),
    );
  }
}
