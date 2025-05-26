import 'package:flutter/material.dart';

class modelReport extends StatelessWidget {
  String ModelReport = "";

  modelReport({Key? key, required this.ModelReport}) : super(key: key);

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 150,
              left: 20,
              right: 20
            ),
            child: Column(
              children: [

                Text("Model report",
                    style: TextStyle(
                        color: Color.fromRGBO(0, 129, 201, 1), fontSize: 35)),
                SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                        border: Border.all(style: BorderStyle.solid)),
                    child: Column(
                      children: [
                        Text("\n$ModelReport\n",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Color.fromRGBO(34, 146, 208, 1))),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // Row(
                        //   children: [
                        //     Text(
                        //       "Status : UnStable",
                        //       style: TextStyle(
                        //           color: Color.fromRGBO(34, 146, 208, 1)),
                        //     )
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
