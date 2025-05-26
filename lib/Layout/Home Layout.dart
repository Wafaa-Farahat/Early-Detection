import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:early_detection/Layout/search%20screen.dart';


import 'package:flutter/material.dart';


import '../module/home/Home.dart';
import '../module/profile/profile screen.dart';

int currentScreen = 0;

class HomeLayout extends StatefulWidget {
  int currentIndex = 0;
  HomeLayout({
    Key? key,
    this.currentIndex = 0,
  }) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState(
        this.currentIndex,
      );
}

class _HomeLayoutState extends State<HomeLayout> {
  _HomeLayoutState(currentIndex) {
    currentScreen = currentIndex;
  }
  List<Widget> screens = [Home(), searchScreen(), ProfilePage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: currentScreen,
        color: Color.fromRGBO(0, 129, 201, 1),
        backgroundColor: Colors.white,
        height: 50,
        animationDuration: Duration(milliseconds: 100),
        items: [
          Icon(
            Icons.home_outlined,
            size: 30,
            color: Colors.black,
          ),
          Icon(
            Icons.search_outlined,
            size: 30,
            color: Colors.black,
          ),
          Icon(
            Icons.person_pin,
            size: 30,
            color: Colors.black,
          )
        ],
        onTap: (index) {
          print(index);
          setState(() {
            currentScreen = index;
          });
        },
      ),
      // drawer:const NavigationDrawer(),
      body: screens[currentScreen],
    );
  }
}
//menu

// class NavigationDrawer extends StatelessWidget {
//   const NavigationDrawer({Key? key}):super(key:key);
//
//   @override
//   Widget build(BuildContext context) =>Drawer(
//     child: SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children:<Widget> [
//           buildHeader(context),
//           buildMenuItems(context)
//         ],
//       ),
//     ),
//
//   );
//   Widget buildHeader(BuildContext context)=> Material(
//
//     color: Color.fromRGBO(0,129,201,1),
//     child:   InkWell(
//       onTap: () {
//
//         Navigator.pop(context);
//         Navigator.of(context).push(MaterialPageRoute(builder: ((context) => const profile())));
//       },
//       child:   Container(
//         padding: EdgeInsets.only(
//             top: 30+MediaQuery.of(context).padding.top,
//             bottom: 30
//         ),
//
//         child: Column(
//           children: [
//             CircleAvatar(
//               radius: 30,
//               backgroundImage:
//               NetworkImage('https://cdn.icon-icons.com/icons2/2643/PNG/512/avatar_female_woman_person_people_white_tone_icon_159360.png'),
//             ),
//             SizedBox(height: 15,),
//             Text('Wafaa Farahat'
//               , style: TextStyle(color: Colors.white),)
//           ],
//         ),
//       ),
//
//     ),
//   );
//   Widget buildMenuItems(BuildContext context)=>Container(
//     padding: EdgeInsets.all(24),
//     child:   Wrap(
//
//       runSpacing:16 ,//vertical spacing
//
//       children: [
//
//         ListTile(
//           leading:const Icon(Icons.home_outlined),
//           title: Text('Home') ,
//           onTap: () {
//             Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context) => const HomeLayout() )));
//           },
//         ),
//         ListTile(
//
//             leading:const Icon(Icons.notifications_none),
//
//             title: Text('Notifications') ,
//
//             onTap: (){
//               Navigator.pop(context);
//               Navigator.of(context).push(MaterialPageRoute(builder: ((context) =>  notificationScreen())));
//             }
//         ),
//
//
//         ListTile(
//
//           leading:const Icon(Icons.dark_mode_outlined),
//
//           title: Text('Dark Mode') ,
//
//           onTap: () {},
//
//         ),
//
//         ListTile(
//
//           leading:const Icon(Icons.info_outline),
//
//           title: Text('About Us') ,
//
//           onTap: () {},
//
//         ),
//
//         const Divider(color: Colors.black54,),
//
//         ListTile(
//
//           leading:const Icon(Icons.logout_outlined),
//
//           title: Text('Log out') ,
//
//           onTap: () {},
//
//         ),
//
//       ],
//
//     ),
//   );
// }
