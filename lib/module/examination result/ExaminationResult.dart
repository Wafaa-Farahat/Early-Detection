import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../pdf.dart';
import '../upload examination/getExaminationPage.dart';

Map<String, dynamic> map = {};
var imageUrl = map['Ray Image'];
var tecimageUrl = map['Technican Report'];
var valueChoose = map['Disease Name'];
var userName = "Mona";

class ExaminationResult extends StatefulWidget {
  Map<String, dynamic> data = {};
  ExaminationResult({Key? key, required this.data}) : super(key: key);

  @override
  State<ExaminationResult> createState() => _ExaminationResultState(this.data);
}

class _ExaminationResultState extends State<ExaminationResult> {
  // var patientName;
  // getPref2()async{
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   setState((){
  //     patientName = preferences.getString("patientName");
  //   });
  // }

  _ExaminationResultState(data) {
    map = data;
    print("map iz $map");
    imageUrl = map['examinationImage'];
    tecimageUrl = map['TechnicianReport'];
    valueChoose = map['examinationName'];
    userName = map['patientName'];
    print(
        "value choose iz $valueChoose \nimage url iz $imageUrl\ntech image iz $tecimageUrl");
  }

  // getimageandname() async {
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get()
  //       .then(
  //     (value) {
  //       print(value.data()!);
  //       print("user name iz $userName");
  //     },
  //   );
  // SharedPreferences imagepreferences = await SharedPreferences.getInstance();
  // setState(() {
  //   // valueChoose = imagepreferences.getString("examinationName");
  //   // imageUrl = imagepreferences.getString("examinationImage");
  //   // tecimageUrl = imagepreferences.getString("TechnicianReport");
  // });

  void initState() {
    // getPref2();
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
                MaterialPageRoute(builder: (context) => getExaminationpage()),
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              //examination name
              Text("$valueChoose",
                  style: TextStyle(
                      color: Color.fromRGBO(0, 129, 201, 1), fontSize: 35)),
              SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(
                      thickness: 3,
                    ),
                    //patient name
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start ,
                        children: [
                          Text("Name : $userName",
                              style: TextStyle(fontSize: 20)),
                          SizedBox( height: 15,),
                          Text("Date : ${map['Date']}",
                              style: TextStyle(fontSize: 20)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    // date-time
                    // Padding(
                    //   padding: const EdgeInsets.all(10.0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     children: [
                    //       Text(
                    //           "Time : ${DateTime.now().hour}.${DateTime.now().minute}.${DateTime.now().second}",
                    //           style: TextStyle(fontSize: 20)),
                    //     ],
                    //   ),
                    // ),
                    Divider(
                      thickness: 3,
                    ),
                    //x-ray / technical report
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Image(
                                    image: NetworkImage(
                                  imageUrl,
                                )
                                    // placeholder: (context, url) =>
                                    //     CircularProgressIndicator(),
                                    // errorWidget: (context, url, error) =>
                                    //     Icon(Icons.error),
                                    ),
                                Text("x-ray"),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: tecimageUrl,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                                Text("technical report"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 25, top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Result", style: TextStyle(fontSize: 25)),
                        ],
                      ),
                    ),
                    //model result
                    Container(
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.all(30),
                      decoration: BoxDecoration(
                          border: Border.all(style: BorderStyle.solid)),
                      child: Column(
                        children: [
                          Text(map['modelReport'],
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Color.fromRGBO(34, 146, 208, 1))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),


              //Send
              Container(
                height: 50,
                width: 250,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  padding: EdgeInsets.all(11),
                  color: Color.fromRGBO(91, 192, 248, 1),
                  onPressed: () {
                    PdfGenerator.createPdf(map['modelReport'], valueChoose);
                  },
                  child: Text("Send result",
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
