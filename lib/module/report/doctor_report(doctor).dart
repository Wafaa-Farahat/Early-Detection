import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../model/examination model.dart';
import '../home/Home.dart';
import '../my examination/examination_page.dart';

ExaminModel SelectedExamination = ExaminModel();

class doctorReport_doctor extends StatefulWidget {
  doctorReport_doctor(
      selectedExamination, {
        Key? key,
      }) {
    SelectedExamination = selectedExamination;
  }

  @override
  State<doctorReport_doctor> createState() => _doctorReportState();
}

class _doctorReportState extends State<doctorReport_doctor> {
  var report = TextEditingController(text: SelectedExamination.DoctorReport);

  bool write = false;
  updateData() async {
    print("id iz ${SelectedExamination.id}");
    CollectionReference userref =
    FirebaseFirestore.instance.collection("Examination");
    userref.doc(SelectedExamination.id).update({'DoctorReport': report.text});
    // set(userInfo);
  }

  @override
  Widget build(BuildContext context) {
    print("in report id iz ${SelectedExamination.id}");

    return Scaffold(
      appBar: AppBar(
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Text("Doctor's report",
                  style: TextStyle(
                      color: Color.fromRGBO(0, 129, 201, 1), fontSize: 35)),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(20),
                child: TextFormField(
                  maxLines: 30,
                  minLines: 10,
                  keyboardType: TextInputType.text,
                  controller: report,
                  onFieldSubmitted: (String value) {
                    print(value);
                    // setState(() {
                    //   write = false;
                    // });
                  },
                  enabled: write,
                  decoration: InputDecoration(
                    hintText: '${SelectedExamination.DoctorReport}',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Doctor report must not be empty ';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                      child: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color.fromRGBO(34, 146, 208, 1)),
                          child: Text(
                            "write report",
                            style: TextStyle(color: Colors.white),
                          )),
                      onPressed: () {
                        setState(() {
                          write = true;
                        });
                      }),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        updateData();
                        SelectedExamination.DoctorReport = report.text;
                        write = false;
                      });
                    },
                    icon: Icon(
                      Icons.send,
                      color: Color.fromRGBO(34, 146, 208, 1),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
