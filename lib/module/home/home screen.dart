// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:early_detection_graduation_project/Layout/Home%20Layout.dart';
// import 'package:early_detection_graduation_project/module/splash/Splash%20Screen.dart';
// import 'package:early_detection_graduation_project/module/upload%20examination/getExaminationResult.dart';
// import 'package:early_detection_graduation_project/module/login/login%20screen.dart';
// import 'package:early_detection_graduation_project/module/my%20examination/doctors_menu_page.dart';
// import 'package:early_detection_graduation_project/module/my%20examination/examinations_menu_page.dart';
// import 'package:early_detection_graduation_project/module/notification/notification%20screen.dart';
// import 'package:early_detection_graduation_project/module/profile/profile%20screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// import '../../shared/components/wave.dart';
// import '../my examination/examination_page.dart';

// Map<String, dynamic> userInfo = {
//   "first name": "",
//   "last name": "",
// };
// List<String> avatars = [
//   "images/girls/girl1.png",
//   "images/girls/girl2.png",
//   "images/girls/girl3.png",
//   "images/girls/girl4.jpg"
// ];
// int examinationCount = 0;
// int listSize = 0;
// int doctorCount = 0;
// int doclistSize = 0;
// String image = avatars[selectedAvatar - 1];
// int selectedAvatar = 1;

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   // List<examinationModel> examination = [
//   //   examinationModel(
//   //     name: "Examination 1",
//   //     date: "12/12/2022",
//   //   ),
//   //   examinationModel(name: "Examination 2", date: "11/11/2022"),
//   //   examinationModel(name: "Examination 3", date: "8/2/2022"),
//   //   examinationModel(name: "Examination 4", date: "9/7/2022"),
//   //   examinationModel(name: "Examination 5", date: "2/4/2022"),
//   //   examinationModel(name: "Examination 6", date: "3/3/2019"),
//   // ];
//   // List<DoctorModel> doctor = [
//   //   DoctorModel(name: "Amr"),
//   //   DoctorModel(name: "Alia"),
//   //   DoctorModel(name: "Ahmed"),
//   //   DoctorModel(name: "Ali"),
//   //   DoctorModel(name: "Alaa"),
//   //   DoctorModel(name: "Heba"),
//   // ];
//   int examinationCount = 0;
//   int listSize = 0;
//   int doctorCount = 0;
//   int doclistSize = 0;

//   Future<Map<String, dynamic>> get_user_info() async {
//     // await FirebaseAuth.instance.signInWithEmailAndPassword(
//     //   email: "ab.zy.az30@gmail.com",
//     //   password: "Bedooo",
//     // );
//     await FirebaseAuth.instance.authStateChanges().listen((User? user) {
//       userInfo["uid"] = user;
//       FirebaseFirestore.instance
//           .collection("users")
//           .doc(user!.uid)
//           .get()
//           .then((value) {
//         userInfo = value.data() as Map<String, dynamic>;
//       });
//     });
//     return userInfo;
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     get_user_info().then((value) {
//       userInfo = value;
//       selectedAvatar = userInfo["selected_avatar"] - 1;
//       setState(() {});
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home'),
//         centerTitle: true,
//         backgroundColor: Color.fromRGBO(0, 129, 201, 1),
//         elevation: 0,
//         actions: [
//           Image(
//             image: AssetImage("images/home_logo.png"),
//             // height: 152,
//           ),
//         ],
//         // bottom: PreferredSize(child: SizedBox(height: 10,), preferredSize: Size.fromHeight(10)
//         // ),
//       ),
//       drawer: NavigationDrawer(),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             //first part
//             // curve(),

//             Container(
//               child: Stack(
//                 children: [
//                   Image(
//                     image: AssetImage('images/curve.png'),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(
//                         bottom: 30, left: 300, top: 5, right: 2),
//                     // child: Image(
//                     // image: AssetImage("images/home_logo.png"),
//                     // height: 70,width:100
//                     // ),
//                   ),
//                 ],
//               ),
//               //  color: Color.fromRGBO(0,129,201,1),
//             ),
//             // SizedBox(height: 15,),

//             //My examination & My doctors
//             Column(
//               children: [
//                 // My examination
//                 Container(
//                   //color: Colors.deepPurple,
//                   padding: EdgeInsets.all(30),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Text(
//                             "My examinations",
//                             style: TextStyle(
//                                 color: Color.fromRGBO(0, 129, 201, 1),
//                                 fontSize: 25),
//                           ),
//                           SizedBox(
//                             width: 46,
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                         ExaminationsMenuPage()),
//                               );
//                             },
//                             child: Text(
//                               "more",
//                               style: TextStyle(
//                                   color: Color.fromRGBO(112, 112, 112, 1),
//                                   fontSize: 19),
//                             ),
//                           )
//                         ],
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Row(
//                           children: [
//                             // Container(
//                             //   height: 130,
//                             //   child: ListView.separated(
//                             //     scrollDirection: Axis.horizontal,
//                             //     itemBuilder: ((context, index) =>
//                             //         buildexaminationItem(
//                             //             examination[index + examinationCount])),
//                             //     separatorBuilder: (context, index) => SizedBox(
//                             //       width: 5,
//                             //     ),
//                             //     shrinkWrap: true,
//                             //     itemCount: 3,
//                             //   ),
//                             // ),
//                             SizedBox(
//                               width: 5,
//                             ),
//                             //       // Container(
//                             //       //   child: IconButton(
//                             //       //       onPressed: () {
//                             //       //         setState(() {
//                             //       //           if (examinationCount <
//                             //       //               examination.length) {
//                             //       //             examinationCount += 3;
//                             //       //             listSize = examination.length;
//                             //       //             if (examinationCount > listSize - 3 &&
//                             //       //                 examinationCount < listSize) {
//                             //       //               examinationCount = listSize - 3;
//                             //       //             } else if (examinationCount ==
//                             //       //                 listSize) {
//                             //       //               examinationCount = 0;
//                             //       //             }
//                             //       //           }
//                             //       //         });
//                             //       //       },
//                             //             icon: Icon(
//                             //               Icons.arrow_forward_ios_rounded,
//                             //               color: Colors.white,
//                             //             )),
//                             //         decoration: BoxDecoration(
//                             //           borderRadius: BorderRadius.circular(30),
//                             //           color: Color.fromRGBO(165, 157, 209, 1),
//                             //         ),
//                             //       ),
//                             //     ],
//                             //   ),
//                             // ),
//                           ],
//                         ),
//                       ),

//                       //My doctors
//                       Container(
//                         padding: EdgeInsets.all(30),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           mainAxisSize: MainAxisSize.max,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "My doctors",
//                                   style: TextStyle(
//                                       color: Color.fromRGBO(0, 129, 201, 1),
//                                       fontSize: 25),
//                                 ),
//                                 SizedBox(
//                                   width: 46,
//                                 ),
//                                 GestureDetector(
//                                   onTap: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                               DoctorsMenuPage()),
//                                     );
//                                   },
//                                   child: Text(
//                                     "more",
//                                     style: TextStyle(
//                                         color: Color.fromRGBO(112, 112, 112, 1),
//                                         fontSize: 19),
//                                   ),
//                                 )
//                               ],
//                             ),
//                             SizedBox(
//                               height: 20,
//                             ),
//                             // SingleChildScrollView(
//                             //   scrollDirection: Axis.horizontal,
//                             //   child: Row(
//                             //     children: [
//                             //       Container(
//                             //         height: 130,
//                             //         child: ListView.separated(
//                             //           scrollDirection: Axis.horizontal,
//                             //           itemBuilder: ((context, index) =>
//                             //               builddoctorItem(
//                             //                   doctor[index + doctorCount])),
//                             //           separatorBuilder: (context, index) => SizedBox(
//                             //             width: 5,
//                             //           ),
//                             //           shrinkWrap: true,
//                             //           itemCount: 3,
//                             //         ),
//                             //       ),
//                             SizedBox(
//                               width: 5,
//                             ),
//                             // Container(
//                             //   child: IconButton(
//                             //       onPressed: () {
//                             //         setState(() {
//                             //           if (doctorCount < doctor.length) {
//                             //             doctorCount += 3;
//                             //             doclistSize = doctor.length;
//                             //             if (doctorCount > doclistSize - 3 &&
//                             //                 doctorCount < doclistSize) {
//                             //               doctorCount = doclistSize - 3;
//                             //             } else if (doctorCount == doclistSize) {
//                             //               doctorCount = 0;
//                             //             }
//                             //           }
//                             //         });
//                             //       },
//                             //       icon: Icon(
//                             //         Icons.arrow_forward_ios_rounded,
//                             //         color: Colors.white,
//                             //       )),
//                             //   decoration: BoxDecoration(
//                             //     borderRadius: BorderRadius.circular(30),
//                             //     color: Color.fromRGBO(165, 157, 209, 1),
//                             //   ),
//                             // ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             //get new examination
//             Padding(
//               padding: const EdgeInsets.only(bottom: 30, right: 30),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   FloatingActionButton(
//                       onPressed: () {},
//                       child: IconButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => getExaminationPage()),
//                           );
//                         },
//                         icon: Icon(Icons.add, color: Colors.white),
//                       ),
//                       backgroundColor: Color.fromRGBO(0, 129, 201, 1),
//                       tooltip: "Get New Examination"),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class NavigationDrawer extends StatefulWidget {
//   @override
//   State<NavigationDrawer> createState() => _NavigationDrawerState();
// }

// class _NavigationDrawerState extends State<NavigationDrawer> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     get_user_info().then((value) {
//       userInfo = value!.cast();
//       selectedAvatar = userInfo["selected_avatar"] - 1;
//       print(selectedAvatar);
//     });
//   }

//   Widget buildHeader(BuildContext context) {
//     // get_user_info().then((value) {
//     //   userInfo = value;

//     //   setState(() {});
//     // });
//     return Material(
//       color: Color.fromRGBO(0, 129, 201, 1),
//       child: InkWell(
//         onTap: () {
//           Navigator.pop(context);
//           Navigator.of(context)
//               .push(MaterialPageRoute(builder: ((context) => ProfilePage())));
//         },
//         child: Container(
//           padding: EdgeInsets.only(
//               top: 30 + MediaQuery.of(context).padding.top, bottom: 30),
//           child: Column(
//             children: [
//               CircleAvatar(
//                 radius: 30,
//                 backgroundImage: AssetImage(
//                   avatars[selectedAvatar],
//                 ),
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               Text(
//                 (userInfo["first name"] + " " + userInfo["last name"]),
//                 style: TextStyle(color: Colors.white),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildMenuItems(BuildContext context) => Container(
//         padding: EdgeInsets.all(24),
//         child: Wrap(
//           runSpacing: 16, //vertical spacing

//           children: [
//             ListTile(
//               leading: const Icon(Icons.home_outlined),
//               title: Text('Home'),
//               onTap: () {
//                 Navigator.of(context).pushReplacement(
//                     MaterialPageRoute(builder: ((context) => HomeLayout())));
//               },
//             ),
//             ListTile(
//                 leading: const Icon(Icons.notifications_none),
//                 title: Text('Notifications'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.of(context).push(MaterialPageRoute(
//                       builder: ((context) => notificationScreen())));
//                 }),
//             ListTile(
//               leading: const Icon(Icons.dark_mode_outlined),
//               title: Text('Dark Mode'),
//               onTap: () {},
//             ),
//             ListTile(
//               leading: const Icon(Icons.info_outline),
//               title: Text('About Us'),
//               onTap: () {},
//             ),
//             const Divider(
//               color: Colors.black54,
//             ),
//             ListTile(
//               leading: const Icon(Icons.logout_outlined),
//               title: Text('Log out'),
//               onTap: () {
//                 Navigator.of(context).pushReplacement(
//                     MaterialPageRoute(builder: ((context) => LoginScreen())));
//               },
//             ),
//           ],
//         ),
//       );

//   @override
//   Widget build(BuildContext context) {
//     get_user_info().then((value) {
//       setState(() {});
//     });
//     return Drawer(
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[buildHeader(context), buildMenuItems(context)],
//         ),
//       ),
//     );
//   }
// }
