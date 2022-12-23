import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataModel {
  UserDataModel(
      {this.id = '',
      this.name = '',
      this.type,
      this.designation,
      this.gender,
      this.isJobStatusActive = false,
      this.employeeRef});

  String? id;
  String? name;
  String? type;
  String? designation;
  String? gender;
  bool? isJobStatusActive;
  DocumentReference? employeeRef;

  factory UserDataModel.fromDocumentSnapshot(DocumentSnapshot doc) =>
      UserDataModel(
          id: doc["id"],
          name: doc["name"],
          type: doc["type"],
          designation: doc["designation"],
          gender: doc["gender"],
          isJobStatusActive: doc["isJobStatusActive"],
          employeeRef: doc.reference);

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "type": type,
        "designation": designation,
        "gender": gender,
        "isJobStatusActive": isJobStatusActive,
      };
}
