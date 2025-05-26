import 'package:flutter/material.dart';

class doctorReport_patient extends StatelessWidget {
  String DoctorReport = "";

  doctorReport_patient({Key? key, required this.DoctorReport})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
              SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                      border: Border.all(style: BorderStyle.solid)),
                  child: Column(
                    children: [
                      Text("\n$DoctorReport\n",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Color.fromRGBO(34, 146, 208, 1))),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
