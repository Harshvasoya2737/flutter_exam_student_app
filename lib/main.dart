import 'package:flutter/material.dart';
import 'package:flutter_exam_student_app/add_data.dart';
import 'package:flutter_exam_student_app/homepage.dart';
import 'package:flutter_exam_student_app/spalsh_screen.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatefulWidget {
  const Myapp({super.key});

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'splash_screen',
      routes: {
        "splash_screen": (context) => splashscreen(),
        "home": (context) => Homepage(),
        "data": (context) => AddData(),
      },
    );
  }
}
