import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Layout/search screen.dart';
import '../../model/examination model.dart';
import '../report/Technician_report.dart';
import '../report/doctor_report(doctor).dart';
import '../report/doctor_report(patient).dart';
import '../report/model_report.dart';
import 'examinations_menu_page.dart';


var examinationName;
var examinationImage;
var Date;
var patientName;
var technicianReport;
var DoctorReport;
var ModelReport;

ExaminModel selectedExamination = ExaminModel();

class ExaminationPage extends StatefulWidget {
  ExaminModel select = ExaminModel();
  ExaminationPage(this.select);
  @override
  State<ExaminationPage> createState() => _ExaminationPageState(this.select);
}

class _ExaminationPageState extends State<ExaminationPage> {
  _ExaminationPageState(ExaminModel select) {
    selectedExamination = select;
    patientName = selectedExamination.patientName;
    examinationImage = selectedExamination.examinationImage;
    examinationName = selectedExamination.examinationName;
    Date = selectedExamination.Date;
    technicianReport = selectedExamination.TechnicianReport;
    DoctorReport = selectedExamination.DoctorReport;
    ModelReport = selectedExamination.modelReport;
  }

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ExaminationsMenuPage()),
                );
              },
              icon: Icon(Icons.arrow_back_rounded)),
          backgroundColor: Color.fromRGBO(0, 129, 201, 1),
          elevation: 0,
          actions: [
            Container(
              padding: EdgeInsets.only(
                left: 3,
                bottom: 3,
              ),
              child: Row(
                children: [
                  Image(
                      image: AssetImage("images/home_logo.png"),
                      height: 100,
                      width: 150),
                ],
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
               bottom: 30
            ),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                top: 40,
                right: 10,
                left: 10,
              ),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "$examinationName",
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Image(
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.fitHeight,
                    image: NetworkImage("$examinationImage"),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 30,
                      ),
                      Column(
                        children: [
                          Text(
                            "$patientName",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            height: 2,
                            width: 100,
                            child: Divider(
                              color: Colors.black,
                              thickness: 2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  //Techician report
                  Container(
                    width: 200,
                    height: 50,
                    color: Colors.blue,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TechnicianReport(
                                technicianReport: technicianReport,
                              )),
                        );
                      },
                      child: Text(
                        "Techician report",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  //Model report
                  Container(
                    width: 200,
                    height: 50,
                    color: Colors.blue,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => modelReport(
                                ModelReport: ModelReport,
                              )),
                        );
                      },
                      child: Text(
                        "Model report",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  //Doctor report
                  Container(
                    width: 200,
                    height: 50,
                    color: Colors.blue,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => isPatient
                                ? doctorReport_patient(
                              DoctorReport: selectedExamination.DoctorReport!,
                            )
                                : doctorReport_doctor(
                              selectedExamination,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        "Doctor report",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}


// getPref() async {
//   SharedPreferences preferences = await SharedPreferences.getInstance();
//   examinationName = preferences.getString("examinationName");
//   examinationImage = preferences.getString("examinationImage");
//   print(examinationName);
//   print(examinationImage);
// }

// Stream<List<ExaminModel>> readexamin() => FirebaseFirestore.instance
//     .collection("Examination")
//     .where("examinationName", isEqualTo: examinationName)
//     .where("examinationImage", isEqualTo: examinationImage)
//     .snapshots()
//     .map((snapshot) =>
//         snapshot.docs.map((e) => ExaminModel.fromFirebase(e.data())).toList());
