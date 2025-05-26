import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import '../../Layout/Home Layout.dart';
import '../../model/examination model.dart';
import '../../patient_info.dart';
import '../home/Home.dart';


List<String> avatars = [
  "images/girls/boy1.png",
  "images/girls/boy2.jpg",
  "images/girls/girl3.png",
  "images/girls/girl4.jpg"
];

class DoctorsMenuPage extends StatelessWidget {
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
      body: StreamBuilder<List<DoctorModel?>>(
        stream: isPatient ? readdoctor() : readpatient(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("invalid");
          } else if (snapshot.hasData) {
            final doctors = snapshot.data!;
            print("data of doctors iz $doctors");
            doctors.removeWhere(
                  (element) => element is Null,
            );
            print("data of doctors iz $doctors");
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          isPatient ? "My Doctors" : "My Patients",
                          style: TextStyle(
                            fontSize: 35,
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
                    // width: 308,
                    child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: doctors.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: !isPatient
                            ? () {
                          print("id before send iz ${doctors[index]!}");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      PatientInfo(doctors[index]!.uid))));
                        }
                            : () {},
                        child: Container(
                          // height: 100,
                          // width: 100,
                          color: Colors.blue,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundImage: AssetImage(
                                    avatars[
                                    doctors[index]!.selectedAvatar! - 1],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "${doctors[index]!.DoctorName}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
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
      ),
    );
  }
}
