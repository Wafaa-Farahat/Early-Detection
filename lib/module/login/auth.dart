
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Layout/Home Layout.dart';
import 'login screen.dart';

class Auth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return HomeLayout();
          } else {
            return LoginScreen();
          }
        }),
      ),
    );
  }
}
