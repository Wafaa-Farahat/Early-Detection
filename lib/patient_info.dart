import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../model/examination model.dart';

import '/module/home/Home.dart' as prefix;
import 'module/my examination/examination_page.dart';

String? ID = "uncTJzExzDXjGsX2evZ9nn6KmKl2";

Map<String, dynamic>? userInfo = {'first name': "", 'last name': ""};
List<dynamic> userExaminations = [];
int selectedAvatar = 1;
List<String> avatars = [
  "images/girls/boy1.png",
  "images/girls/boy2.jpg",
  "images/girls/girl3.png",
  "images/girls/girl4.jpg"
];
String? image = avatars[selectedAvatar! - 1];

class PatientInfo extends StatefulWidget {
  PatientInfo(patientID) {
    ID = patientID;
  }

  @override
  State<PatientInfo> createState() => _PatientInfoState();
}

class _PatientInfoState extends State<PatientInfo> {
  @override
  void initState() {
    super.initState();

    get_user_info().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
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
        drawer: prefix.NavigationDrawer(),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(
                    avatars[selectedAvatar! - 1],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "${userInfo!['first name']} ${userInfo!['last name']}",
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                  ),
                  child: Divider(
                    thickness: 3,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Text(
                        "Patient Examinatoins",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: StreamBuilder<List<ExaminModel?>>(
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
                        return Container(
                          height: 200 *
                              (((Examins.length + 1) / 2).truncateToDouble()),
                          child: GridView.builder(
                            shrinkWrap: false,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: Examins.length,
                            itemBuilder: (context, index) => Container(
                              height: 200,
                              // height: 200 *
                              //     (((Examins.length + 1) / 2).truncateToDouble()),
                              color: Colors.blue,
                              child: GestureDetector(
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: CachedNetworkImage(
                                          height: 140,
                                          fit: BoxFit.fill,
                                          imageUrl:
                                          "${Examins[index]!.examinationImage}",
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                      flex: 5,
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
                                  print(
                                      "in patient info iz ${Examins[index]!.id}");
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
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

Future<Map<String, dynamic>?> get_user_info() async {
  print("current user is $ID");
  await FirebaseFirestore.instance
      .collection("users")
      .doc(ID)
      .get()
      .then((value) {
    print("here");
    userInfo = value.data();
    print("user info is $userInfo");
    userExaminations = userInfo!["examinations"];
    selectedAvatar = userInfo!["selected_avatar"];
    image = avatars[selectedAvatar! - 1];
    return userInfo;
  });
}

Stream<List<ExaminModel?>> readexamin() => FirebaseFirestore.instance
    .collection("Examination")
    .snapshots()
    .map((snapshot) {
  return snapshot.docs.map((e) {
    // print("id is ${" ${e.id}"}");
    print("iz $userExaminations");
    // print(userExaminations.contains(" ${e.id}"));
    if (userExaminations!.contains("${e.id}")) {
      // print("true");
      Map<String, dynamic> x = e.data();
      x['id'] = e.id;
      print("in home map iz $x");
      return ExaminModel.fromFirebase(x);
    }
  }).toList();
});
