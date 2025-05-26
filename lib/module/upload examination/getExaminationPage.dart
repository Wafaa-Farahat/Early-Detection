import 'dart:io';
import 'package:early_detection/Layout/Home%20Layout.dart';
import 'package:http/http.dart' as http;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../examination result/ExaminationResult.dart';
import '../home/Home.dart';

var userName = "";
var userExaminations = [];

 // String ip = "http://192.168.1.7";

class getExaminationpage extends StatefulWidget {
  const getExaminationpage({super.key});

  @override
  State<getExaminationpage> createState() => _getExaminationpage();
}

class _getExaminationpage extends State<getExaminationpage> {
  var valueChoose;
  List listItem = ['Heart Cardiomegaley', 'Al-Zahimar', 'Gastro Intestinal'];

  String? _Zehimarprediction;
  String? _Cardioprediction;
  String? _Gastroprediction;
  String? _newprediction;

  Future<void> _classifyCardioImage() async {
    // Create a multipart request with the image file
    var requestCardio = http.MultipartRequest(
      'POST',
      Uri.parse('http://192.168.1.6:5000/api/classifyCardio/'),
    );
    requestCardio.files.add(await http.MultipartFile.fromPath(
        'imageCardio', selectedRayImage!.path));

    // Send the request and get the response
    var responseCardio = await requestCardio.send();
    var responseCardioBody = await responseCardio.stream.bytesToString();

    setState(() {
      _Cardioprediction = responseCardioBody;
      _newprediction = _Cardioprediction;
    });
  }

  Future<void> _classifyZehimarImage() async {
    // Create a multipart request with the image file
    var requestZehimar = http.MultipartRequest(
      'POST',
      Uri.parse('http://192.168.1.6:5000/api/classifyZehimar/'),
    );
    requestZehimar.files.add(await http.MultipartFile.fromPath(
        'imageZehimar', selectedRayImage!.path));

    // Send the request and get the response
    var responseZehimar = await requestZehimar.send();
    var responseZehimarBody = await responseZehimar.stream.bytesToString();

    setState(() {
      _Zehimarprediction = responseZehimarBody;
      _newprediction = _Zehimarprediction;
    });
  }

  Future<void> _classifyGastroImage() async {
    // Create a multipart request with the image file
    var requestGastro = http.MultipartRequest(
      'POST',
      Uri.parse('http://192.168.1.6:5000/api/classifyGastro/'),
    );
    requestGastro.files.add(await http.MultipartFile.fromPath(
        'imageGastro', selectedRayImage!.path));

    // Send the request and get the response0
    var responseGastro = await requestGastro.send();
    var responseGastroBody = await responseGastro.stream.bytesToString();

    setState(() {
      _Gastroprediction = responseGastroBody;
      _newprediction = _Gastroprediction;
    });
  }

  String imageRayUrl = '';
  String imageTechUrl = '';

  // saveimageandname(examinationname, examinationImage, TechnicianReport) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   preferences.setString("examinationName", examinationname);
  //   preferences.setString("examinationImage", examinationImage);
  //   preferences.setString("TechnicianReport", TechnicianReport);
  // }

  GlobalKey<FormState> key = GlobalKey();
  CollectionReference _reference =
  FirebaseFirestore.instance.collection('Examination');

  @override
  void initState() {
    super.initState();
    print("value of method in get examination iz $userInfo");
    userName = "${userInfo!['first name']} ${userInfo!['last name']}";
    userExaminations = userInfo!['examinations'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_outlined,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context) =>  HomeLayout() )));
            },
          ),
          actions: [
            Container(
              padding: EdgeInsets.only(
                right: 10,
                bottom: 3,
              ),
              child: Row(
                children: [
                  Image(
                    image: AssetImage("images/home_logo.png"),
                  ),
                ],
              ),
            )
          ],
          backgroundColor: Color.fromRGBO(0, 129, 201, 1)),
      body: SingleChildScrollView(
        child: Form(
          key: key,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                child: Text(
                  'Get an Examination',
                  style: TextStyle(
                      color: Color.fromRGBO(0, 129, 201, 1),
                      fontSize: 26,
                      fontWeight: FontWeight.w600),
                  //textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 30,
              ),

              Container(
                padding:
                EdgeInsets.only(top: 5, bottom: 5, left: 25, right: 25),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(5)),
                child: DropdownButton(
                    hint: Text(
                      'Choose Disease',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    dropdownColor: Colors.grey[300],
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 36,
                    //isExpanded: true,
                    underline: SizedBox(),
                    style: TextStyle(color: Colors.black, fontSize: 22),
                    value: valueChoose,
                    onChanged: (newValue) {
                      setState(() {
                        valueChoose = newValue;
                      });
                    },
                    items: listItem.map((valueItem) {
                      return DropdownMenuItem(
                        child: Text(
                          valueItem, //style: TextStyle(color: Colors.white),
                        ),
                        value: valueItem,
                      );
                    }).toList()),
              ),
              //  SizedBox(height: 15,),

              if (selectedRayImage != null)
                Container(
                    margin: EdgeInsets.all(20),
                    //color: Colors.blue[100],
                    color: Colors.white,
                    child: Image.file(
                      File(selectedRayImage!.path),
                      width: double.infinity,
                      fit: BoxFit.contain,
                    )),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 230,
                        height: 50,
                        child: MaterialButton(
                            color: Color.fromRGBO(0, 129, 201, 1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            onPressed: pickRayImage,
                            child: Text(
                              'Select X-Ray',
                              style: TextStyle(fontSize: 18,color: Colors.white),
                            ))),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      child: IconButton(
                          onPressed: isRayUploaded
                              ? null
                              : () async {
                            await uploadRayImage();
                          },
                          icon: isRayUploaded
                              ? Icon(Icons.done_outlined)
                              : isRayUploading
                              ? CircularProgressIndicator()
                              : Icon(Icons.file_upload_outlined)),
                    )
                  ],
                ),
              ),
              if (selectedTechImage != null)
                Container(
                    margin: EdgeInsets.all(20),
                    //color: Colors.blue[100],
                    color: Colors.white,
                    child: Image.file(
                      File(selectedTechImage!.path),
                      width: double.infinity,
                      fit: BoxFit.contain,
                    )),

              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                          width: 250,
                          height: 50,
                          child: MaterialButton(
                              color: Color.fromRGBO(0, 129, 201, 1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              onPressed: pickTechImage,
                              child: Text(
                                'Select Technican Report',
                                style: TextStyle(fontSize: 18,color: Colors.white),
                              ))),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Container(
                        child: IconButton(
                            onPressed: isTechUploaded
                                ? null
                                : () async {
                              await uploadTechImage();
                            },
                            icon: isTechUploaded
                                ? Icon(Icons.done_outlined)
                                : isTechUploading
                                ? CircularProgressIndicator()
                                : Icon(Icons.file_upload_outlined)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                width: 260,
                height: 50,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  color: Color.fromRGBO(91, 192, 248, 1),
                  child: Text(
                    'View Result',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  onPressed: () {
                    // saveimageandname(valueChoose, imageRayUrl, imageTechUrl);
                    if (imageRayUrl.isEmpty && imageTechUrl.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('please upload image')));
                      return;
                    }
                    if (key.currentState!.validate()) {
                      String diseaseName = valueChoose;
                      //create a Map of data
                      Map<String, String> dataToSend = {
                        'examinationName': diseaseName,
                        'examinationImage': imageRayUrl,
                        'TechnicianReport': imageTechUrl,
                        'Date':
                        "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
                        'DoctorReport': "",
                        'modelReport': "$_newprediction",
                        'patientName': userName,
                      };
                      // add new item
                      String examinationID = "";
                      _reference.add(dataToSend).then((value) {
                        examinationID = value.id;
                        print("user examination iz $userExaminations");
                        print("examination id iz $examinationID");
                        userExaminations.add(examinationID);
                        print("after adding iz $userExaminations");
                        FirebaseFirestore.instance
                            .collection("users")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .update({'examinations': userExaminations}).then(
                                (value) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ExaminationResult(
                                    data: dataToSend,
                                  ),
                                ),
                              );
                            });
                      });
                      //add examination ID to user examination IDs
                    }
                  },
                ),
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /* ----------------------------------------- */

// Ray files

  File? selectedRayImage;
  bool isRayUploading = false;
  bool isRayUploaded = false;

// select Ray files

  Future pickRayImage() async {
    final ImagePicker _ray = ImagePicker();
    final XFile? pickedRay_File =
    await _ray.pickImage(source: ImageSource.gallery);

    File imageRay = File(pickedRay_File!.path);

    if (pickedRay_File == null) {
      return;
    }

    setState(() {
      // Update the state with the selected image file
      selectedRayImage = imageRay;
      // _prediction = null;
      if (valueChoose == "Al-Zahimar") {
        _newprediction = _Zehimarprediction = null;
      } else if (valueChoose == "Heart Cardiomegaley") {
        _newprediction = _Cardioprediction = null;
      } else if (valueChoose == "Gastro Intestinal") {
        _newprediction = _Gastroprediction =  "null";
      }
    });
    if (valueChoose == "Al-Zahimar") {
      await _classifyZehimarImage();
    } else if (valueChoose == "Heart Cardiomegaley") {
      await _classifyCardioImage();
    } else if (valueChoose == "Gastro Intestinal") {
      await _classifyGastroImage();
    }

//  String uniqueFileName= DateTime.now().millisecondsSinceEpoch.toString();
  }
// Upload Ray files

  Future uploadRayImage() async {
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('uploaditemTry');

    //create a reference for the image to be stored

    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

    isRayUploading = true;
    //Handle errors/success

    try {
      // store the file

      await referenceImageToUpload.putFile(File(selectedRayImage!.path));
      //success: get the download url
      imageRayUrl = await referenceImageToUpload.getDownloadURL();

      setState(() {
        isRayUploading = false;
        isRayUploaded = true;
      });
    } catch (error) {
      //some error occurred
    }
  }

/* ----------------------------------------- */

// Tech files

  File? selectedTechImage;
  bool isTechUploading = false;
  bool isTechUploaded = false;

// select Tech files

  Future pickTechImage() async {
    final ImagePicker _teck = ImagePicker();
    final XFile? pickedTech_File =
    await _teck.pickImage(source: ImageSource.gallery);

    File imageTech = File(pickedTech_File!.path);

    if (pickedTech_File == null) {
      return;
    }

    setState(() {
      // Update the state with the selected image file
      selectedTechImage = imageTech;
    });
//  String uniqueFileName= DateTime.now().millisecondsSinceEpoch.toString();
  }

// Upload Tech files
  Future uploadTechImage() async {
    String uniqueTFileName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('uploaditemTry');

    //create a reference for the image to be stored

    Reference referenceImageToUpload =
    referenceDirImages.child(uniqueTFileName);

    isTechUploading = true;
    //Handle errors/success

    try {
      // store the file

      await referenceImageToUpload.putFile(File(selectedTechImage!.path));
      //success: get the download url
      imageTechUrl = await referenceImageToUpload.getDownloadURL();

      setState(() {
        isTechUploading = false;
        isTechUploaded = true;
      });
    } catch (error) {
      //some error occurred
    }
  }

/* ----------------------------------------- */
//* function used in View result button :
// send map of data {all data in get examination page : disease name & tech & ray }*//

// Future sendAlldataToFirebase () async{
//
// }
}
