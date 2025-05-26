import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../how to use/how use app.dart';
import '../login/login screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final controller = PageController();

  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() => isLastPage = index == 3);
          },
          children: [
            buildPage(
                color: Colors.white,
                urlImage: 'images/pic1.jpg',
                title: 'Help You Become Diagnosed',
                subtitle: "Upload Your Rays and \n we will examine you"),
            buildPage(
                color: Colors.white,
                urlImage: 'images/pic2.jpg',
                title: 'Awesome!',
                subtitle: 'The diagnostic test has officially started.'),
            buildPage(
                color: Colors.white,
                urlImage: 'images/pic3.jpg',
                title: 'Get instant result from the app',
                subtitle: ''),
            buildPage(
                color: Colors.white,
                urlImage: 'images/pic4.jpg',
                title:
                    "Get notifications with \n your report result attached\n to doctor report",
                subtitle: ''),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                alignment: Alignment.center,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                backgroundColor: Color.fromRGBO(0, 129, 201, 1),
                minimumSize: Size.fromHeight(55),
              ),
              onPressed: () async {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: ((context) => LoginScreen())));
              },
              child: Text(
                'Get Started',
                style: TextStyle(fontSize: 24),
              ))
          : Container(
              height: 120,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              controller.jumpToPage(3);
                            },
                            child:
                                Text('Skip', style: TextStyle(fontSize: 18))),
                        Center(
                          child: SmoothPageIndicator(
                            controller: controller,
                            count: 4,
                            effect: WormEffect(
                              spacing: 10,
                              dotColor: Colors.black26,
                              activeDotColor: Color.fromRGBO(0, 129, 201, 1),
                            ),
                            onDotClicked: (index) => controller.animateToPage(
                              index,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            ),
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              controller.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            },
                            child: Text(
                              'Next',
                              style: TextStyle(fontSize: 18),
                            ))
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => useApp()),
                      );
                    },
                    child: Text(
                      'learn how to use our app',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

Widget buildPage({
  required Color color,
  required String urlImage,
  required String title,
  required String subtitle,
}) =>
    Container(
      color: color,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 120,
          ),
          Image.asset(
            urlImage,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
