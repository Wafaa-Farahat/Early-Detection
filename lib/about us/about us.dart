import 'package:flutter/material.dart';

import '../Layout/Home Layout.dart';
import '../module/home/Home.dart';
import '../module/login/login screen.dart';
import '../module/notification/notification screen.dart';
import '../shared/components/card.dart';


class aboutUs extends StatelessWidget {
  const aboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(icon: Icon(Icons.home),onPressed: (){
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => HomeLayout(),
        //     ),
        //   );
        // }),
        title: Text("About App Developer Team"),
      ),
      drawer: NavigationDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.blueGrey),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: IconButton(icon: Icon(Icons.info_outline,color: Colors.indigo),onPressed: (){
                    }),
                  ),
                  Expanded(
                    flex: 7,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Column(
                        children: [
                          Text("This application is developed to help the patient / user to detect "
                              "three diseases early: Heart Cardiomegaley , Alzheimer's and Gastrointestinal "
                              "and to help doctors to follow up and comment on patients' cases.  ",
                          style: TextStyle(fontSize: 15)),
                          SizedBox(height: 5,),
                          Text("If you have any questions, complaints or suggestions, contact us: ",
                          style: TextStyle(fontSize: 15,color: Colors.indigo)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      card(image:"images/girls/girl.jpg" ,Email: "hindalaafathy@gmail.com",Github_account:"https://github.com/Hind-Alaa-Fathy",Name:"Hind Alaa Fathy" , ),
                      card(image:"images/girls/girl.jpg" ,Email: "wafaadarwish76@gmail.com",Github_account:"https://github.com/Wafaa-Farahat",Name:"Wafaa Farahat" , ),
                    ],
                  ),
                  Row(
                    children: [
                      card(image:"images/girls/girl.jpg" ,Email: "beroo.mohamed111@gmail.com",Github_account:"https://github.com/abeerMohamed111",Name:"Abeer Mohamed Mostafa" , ),
                      card(image:"images/girls/boy.jpg" ,Email: "abdelhamedzyada1@gmail.com",Github_account:"https://github.com/AbdElhamid-Zyada",Name:"Abd El-hamed Montaser" , ),
                    ],
                  ),

                ],
              ),
            ),
          ],
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