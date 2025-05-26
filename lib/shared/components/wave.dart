import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'curve_cliper.dart';

class curve extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CurveCliper(),
      child: Container(
        color: Color.fromRGBO(0,129,201,1),
        // child: Row(
        //   children: [
        //     // Expanded(child: Column(
        //     //   crossAxisAlignment: CrossAxisAlignment.start,
        //     //   children: [
        //     //     IconButton(onPressed: (){}, icon: Icon(Icons.menu,)),
        //     //   ],
        //     // ),flex: 2),
        //     // Expanded(child: Column(
        //     //   crossAxisAlignment: CrossAxisAlignment.end,
        //     //   children: [
        //     //     Image(image: AssetImage("images/home_logo.png"),height: 100,width: 150),
        //     //   ],
        //     // ),),

        //   ],
        // ),
      ),
    );
  }
}