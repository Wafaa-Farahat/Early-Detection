import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Layout/Home Layout.dart';
import '../../model/examination model.dart';
import '../home/Home.dart';
import 'examination_page.dart';

class ExaminationsMenuPage extends StatefulWidget {
  @override
  State<ExaminationsMenuPage> createState() => _ExaminationsMenuPageState();
}

class _ExaminationsMenuPageState extends State<ExaminationsMenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeLayout()),
                );
              },
              icon: Icon(Icons.arrow_back_rounded)),
          // title: Text('Home'),
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
        body: StreamBuilder<List<ExaminModel?>>(
          stream: readexamin(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("invalid");
            } else if (snapshot.hasData) {
              final Examins = snapshot.data!;
              print("data of examins iz $Examins");
              Examins.removeWhere(
                (element) => element is Null,
              );
              print("data of examins iz $Examins");
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            "My Examinations",
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: Container(
                      alignment: AlignmentDirectional.center,
                      child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: Examins.length,
                        itemBuilder: (context, index) => Container(
                          color: Colors.blue,
                          child: GestureDetector(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: CachedNetworkImage(
                                    height: 100,
                                    fit: BoxFit.fill,
                                    imageUrl:
                                        "${Examins[index]!.examinationImage}",
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "${Examins[index]!.examinationName}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "${Examins[index]!.Date} ",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                //   savePref(
                                //       Examins[index].examinationName,
                                //       Examins[index].examinationImage,
                                //       Examins[index].patientName,
                                //       Examins[index].TechnicianReport,
                                //       Examins[index].modelReport,
                                //       Examins[index].DoctorReport);
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ExaminationPage(Examins[index]!)),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }

  // Stream<List<ExaminModel>> readexamin() => FirebaseFirestore.instance
  //     .collection("Examination")
  //     .snapshots()
  //     .map((snapshot) => snapshot.docs
  //         .map((e) => ExaminModel.fromFirebase(e.data()))
  //         .toList());

  // Widget examinationCard(int index) => Container(
  //   height: 150,
  //   width: 150,
  //   color: Colors.blue,
  //   child: GestureDetector(
  //     child: Center(
  //         child: Text(
  //           "Examination $index",
  //           style: TextStyle(
  //             color: Colors.white,
  //           ),
  //         )),
  //     onTap: (){  Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) =>  ExaminationPage()),
  //     );},
  //   ),
  // );
}
