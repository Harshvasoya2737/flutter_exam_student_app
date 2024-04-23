import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_exam_student_app/class.dart';

class StudentDetails extends StatefulWidget {
  final StudentData student;

  const StudentDetails({Key? key, required this.student})
      : super(key: key);

  @override
  State<StudentDetails> createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        title: Text(
          'Student Details',
          style: TextStyle(color: Colors.white),
        ),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.white,
            )),
      ),
      body: Stack(
        children: [
          Center(
            child: Container(
              height: 500,
              width: 400,
              decoration: BoxDecoration(color: Color(0xffF4F4F4), boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  spreadRadius: 5,
                  blurRadius: 20,
                )
              ]),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 150),
                child: CircleAvatar(
                  backgroundImage: FileImage(widget.student.image),
                  radius: 50,
                ),
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.all(8.0),
                height: 50,
                width: double.infinity,
                color: Colors.black12,
                child: Center(
                  child: Text(
                    'Name: ${widget.student.name}',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
                margin: EdgeInsets.all(8.0),
                height: 50,
                width: double.infinity,
                color: Colors.black12,
                child: Center(
                  child: Text(
                    'GR-ID: ${widget.student.grId}',
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
                margin: EdgeInsets.all(8.0),
                height: 50,
                width: double.infinity,
                color: Colors.black12,
                child: Center(
                  child: Text(
                    'Std: ${widget.student.std} ${widget.student.division}',
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
                margin: EdgeInsets.all(8.0),
                height: 50,
                width: double.infinity,
                color: Colors.black12,
                child: Center(
                  child: Text(
                    'Contact: ${widget.student.contact}',
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
