import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../shared/components/curve_cliper.dart';

class TechnicianReport extends StatelessWidget {
  String technicianReport = "";
  TechnicianReport({Key? key, required this.technicianReport})
      : super(key: key);

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

      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(children: [
          SizedBox(
            height: 40,
          ),
          Text(
            "Technician report",
            style: TextStyle(fontSize: 35, color: Color.fromRGBO(0, 129, 201, 1)),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(30),
            decoration:
                BoxDecoration(border: Border.all(style: BorderStyle.solid)),
            child: CachedNetworkImage(
              imageUrl: technicianReport,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        ])),
      ),
    );
  }
}
