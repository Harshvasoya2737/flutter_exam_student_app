import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_exam_student_app/class.dart';
import 'package:image_picker/image_picker.dart';

class update_data extends StatefulWidget {
  final StudentData student;

  const update_data({Key? key, required this.student}) : super(key: key);

  @override
  State<update_data> createState() => _update_dataState();
}

class _update_dataState extends State<update_data> {
  TextEditingController nameController = TextEditingController();
  TextEditingController grIdController = TextEditingController();
  TextEditingController stdController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController divisionController = TextEditingController();
  File? image;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.student.name;
    grIdController.text = widget.student.grId;
    stdController.text = widget.student.std;
    contactController.text = widget.student.contact;
    divisionController.text = widget.student.contact;
    image = widget.student.image;
  }

  Future<void> getImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    }
  }

  Future<void> getImages() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        title: Text(
          "Edit Student",
          style: TextStyle(color: Colors.white),
        ),
        leading: Icon(Icons.arrow_back_ios_new_outlined),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: image != null ? FileImage(image!) : null,
                    radius: 30,
                  ),
                ],
              ),
              SizedBox(width: 16),
              ElevatedButton(onPressed: getImage, child: Text("Take Photo")),
              SizedBox(width: 16),
              ElevatedButton(
                  onPressed: getImages, child: Text("choose from Gallery")),
              SizedBox(height: 16),
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: grIdController,
                decoration: InputDecoration(labelText: 'GR-ID'),
              ),
              TextField(
                controller: stdController,
                decoration: InputDecoration(labelText: 'Std'),
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: contactController,
                decoration: InputDecoration(labelText: 'Contact'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  StudentData editedStudent = StudentData(
                    name: nameController.text,
                    grId: grIdController.text,
                    std: stdController.text,
                    contact: contactController.text,
                    image: image ?? widget.student.image,
                    division: widget.student.division,
                  );

                  Navigator.pop(context, editedStudent);
                },
                child: Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
