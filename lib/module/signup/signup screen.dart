import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:early_detection/module/login/login%20screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Layout/Home Layout.dart';

import '../../shared/components/curve_cliper.dart';
import '../login/auth.dart';

String? uid;

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isPatient = true;
  bool isMale = true;
  final registration_number = TextEditingController();
  final firstNameController = TextEditingController();
  final laststNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final specializatoinController = TextEditingController();

  Future signUp() async {
    if (passwordConfirmed()) {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim())
          .then((value) {
        uid = value.user!.uid;
        FirebaseFirestore.instance
            .collection("users")
            .doc(uid)
            .set(<String, dynamic>{
          "first name": firstNameController.text,
          "last name": laststNameController.text,
          "E-mail": emailController.text,
          "Phone": phoneNumberController.text,
          "selected_avatar": 1,
          "doctors": [],
          "patients": [],
          "examinations": [],
          "rule": isPatient ? "patient" : "doctor",
          "specialization": specializatoinController.text,
          "registeration_number": isPatient ? "" : registration_number.text,
          "DoctorImage":
              "https://th.bing.com/th/id/R.d58339de61b5d07fd4db988f8e8a7cdd?rik=SfZdJyKhxDm1VQ&pid=ImgRaw&r=0"
        }).then((value) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Auth(),
              ));
        });
      });
    }
  }

  bool passwordConfirmed() {
    if (passwordController.text.trim() ==
        confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  void dispose() {
    super.dispose();
    registration_number.dispose();
    firstNameController.dispose();
    laststNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  var formKey = GlobalKey<FormState>();
  bool ispassword1 = true;
  bool ispassword2 = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(border: Border.all(color: Color.fromRGBO(
              59, 118, 157, 1.0),width: 5,),),
          child: SingleChildScrollView(
            child: Column(
              children: [
// ClipPath(
//   clipper: CurveCliper(),
//   child: Container(
//     color: Color.fromRGBO(0, 129, 201, 1),
//     child: Row(
//       children: [
//         Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 IconButton(
//                     onPressed: () {},
//                     icon: Icon(
//                       Icons.arrow_back,
//                     )),
//               ],
//             ),
//             flex: 2),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Image(
//                   image: AssetImage("images/home_logo.png"),
//                   height: 100,
//                   width: 150),
//             ],
//           ),
//         ),
//       ],
//     ),
//   ),
// ),
                Form(
                  key: formKey,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [

                        CircleAvatar(foregroundImage: AssetImage("images/home_logo.png"),backgroundColor: Color.fromRGBO(0, 129, 201, 1),radius: 45),
                        //home_logo.png
                        //Splash_Image.png
                        SizedBox(height: 30,),
                        Text(
                          'Create Account',
                          style: TextStyle(
                            fontSize: 35.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(0, 129, 201, 1),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Row(
                          children: [
                            Expanded(child: Icon(Icons.perm_identity)),
                            SizedBox(width: 5,),
                            Expanded(
                              flex: 6,
                              child: TextFormField(
                                controller: firstNameController,
                                keyboardType: TextInputType.text,
                                onFieldSubmitted: (String value) {
                                  print(value);
                                },
                                decoration: InputDecoration(
                                  labelText: 'First name',
                                 // border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'First Name must not be empty ';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: [
                            Expanded(child: Icon(Icons.perm_identity)),
                            SizedBox(width: 5,),
                            Expanded(
                              flex: 6,
                              child: TextFormField(
                                controller: laststNameController,
                                keyboardType: TextInputType.text,
                                onFieldSubmitted: (String value) {
                                  print(value);
                                },
                                decoration: InputDecoration(
                                  labelText: 'Last name',
                                 // border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Last Name must not be empty';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: [
                            Expanded(child: Icon(Icons.email_outlined)),
                            SizedBox(width: 5,),
                            Expanded(
                              flex: 6,
                              child: TextFormField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                onFieldSubmitted: (String value) {
                                  print(value);
                                },
                                decoration: InputDecoration(
                                  labelText: 'Email Address',
                                  //border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ' Email Address must not be empty';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: [
                            Expanded(child: Icon(Icons.phone)),
                            SizedBox(width: 5,),
                            Expanded(
                              flex: 6,
                              child: TextFormField(
                                controller: phoneNumberController,
                                keyboardType: TextInputType.phone,
                                onFieldSubmitted: (String value) {
                                  print(value);
                                },
                                decoration: InputDecoration(
                                  labelText: 'phone number',
                                 // border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ' phone number must not be empty';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: [
                            Expanded(child: Icon(Icons.lock_outline_rounded)),
                            SizedBox(width: 5,),
                            Expanded(
                              flex: 6,
                              child: TextFormField(
                                controller: passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: ispassword1 ? true : false,
                                onFieldSubmitted: (String value) {
                                  print(value);
                                },
                                decoration: InputDecoration(
                                  labelText: 'password',
                                 // border: OutlineInputBorder(),
                                  suffixIcon: ispassword1
                                      ? IconButton(
                                          icon: Icon(
                                            Icons.visibility_off,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              ispassword1 = !ispassword1;
                                            });
                                          },
                                        )
                                      : IconButton(
                                          icon: Icon(
                                            Icons.visibility,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              ispassword1 = !ispassword1;
                                            });
                                          },
                                        ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ' password must not be empty';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: [
                            Expanded(child: Icon(Icons.lock_outline_rounded)),
                            SizedBox(width: 5,),
                            Expanded(
                               flex: 6,
                              child: TextFormField(
                                controller: confirmPasswordController,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: ispassword2 ? true : false,
                                onFieldSubmitted: (String value) {
                                  print(value);
                                },
                                decoration: InputDecoration(
                                  labelText: 'confirm password',
                                 // border: OutlineInputBorder(),
                                  suffixIcon: ispassword2
                                      ? IconButton(
                                          icon: Icon(
                                            Icons.visibility_off,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              ispassword2 = !ispassword2;
                                            });
                                          },
                                        )
                                      : IconButton(
                                          icon: Icon(
                                            Icons.visibility,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              ispassword2 = !ispassword2;
                                            });
                                          },
                                        ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ' confirm password must not be empty';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          "Select  Gender",
                          style: TextStyle(
                              color: Color.fromRGBO(0, 129, 201, 1),
                              fontSize: 30),
                        )),
                  ],
                ),
                Row(
                  children: [
////male
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isMale = true;
                          });
                        },
//male
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              // color: isMale
                              //     ? Color.fromRGBO(0, 129, 201, 1)
                              //     : Colors.white,
                              border: Border.all(
                                  color:isMale
                                      ? Color.fromRGBO(0, 129, 201, 1)
                                      : Colors.white, )),
                          //Color.fromRGBO(112, 112, 112, 100)
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(backgroundImage: AssetImage("images/girls/male.png"),radius: 40),
                              SizedBox(height: 5,),
                              Text(
                                "Male",
                                style: TextStyle(
                                    color:  Color.fromRGBO(0, 129, 201, 1),
                                    fontSize: 30),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
//female
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isMale = false;
                          });
                        },
//female
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              // color: !isMale
                              //     ? Color.fromRGBO(0, 129, 201, 1)
                              //     : Colors.white,
                              border: Border.all(
                                  color:!isMale
                                      ? Color.fromRGBO(0, 129, 201, 1)
                                      : Colors.white,)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(backgroundImage: AssetImage("images/girls/female.png"),radius: 40),
                              SizedBox(height: 5,),
                              Text(
                                "Female",
                                style: TextStyle(
                                    color: Color.fromRGBO(0, 129, 201, 1),
                                    fontSize: 30,
                                    textBaseline: TextBaseline.ideographic),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          "Select status",
                          style: TextStyle(
                              color: Color.fromRGBO(0, 129, 201, 1),
                              fontSize: 30),
                        )),
                  ],
                ),
                Row(
                  children: [
//Patient
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isPatient = true;
                          });
                        },
//Patient
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: isPatient
                                  ? Color.fromRGBO(0, 129, 201, 1)
                                  : Colors.white,
                              border: Border.all(
                                  color: Colors.white)),
                          child: Column(
                            children: [
                              Text(
                                "Patient",
                                style: TextStyle(
                                    color: isPatient
                                        ? Colors.white
                                        : Color.fromRGBO(0, 129, 201, 1),
                                    fontSize: 30),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
//Doctor
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isPatient = false;
                          });
                        },
//Doctor
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: !isPatient
                                  ? Color.fromRGBO(0, 129, 201, 1)
                                  : Colors.white,
                              border: Border.all(
                                  color: Colors.white)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Doctor",
                                style: TextStyle(
                                    color: !isPatient
                                        ? Colors.white
                                        : Color.fromRGBO(0, 129, 201, 1),
                                    fontSize: 30,
                                    textBaseline: TextBaseline.ideographic),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.all(10),
                  child: !isPatient
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              controller: registration_number,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    color: Color.fromRGBO(112, 112, 112, 100)),
                                hintText: "enter registration number",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                              onChanged: (value) {
                                print(value);
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: specializatoinController,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    color: Color.fromRGBO(112, 112, 112, 100)),
                                hintText: "enter specialization",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                              onChanged: (value) {
                                print(value);
                              },
                            ),
                          ],
                        )
                      : Text(""),
                ),
                SizedBox(
                  height: 20.0,
                ),
                GestureDetector(
                  onTap: signUp,
                  child: Container(
                    width: 300,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromRGBO(0, 129, 201, 1)),
                    child: MaterialButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          print(firstNameController.text);
                          print(laststNameController.text);
                          print(emailController.text);
                          print(phoneNumberController.text);
                          print(passwordController.text);
                          print(confirmPasswordController.text);
                          signUp();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomeLayout()),
                          );
                        }
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'have an account?',
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: ((context) => LoginScreen())));
                      },
                      child: Text('Login'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
