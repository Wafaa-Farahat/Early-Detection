
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../signup/signup screen.dart';
import 'auth.dart';

//FirebaseFirestore db = FirebaseFirestore.instance;

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  Future signIn() async {
    FirebaseAuth.instance.signOut();
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } catch (e) {
      print("error is $e");
    }
  }

  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  var formKey = GlobalKey<FormState>();

  bool ispassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(border: Border.all(color: Color.fromRGBO(
              15, 76, 117, 1),width: 10)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [

                      CircleAvatar(foregroundImage: AssetImage("images/home_logo.png"),backgroundColor: Color.fromRGBO(0, 129, 201, 1),radius: 45),
                      //home_logo.png
                      //Splash_Image.png
                      SizedBox(height: 30,),
                      Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 35.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(0, 129, 201, 1),
                        ),
                      ),
                      SizedBox(
                        height:20,
                      ),
                      Row(
                        children: [
                          Expanded(child: Icon(Icons.email)),
                          SizedBox(width: 5,),
                          Expanded(
                            flex: 6,
                            child: TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              onFieldSubmitted: (String value) {
                                print(value);
                              },
                              onChanged: (String value) {
                                print(value);
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'email addres must not be empty';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'Email Address',
                                // prefixIcon: Icon(
                                //   Icons.email,
                                // ),
                             //   border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        children: [
                          Expanded(child: Icon(Icons.lock)),
                          SizedBox(width: 5,),
                          Expanded(
                            flex: 6,
                            child: TextFormField(
                              controller: passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: ispassword ? true : false,
                              // obscureText: true,
                              onFieldSubmitted: (String value) {
                                print(value);
                              },
                              onChanged: (String value) {
                                print(value);
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'password must  not be empty ';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'password',
                                // prefixIcon: Icon(
                                //   Icons.lock,
                                // ),
                                //border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                                suffixIcon: ispassword
                                    ? IconButton(
                                        icon: Icon(
                                          Icons.visibility_off,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            ispassword = !ispassword;
                                          });
                                        },
                                      )
                                    : IconButton(
                                        icon: Icon(
                                          Icons.visibility,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            ispassword = !ispassword;
                                          });
                                        },
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      GestureDetector(
                        onTap: signIn,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(borderRadius:BorderRadius.circular(20), color: Color.fromRGBO(0, 129, 201, 1)),
                         // color: Color.fromRGBO(0, 129, 201, 1),
                          child: MaterialButton(

                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                print(emailController.text);
                                print(passwordController.text);
                                final user = <String, dynamic>{
                                  "email": emailController.text,
                                  "password": passwordController.text,
                                };

                                //  db.collection("users").add(user).then(

                                // (DocumentReference doc) => print(
                                //  'DocumentSnapshot added with ID: ${doc.id}'));
                                signIn();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Auth()),
                                );
                              }
                              ;
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account?',
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: ((context) => SignupScreen())));
                            },
                            child: Text('Sign Up'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
