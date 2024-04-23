import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_exam_student_app/class.dart';
import 'package:image_picker/image_picker.dart';

class StudentDetails extends StatefulWidget {
  final StudentData student;
  final Function(StudentData) onUpdate;
  final Function() onDelete;

  const StudentDetails({
    Key? key,
    required this.student,
    required this.onUpdate,
    required this.onDelete,
  }) : super(key: key);

  @override
  _StudentDetailsState createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  TextEditingController nameController = TextEditingController();
  TextEditingController grIdController = TextEditingController();
  TextEditingController stdController = TextEditingController();
  TextEditingController divisionController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  File? _image;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.student.name;
    grIdController.text = widget.student.grId;
    stdController.text = widget.student.std;
    divisionController.text = widget.student.division;
    contactController.text = widget.student.contact;
    _image = widget.student.image;
  }

  Future<void> _getImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Student Details",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
            child: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.white,)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _image != null ? FileImage(_image!) : null,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _getImage(ImageSource.gallery),
                    icon: Icon(Icons.photo_library),
                    label: Text('Change from Gallery'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => _getImage(ImageSource.camera),
                    icon: Icon(Icons.camera_alt),
                    label: Text('Take a Photo'),
                  ),
                ],
              ),
              SizedBox(height: 20),
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
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: updateStudent,
                    child: Text('Update'),
                  ),
                  ElevatedButton(
                    onPressed: deleteStudent,
                    child: Text('Delete'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateStudent() {
    StudentData updatedStudent = StudentData(
      image: _image ?? widget.student.image,
      name: nameController.text,
      grId: grIdController.text,
      std: stdController.text,
      division: divisionController.text,
      contact: contactController.text,
    );

    widget.onUpdate(updatedStudent);
    Navigator.of(context).pop();
  }

  void deleteStudent() {
    widget.onDelete();
    Navigator.of(context).pop();
  }
}
