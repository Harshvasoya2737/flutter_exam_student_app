import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_exam_student_app/class.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_exam_student_app/details.dart';

//Global list
List<StudentData> allStudentsList = [];

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
      body: SingleChildScrollView(
        child: Column(
          children: studentList.asMap().entries.map((entry) {
            final index = entry.key;
            final student = entry.value;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StudentDetails(student: student),
                    ),
                  );
                },
                child: Container(
                  height: 70,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await showImage(index);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundImage: FileImage(student.image),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            student.name,
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            'GR-ID: ${student.grId} | Std: ${student.std} ${student.division}',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            'Contact: ${student.contact}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          showEdit(index);
                        },
                        icon: Icon(Icons.edit, color: Colors.black),
                      ),
                      IconButton(
                        onPressed: () {
                          showDelete(index);
                        },
                        icon: Icon(Icons.delete, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.pushNamed(context, 'data');
          if (result is StudentData) {
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

  Future<void> showImage(int index) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Change Image"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () async {
                  await _getImageFromSource(index, ImageSource.gallery);
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.photo_library),
                label: Text('Choose from Gallery'),
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  await _getImageFromSource(index, ImageSource.camera);
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.camera_alt),
                label: Text('Take a Photo'),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _getImageFromSource(int index, ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        studentList[index].image = File(pickedImage.path);
      });
    }
  }

  void showEdit(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController nameController =
            TextEditingController(text: studentList[index].name);
        TextEditingController grIdController =
            TextEditingController(text: studentList[index].grId);
        TextEditingController stdController =
            TextEditingController(text: studentList[index].std);
        TextEditingController divisionController =
            TextEditingController(text: studentList[index].division);
        TextEditingController contactController =
            TextEditingController(text: studentList[index].contact);

        return AlertDialog(
          title: Text("Edit Student"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    await _getImageFromSource(index, ImageSource.gallery);
                  },
                  icon: Icon(Icons.photo_library),
                  label: Text('Add from Gallery'),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    await _getImageFromSource(index, ImageSource.camera);
                  },
                  icon: Icon(Icons.camera_alt),
                  label: Text('Take a Photo'),
                ),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: grIdController,
                  decoration: InputDecoration(labelText: 'GR-ID'),
                ),
                TextField(
                  controller: stdController,
                  decoration: InputDecoration(labelText: 'Std'),
                ),
                TextField(
                  controller: divisionController,
                  decoration: InputDecoration(labelText: 'Division'),
                ),
                TextField(
                  controller: contactController,
                  decoration: InputDecoration(labelText: 'Contact'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                StudentData editedStudent = StudentData(
                  image: studentList[index].image,
                  name: nameController.text,
                  grId: grIdController.text,
                  std: stdController.text,
                  division: divisionController.text,
                  contact: contactController.text,
                );

                setState(() {
                  studentList[index] = editedStudent;
                });

                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void showDelete(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Student"),
          content: Text("Are you sure you want to delete this student?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("No"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  studentList.removeAt(index);
                });
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Yes"),
            ),
          ],
        );
      },
    );
  }
}
