
import 'package:early_detection/module/examination%20result/ExaminationResult.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'module/home/Home.dart';
import 'firebase_options.dart';
import 'module/splash/Splash Screen.dart';
import 'module/upload examination/getExaminationPage.dart';
import 'module/signup/signup screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),

    );
  }
}
