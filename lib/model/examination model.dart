import 'package:flutter/material.dart';

// class examinationModel {
//   final String? name;
//   final String? date;
//
//   examinationModel({ @required this.name,@required this.date});
// }

class ExaminModel {
  String? id;
  String? Date;
  String? DoctorReport;
  String? TechnicianReport;
  String? examinationName;
  String? modelReport;
  String? patientName;
  String? examinationImage;

  ExaminModel(
      {this.Date,
        this.DoctorReport,
        this.TechnicianReport,
        this.examinationName,
        this.modelReport,
        this.patientName,
        this.id,
        this.examinationImage});

  Map<String, dynamic> toFirebase() {
    return {
      "Date": Date,
      "DoctorReport": DoctorReport,
      "TechnicianReport": TechnicianReport,
      "examinationName": examinationName,
      "modelReport": modelReport,
      "patientName": patientName,
      "id": id,
      "examinationImage": examinationImage,
    };
  }

  factory ExaminModel.fromFirebase(map) {
    return ExaminModel(
      Date: map['Date'],
      DoctorReport: map['DoctorReport'],
      TechnicianReport: map['TechnicianReport'],
      examinationName: map['examinationName'],
      modelReport: map['modelReport'],
      patientName: map['patientName'],
      id: map['id'],
      examinationImage: map['examinationImage'],
    );
  }
}

class DoctorModel {
  String? uid;
  String? DoctorName;
  String? DoctorImage;
  int? selectedAvatar;

  DoctorModel({
    this.DoctorName,
    this.DoctorImage,
    this.uid,
    this.selectedAvatar,
  });

  // Map<String, dynamic> toFirebase() {
  //   return {
  //     "DoctorName": DoctorName,
  //     "DoctorImage": DoctorImage,
  //     "uid": uid,
  //   };
  // }

  factory DoctorModel.fromFirebase(map) {
    print("in doctor model is ${map['first name']} ${map['last name']}");
    return DoctorModel(
      DoctorName: ("${map['first name']} ${map['last name']}"),
      DoctorImage: map['DoctorImage'],
      uid: map['uid'],
      selectedAvatar: map['selected_avatar'],
    );
  }
}
