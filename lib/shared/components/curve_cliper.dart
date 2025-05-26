import 'package:flutter/material.dart';

class CurveCliper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
   Path p = Path();
   p.lineTo(0, size.height);
   p.quadraticBezierTo(0.2*size.width, size.height, size.width*0.2, size.height/2);
   p.quadraticBezierTo(size.width*0.2, size.height, size.width, size.height);
   p.lineTo(size.width, 0);
   p.close();
   return p;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip;
    return false;
  }

}