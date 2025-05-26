import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../Layout/Home Layout.dart';
import '../../about us/about us.dart';
import '../login/login screen.dart';
import '../notification/notification screen.dart';

Map<String, dynamic> userInfo = {
  "first name": "",
  "last name": "",
};

List<String> avatars = [
  "images/girls/boy1.png",
  "images/girls/boy2.jpg",
  "images/girls/girl3.png",
  "images/girls/girl4.jpg"
];

bool view = true;
String image = avatars[selectedAvatar - 1];
int selectedAvatar = 1;
bool textenable = false;
dynamic saveIcon = Icons.save_as_outlined;
dynamic updateIcon = Icons.edit_note_rounded;

var lastname = TextEditingController();
var firstname = TextEditingController();
var Email = TextEditingController();
var Phone = TextEditingController();

void change_firebase_avatar() {
  userInfo["selected_avatar"] = selectedAvatar;
  print(userInfo);
  FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .set(userInfo);
}

void change_account_info() {
  userInfo["first name"] = firstname.text;
  userInfo["last name"] = lastname.text;
  userInfo["E-mail"] = Email.text;
  userInfo["phone"] = Phone.text;
  FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .set(userInfo);
}

Future<Map<String, dynamic>?> get_user_info() async {
  print("current user is ${FirebaseAuth.instance.currentUser!.uid}");
  await FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get()
      .then((value) {
    userInfo = value.data() as Map<String, dynamic>;
    print("user info is $userInfo");
    firstname = TextEditingController(text: userInfo["first name"]);
    lastname = TextEditingController(text: userInfo["last name"]);
    Email = TextEditingController(text: userInfo["E-mail"]);
    Phone = TextEditingController(text: userInfo["Phone"]);
    selectedAvatar = userInfo["selected_avatar"];
    image = avatars[selectedAvatar - 1];
    return userInfo;
  });
  // return {};
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
      drawer: NavigationDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // curve(),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(image),
                            radius: 50,
                            foregroundColor: Colors.blueGrey,
                          ),
                          Text(
                            userInfo["first name"] +
                                (" ") +
                                userInfo["last name"],
                            style: TextStyle(
                              fontSize: 25,
                              color: Color.fromRGBO(0, 0, 0, 1),
                            ),
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color.fromRGBO(121, 123, 127, 100)),
                      padding: EdgeInsets.all(5),
                      child: Column(
                        children: [
                          //view
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                view = true;
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        backgroundColor: Colors.blueGrey,
                                        contentPadding: EdgeInsets.all(5),
                                        content: CircleAvatar(
                                            backgroundImage: AssetImage(image),
                                            foregroundColor: Colors.blueGrey,
                                            radius: 180),
                                      );
                                    });
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Color.fromRGBO(121, 123, 127, 100)),
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.all(2),
                              child: Row(
                                children: [
                                  Text(
                                    "view",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(Icons.remove_red_eye_outlined, size: 17),
                                ],
                              ),
                            ),
                          ),
                          Text("------------------"),
                          //edit
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                view = false;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: view
                                      ? Color.fromRGBO(121, 123, 127, 100)
                                      : Colors.white),
                              padding: EdgeInsets.all(5),
                              child: view
                                  ? Row(
                                children: [
                                  Text(
                                    "edit",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(Icons.edit, size: 17),
                                ],
                              )
                                  : Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      //icon
                                      Container(
                                        child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                view = true;
                                              });
                                            },
                                            icon: Icon(
                                              Icons.remove,
                                              color: Colors.blueGrey,
                                            )),
                                      ),
                                      Row(
                                        children: [

                                          GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  image = avatars[1];
                                                  selectedAvatar = 2;
                                                  change_firebase_avatar();
                                                });
                                              },
                                              child: Container(
                                                  color: selectedAvatar == 2
                                                      ? Colors.blue
                                                      : Color.fromRGBO(
                                                      0, 0, 0, 0),
                                                  child: CircleAvatar(
                                                      backgroundImage:
                                                      AssetImage(
                                                        avatars[1],
                                                      ),
                                                      radius: 20))),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                image = avatars[0];
                                                selectedAvatar = 1;
                                                change_firebase_avatar();
                                              });
                                            },
                                            child: Container(
                                              color: selectedAvatar == 1
                                                  ? Colors.blue
                                                  : Color.fromRGBO(
                                                  0, 0, 0, 0),
                                              child: CircleAvatar(
                                                  backgroundImage:
                                                  AssetImage(
                                                    avatars[0],
                                                  ),
                                                  radius: 20),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  image = avatars[3];
                                                  selectedAvatar = 4;
                                                  change_firebase_avatar();
                                                });
                                              },
                                              child: Container(
                                                  color: selectedAvatar == 4
                                                      ? Colors.blue
                                                      : Color.fromRGBO(
                                                      0, 0, 0, 0),
                                                  child: CircleAvatar(
                                                      backgroundImage:
                                                      AssetImage(
                                                        avatars[3],
                                                      ),
                                                      radius: 20))),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          GestureDetector(
                                            child: Container(
                                              color: selectedAvatar == 3
                                                  ? Colors.blue
                                                  : Color.fromRGBO(
                                                  0, 0, 0, 0),
                                              child: CircleAvatar(
                                                  backgroundImage:
                                                  AssetImage(
                                                      avatars[2]),
                                                  radius: 20),
                                            ),
                                            onTap: () {
                                              setState(() {
                                                image = avatars[2];
                                                selectedAvatar = 3;
                                                change_firebase_avatar();
                                              });
                                            },
                                          ),

                                        ],
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                  ],
                ),
              ),
              Divider(
                height: 3,
                color: Color.fromRGBO(0, 129, 201, 100),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline,
                          color: Color.fromRGBO(146, 146, 146, 1), size: 29),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          "Account Info",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              if (textenable) {
                                change_account_info();
                              }
                              textenable = !textenable;
                            });
                          },
                          icon: Icon(
                            textenable ? saveIcon : updateIcon,
                            size: 28,
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      TextFormField(
                        controller: firstname,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          label: Text(
                            "First Name",
                            style: TextStyle(fontSize: 18),
                          ),
                          prefixIcon: Icon(Icons.perm_identity),
                          labelStyle: TextStyle(
                              color: Color.fromRGBO(165, 169, 174, 1)),
                          hintText: "First Name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50)),
                        ),
                        enabled: textenable,
                        // onFieldSubmitted: (value) {
                        //   setState(() {
                        //     textenable = false;
                        //   });
                        // },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: lastname,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          label: Text(
                            "Last Name",
                            style: TextStyle(fontSize: 18),
                          ),
                          prefixIcon: Icon(Icons.perm_identity),
                          labelStyle: TextStyle(
                              color: Color.fromRGBO(165, 169, 174, 1)),
                          hintText: "Last Name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50)),
                        ),
                        enabled: textenable,
                        onFieldSubmitted: (value) {
                          setState(() {
                            textenable = false;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: Email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          label: Text(
                            "E-mail",
                            style: TextStyle(fontSize: 18),
                          ),
                          prefixIcon: Icon(Icons.email_outlined),
                          labelStyle: TextStyle(
                              color: Color.fromRGBO(165, 169, 174, 1)),
                          hintText: "E-mail",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50)),
                        ),
                        enabled: textenable,
                        onFieldSubmitted: (value) {
                          setState(() {
                            textenable = false;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: Phone,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          label: Text(
                            "Phone number",
                            style: TextStyle(fontSize: 18),
                          ),
                          prefixIcon: Icon(Icons.phone),
                          labelStyle: TextStyle(
                              color: Color.fromRGBO(165, 169, 174, 1)),
                          hintText: "Phone number",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50)),
                        ),
                        enabled: textenable,
                        onFieldSubmitted: (value) {
                          setState(() {
                            textenable = false;
                          });
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      MaterialButton(
                        minWidth: 200,
                        height: 50,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: Color.fromRGBO(0, 129, 201, 1),
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: ((context) => LoginScreen())));
                        },
                        child: Text("log out",
                            style:
                            TextStyle(color: Colors.white, fontSize: 20)),
                        highlightColor: Colors.blueGrey,
                      )
                    ],
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
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