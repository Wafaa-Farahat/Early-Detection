import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import '../about us/about us.dart';
import '../module/home/Home.dart';
import '../module/login/login screen.dart';
import '../module/notification/notification screen.dart';
import 'Home Layout.dart';

String name = "";
List<dynamic> currentDoctors = [];
List<dynamic>? currentPatients = [];
bool isPatient = true;

final snackBar = SnackBar(
  elevation: 0,
  behavior: SnackBarBehavior.floating,
  backgroundColor: Colors.transparent,
  content: AwesomeSnackbarContent(
    title: 'Done!',
    message: 'Added successfuly to favourites',
    contentType: ContentType.success,
  ),
);

class searchScreen extends StatefulWidget {
  const searchScreen({super.key});

  @override
  State<searchScreen> createState() => _searchScreenState();
}

class _searchScreenState extends State<searchScreen> {
  @override
  void initState() {
    super.initState();
    getFavourites().then(
          (value) {
        setState(() {});
      },
    );
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: 40.0,
            ),
            Text(
              isPatient ? 'Doctors' : 'Patients',
              style: TextStyle(
                fontSize: 35.0,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(0, 129, 201, 100),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.grey[300],
              ),
              padding: EdgeInsets.all(5.0),
              child: Card(
                child: TextFormField(
                  maxLines: 1,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (val) {
                    setState(() {
                      name = val;
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .where("rule",
                      isEqualTo: isPatient ? "doctor" : "patient")
                      .snapshots(),
                  builder: (context, snapshots) {
                    return (snapshots.connectionState ==
                        ConnectionState.waiting)
                        ? Center(
                      child: CircularProgressIndicator(),
                    )
                        : ListView.builder(
                      itemCount: snapshots.data!.docs.length,
                      itemBuilder: (context, index) {
                        var data = snapshots.data!.docs[index].data()
                        as Map<String, dynamic>;

                        if (name.isEmpty) {
                          return buildListTile(data, snapshots, index);
                        }
                        if ((data['first name'] + " " + data['last name'])
                            .toString()
                            .toLowerCase()
                            .startsWith(name.toLowerCase())) {
                          return buildListTile(data, snapshots, index);
                        }
                        return Container();
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildListTile(data, snapshots, index) {
    print(data);
    return ListTile(
      horizontalTitleGap: 0,
      minLeadingWidth: 0,
      minVerticalPadding: 0,
      contentPadding: EdgeInsetsDirectional.zero,
      title: Text(
        "${data['first name']} ${data['last name']}",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      // subtitle: Text(
      //   data['specialization'],
      //   maxLines: 1,
      //   overflow: TextOverflow.ellipsis,
      //   style: TextStyle(
      //     color: Colors.black54,
      //     fontSize: 16,
      //     fontWeight: FontWeight.bold,
      //   ),
      // ),
      // leading: CircleAvatar(
      //   radius: 35,
      //   backgroundImage: NetworkImage(
      //     data['DoctorImage'],
      //   ),
      // ),
      trailing: checkFavourite(
        snapshots.data!.docs[index].id,
      )
          ? SizedBox()
          : IconButton(
          onPressed: () => setState(() {
            addToFavourite(
              snapshots.data!.docs[index].id,
            );
          }),
          icon: Icon(Icons.add)),
    );
  }

  addToFavourite(String ID) {
    isPatient ? currentDoctors.add(ID) : currentPatients!.add(ID);
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(isPatient
        ? {"doctors": currentDoctors}
        : {"patients": currentPatients})
        .then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        snackBar,
      );
    });
  }
}

Future getFavourites() async {
  await FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get()
      .then((value) {
    isPatient = (value.data()!['rule'] == "patient");
    currentDoctors = value.data()!["doctors"];
    currentPatients = value.data()!["patients"];
  });
}

bool checkFavourite(String ID) => isPatient
    ? currentDoctors.toString().contains(ID)
    : currentPatients.toString().contains(ID);



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