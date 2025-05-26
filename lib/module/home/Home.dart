import 'package:cached_network_image/cached_network_image.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Layout/Home Layout.dart';
import '../../about us/about us.dart';
import '../../model/examination model.dart';
import '../../patient_info.dart';

import '../upload examination/getExaminationPage.dart';
import '../login/login screen.dart';
import '../my examination/doctors_menu_page.dart';
import '../my examination/examination_page.dart';
import '../my examination/examinations_menu_page.dart';


List<String> avatars = [
  "images/girls/boy1.png",
  "images/girls/boy2.jpg",
  "images/girls/girl3.png",
  "images/girls/girl4.jpg"
];

Map<String, dynamic>? userInfo = {
  "first name": "",
  "last name": "",
};
String image = avatars[selectedAvatar];
int selectedAvatar = 1;

List<dynamic>? userExaminations = [];
List<dynamic>? userDoctors = [];
List<dynamic>? userPatients = [];
bool isPatient = true;

Future<Map<String, dynamic>?> get_user_info() async {
  print("current user is ${FirebaseAuth.instance.currentUser!.uid}");
  await FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get()
      .then((value) {
    userInfo = value.data();
    print("user info is $userInfo");
    userExaminations = userInfo!["examinations"];
    userDoctors = userInfo!["doctors"];
    userPatients = userInfo!['patients'];
    selectedAvatar = userInfo!["selected_avatar"];
    image = avatars[selectedAvatar - 1];
    isPatient = (userInfo!['rule'] == "patient");
    return userInfo;
  });
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_user_info().then((value) {
      print("value in home init state is $value");
      print("user info in home init state is $userInfo");
      selectedAvatar = userInfo!["selected_avatar"];
      setState(() {});
    });
  }

  int examinationCount = 0;
  int listSize = 0;
  int doctorCount = 0;
  int doclistSize = 0;

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
        drawer: NavigationDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder<List<ExaminModel?>>(
                  stream: readexamin(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      print(snapshot.error);
                      return Text("invalid");
                    } else if (snapshot.hasData) {
                      final Examins = snapshot.data!;
                      Examins.removeWhere(
                            (element) => element is Null,
                      );
                      return SingleChildScrollView(
                        child: SafeArea(
                          child: Column(
                            children: [

                              //My examination & My doctors
                              Container(
                                padding: EdgeInsets.all(30),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          // flex: 3,
                                            child: Text(
                                              "My Examinations",
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      0, 129, 201, 1),
                                                  fontSize: 25),
                                            )),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ExaminationsMenuPage()),
                                            );
                                          },
                                          child: Text(
                                            "more",
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    112, 112, 112, 1),
                                                fontSize: 19),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 150,
                                            child: ListView.separated(
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: ((context, index) =>
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ExaminationPage(
                                                                    Examins[
                                                                    index]!)),
                                                      );
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(20),
                                                        color: Color.fromRGBO(
                                                            91, 192, 248, 1),
                                                      ),
                                                      padding:
                                                      EdgeInsets.all(10),
                                                      child: Column(
                                                        children: [
                                                          Expanded(
                                                              flex: 2,
                                                              child:
                                                              CachedNetworkImage(
                                                                imageUrl:
                                                                "${Examins[index]?.examinationImage}",
                                                                placeholder: (context,
                                                                    url) =>
                                                                    CircularProgressIndicator(),
                                                                errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                    Icon(Icons
                                                                        .error),
                                                              )),
                                                          SizedBox(
                                                            height: 20,
                                                          ),
                                                          Expanded(
                                                              child: Text(
                                                                  "${Examins[index]?.examinationName}",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                      15,
                                                                      color: Colors
                                                                          .white),
                                                                  textAlign:
                                                                  TextAlign
                                                                      .center)),
                                                          Expanded(
                                                              child: Text(
                                                                  "${Examins[index]?.Date}",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                      15,
                                                                      color: Colors
                                                                          .white),
                                                                  textAlign:
                                                                  TextAlign
                                                                      .center)),
                                                        ],
                                                      ),
                                                    ),
                                                  )),
                                              separatorBuilder:
                                                  (context, index) => SizedBox(
                                                width: 5,
                                              ),
                                              shrinkWrap: true,
                                              itemCount: Examins.length > 3
                                                  ? 3
                                                  : Examins.length,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                            child: IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons
                                                      .arrow_forward_ios_rounded,
                                                  color: Colors.white,
                                                )),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(30),
                                              color: Color.fromRGBO(
                                                  165, 157, 209, 1),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
              ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
              // ///////////////// //////////////////////////////////////////
              //My doctors
              StreamBuilder<List<DoctorModel?>>(
                stream: isPatient ? readdoctor() : readpatient(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("invalid");
                  } else if (snapshot.hasData) {
                    final doctors = snapshot.data!;
                    print("data of doctors is $doctors");
                    doctors.removeWhere(
                          (element) => element is Null,
                    );
                    print("data of doctors is $doctors");

                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: Text(
                                        isPatient ? "My doctors" : "My patients",
                                        style: TextStyle(
                                            color: Color.fromRGBO(0, 129, 201, 1),
                                            fontSize: 25),
                                      )),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DoctorsMenuPage()),
                                      );
                                    },
                                    child: Text(
                                      "more",
                                      style: TextStyle(
                                          color:
                                          Color.fromRGBO(112, 112, 112, 1),
                                          fontSize: 19),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    Container(
                                      height: 150,
                                      child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: ((context, index) =>
                                            GestureDetector(
                                              onTap: !isPatient
                                                  ? () {
                                                print(
                                                    "id before send iz ${doctors[index]!}");
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: ((context) =>
                                                            PatientInfo(doctors[
                                                            index]!
                                                                .uid))));
                                              }
                                                  : () {},
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(20),
                                                  color: Color.fromRGBO(
                                                      91, 192, 248, 1),
                                                ),
                                                padding: EdgeInsets.all(10),
                                                child: Column(
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: CircleAvatar(
                                                        radius: 30,
                                                        backgroundImage:
                                                        AssetImage(
                                                          avatars[doctors[index]!.selectedAvatar! - 1],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Expanded(
                                                        child: Text(
                                                            " ${doctors[index]!.DoctorName}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .white),
                                                            textAlign: TextAlign
                                                                .center)),
                                                  ],
                                                ),
                                              ),
                                            )),
                                        separatorBuilder: (context, index) =>
                                            SizedBox(
                                              width: 5,
                                            ),
                                        shrinkWrap: true,
                                        itemCount: doctors.length > 3
                                            ? 3
                                            : doctors.length,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            color: Colors.white,
                                          )),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Color.fromRGBO(165, 157, 209, 1),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        //get new examination
                        Padding(
                          padding: const EdgeInsets.only(
                             bottom: 90,
                            right: 20
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FloatingActionButton(
                                  onPressed: () {},
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                getExaminationpage()),
                                      );
                                    },
                                    icon: Icon(Icons.add, color: Colors.white),
                                  ),
                                  backgroundColor:
                                  Color.fromRGBO(0, 129, 201, 1),
                                  tooltip: "Get New Examination"),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              )
            ],
          ),
        ));
  }
}

class NavigationDrawer extends StatefulWidget {
  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_user_info().then((value) {
      setState(() {});
    });
  }

  Widget buildHeader(BuildContext context) {
    return Material(
      color: Color.fromRGBO(0, 129, 201, 1),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          Navigator.of(context).push(MaterialPageRoute(
              builder: ((context) => HomeLayout(
                currentIndex: 2,
              ))));
        },
        child: Container(
          padding: EdgeInsets.only(
              top: 30 + MediaQuery.of(context).padding.top, bottom: 30),
          child: Column(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(
                  avatars[selectedAvatar - 1],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                (userInfo!["first name"] + " " + userInfo!["last name"]),
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuItems(BuildContext context) => Container(
    padding: EdgeInsets.all(24),
    child: Wrap(
      runSpacing: 16, //vertical spacing

      children: [
        ListTile(
          leading: const Icon(Icons.home_outlined),
          title: Text('Home'),
          onTap: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: ((context) => HomeLayout())));
          },
        ),
        // ListTile(
        //     leading: const Icon(Icons.notifications_none),
        //     title: Text('Notifications'),
        //     onTap: () {
        //       Navigator.pop(context);
        //       Navigator.of(context).push(MaterialPageRoute(
        //           builder: ((context) => notificationScreen())));
        //     }),

        // ListTile(
        //   leading: const Icon(Icons.dark_mode_outlined),
        //   title: Text('Dark Mode'),
        //   onTap: () {},
        // ),
        ListTile(
          leading: const Icon(Icons.info_outline),
          title: Text('About Us'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => aboutUs(),
              ),
            );
          },
        ),
        const Divider(
          color: Colors.black54,
        ),
        ListTile(
          leading: const Icon(Icons.logout_outlined),
          title: Text('Log out'),
          onTap: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: ((context) => LoginScreen())));
          },
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    get_user_info().then((value) {});
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[buildHeader(context), buildMenuItems(context)],
        ),
      ),
    );
  }
}

Stream<List<DoctorModel?>> readdoctor() {
  return FirebaseFirestore.instance
      .collection("users")
      .snapshots()
      .map((snapshot) {
    print("doctors is ${userDoctors}");

    return snapshot.docs.map((e) {
      print(e.data());
      if (userDoctors!.contains("${e.id}")) {
        print("truez");
        Map<String, dynamic> x = e.data();
        x['uid'] = e.id;
        print("in home map iz $x");

        return DoctorModel.fromFirebase(x);
      }
    }).toList();
  });
}

Stream<List<DoctorModel?>> readpatient() {
  return FirebaseFirestore.instance
      .collection("users")
      .snapshots()
      .map((snapshot) {
    print("patients iz ${userPatients}");
    return snapshot.docs.map((e) {
      print(e.data());
      if (userPatients!.contains("${e.id}")) {
        Map<String, dynamic> x = e.data();
        x['uid'] = e.id;
        print("in home map iz $x");
        return DoctorModel.fromFirebase(x);
      }
    }).toList();
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
