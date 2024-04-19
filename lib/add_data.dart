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

  Future<void> getImage(ImageSource source) async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    }
  }

  void _saveData() {
    if (image != null) {
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
                ElevatedButton( onPressed: () => getImage(ImageSource.camera),
                    child: Row(
                      children: [
                        Icon(Icons.ac_unit_sharp),
                        Text("Take Photo"),
                      ],
                    )),
                SizedBox(width: 10),
                ElevatedButton.icon(

                  label: Text("Choose from Gallery"),
                ),
              ],
            ),
            SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.number,
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
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Std of Student',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.input),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: divisionController,
              decoration: InputDecoration(
                labelText: 'Enter Divsion of Student',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.input),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.number,
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
                  padding: const EdgeInsets.only(left: 140),
                  child: ElevatedButton(
                    onPressed: _saveData,
                    child: Text("Save"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      // onPressed: () => getImage(ImageSource.camera),
      // onPressed: () => getImage(ImageSource.gallery),
      // icon: Icon(Icons.photo_library),
    );
  }
}
