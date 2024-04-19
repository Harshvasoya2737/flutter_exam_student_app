import 'dart:io';

class StudentData {
  String grId;
  String name;
  String std;
  String division;
  String contact;
  File image;

  StudentData({
    required this.grId,
    required this.name,
    required this.std,
    required this.division,
    required this.contact,
    required this.image,
  });
}
