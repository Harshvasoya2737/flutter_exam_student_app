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
  factory StudentData.fromJson(Map<String,dynamic> map){
    return StudentData(
      grId: map["grId"],
      name: map["name"],
      std: map["std"],
      division: map["division"],
      contact: map["contact"],
      image: map["image"],
    );
  }
}
