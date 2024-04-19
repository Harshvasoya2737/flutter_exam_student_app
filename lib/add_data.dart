import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_exam_student_app/class.dart';

class AddData extends StatefulWidget {
  const AddData({Key? key}) : super(key: key);

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  File? image;
  TextEditingController grIdController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController stdController = TextEditingController();
  TextEditingController contactController = TextEditingController();

  Future<void> _getImageFromCamera(ImageSource source) async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    }
  }

  void _resetData() {
    setState(() {
      image = null;
      grIdController.clear();
      nameController.clear();
      stdController.clear();
      contactController.clear();
    });
  }
  void _saveData() {
    if (image != null) {
      StudentData studentData = StudentData(
        grId: grIdController.text,
        name: nameController.text,
        std: stdController.text,
        contact: contactController.text,
        image: image!,
      );

      Navigator.pop(context, studentData);
    } else {
      // Handle case where no image is selected
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Please select an image."),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        title: Text(
          "Add Student Data",
          style: TextStyle(color: Colors.white),
        ),
        leading: Icon(
          Icons.arrow_back_ios_new_outlined,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            if (image != null)
              Image.file(
                image!,
                height: 150,
                width: 150,
                fit: BoxFit.cover,
              )
            else
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: Icon(Icons.camera_alt, size: 50),
              ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _getImageFromCamera(ImageSource.camera),
                  icon: Icon(Icons.camera),
                  label: Text("Take Photo"),
                ),
                SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: () => _getImageFromCamera(ImageSource.gallery),
                  icon: Icon(Icons.photo_library),
                  label: Text("Choose from Gallery"),
                ),
              ],
            ),
            SizedBox(height: 20),
            TextField(
              controller: grIdController,
              decoration: InputDecoration(
                labelText: 'Enter GR-ID of Student',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.input),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Enter Name of Student',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.input),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: stdController,
              decoration: InputDecoration(
                labelText: 'Enter Std of Student',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.input),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: contactController,
              decoration: InputDecoration(
                labelText: 'Enter Contact of Student',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.input),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 100),
                  child: ElevatedButton(
                    onPressed: _saveData,
                    child: Text("Save"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: _resetData,
                    child: Text("Reset"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    grIdController.dispose();
    nameController.dispose();
    stdController.dispose();
    contactController.dispose();
    super.dispose();
  }
}
