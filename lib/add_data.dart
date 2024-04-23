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
  TextEditingController divisionController = TextEditingController();

  String? grIdError;
  String? nameError;
  String? stdError;
  String? divisionError;
  String? contactError;

  void saveData() {
    if (grIdController.text.isEmpty) {
      setState(() {
        grIdError = 'Please input a GR-ID';
      });
    } else {
      setState(() {
        grIdError = null;
      });
    }

    if (nameController.text.isEmpty) {
      setState(() {
        nameError = 'Please input a Name';
      });
    } else {
      setState(() {
        nameError = null;
      });
    }

    if (stdController.text.isEmpty) {
      setState(() {
        stdError = 'Please input a Std';
      });
    } else {
      setState(() {
        stdError = null;
      });
    }

    if (divisionController.text.isEmpty) {
      setState(() {
        divisionError = 'Please input a Division';
      });
    } else {
      setState(() {
        divisionError = null;
      });
    }

    if (contactController.text.isEmpty) {
      setState(() {
        contactError = 'Please input a Contact';
      });
    } else {
      setState(() {
        contactError = null;
      });
    }

    if (image == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Image Required"),
            content: Text("Please add an image of the student."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    } else if (grIdError == null &&
        nameError == null &&
        stdError == null &&
        divisionError == null &&
        contactError == null) {
      StudentData studentData = StudentData(
        grId: grIdController.text,
        name: nameController.text,
        std: stdController.text,
        division: divisionController.text,
        contact: contactController.text,
        image: image!,
      );

      Navigator.pop(context, studentData);
    }
  }

  Future<void> getImage(ImageSource source) async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: source);
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
          "Add Student Data",
          style: TextStyle(color: Colors.white),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
          ),
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
                ElevatedButton(
                  onPressed: () => getImage(ImageSource.camera),
                  child: Row(
                    children: [
                      Icon(Icons.ac_unit_sharp),
                      Text("Take Photo"),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => getImage(ImageSource.gallery),
                  child: Row(
                    children: [
                      Icon(Icons.photo_library),
                      Text("choose from Gallery"),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: grIdController,
              decoration: InputDecoration(
                labelText: 'Enter GR-ID of Student',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.input),
                errorText: grIdError,
                errorStyle: TextStyle(color: Colors.red),
              ),
              onChanged: (_) {
                setState(() {
                  grIdError = grIdController.text.isEmpty ? 'Please input a value' : null;
                });
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Enter Name of Student',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.input),
                errorText: nameError,
                errorStyle: TextStyle(color: Colors.red),
              ),
              onChanged: (_) {
                setState(() {
                  nameError = nameController.text.isEmpty ? 'Please input a value' : null;
                });
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: stdController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Std of Student',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.input),
                errorText: stdError,
                errorStyle: TextStyle(color: Colors.red),
              ),
              onChanged: (_) {
                setState(() {
                  stdError = stdController.text.isEmpty ? 'Please input a value' : null;
                });
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: divisionController,
              decoration: InputDecoration(
                labelText: 'Enter Division of Student',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.input),
                errorText: divisionError,
                errorStyle: TextStyle(color: Colors.red),
              ),
              onChanged: (_) {
                setState(() {
                  divisionError = divisionController.text.isEmpty ? 'Please input a value' : null;
                });
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: contactController,
              decoration: InputDecoration(
                labelText: 'Enter Contact of Student',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.input),
                errorText: contactError,
                errorStyle: TextStyle(color: Colors.red),
              ),
              onChanged: (_) {
                setState(() {
                  contactError = contactController.text.isEmpty ? 'Please input a value' : null;
                });
              },
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 170,top: 15),
                  child: ElevatedButton(
                    onPressed: saveData,
                    child: Text("Save"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
