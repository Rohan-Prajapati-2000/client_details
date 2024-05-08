import 'package:flutter/material.dart';

class SCustomCurevedEdge extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);

    final firstCurved = Offset(0, size.height-20);
    final lastCurved = Offset(30, size.height-20);
    path.quadraticBezierTo(firstCurved.dx, firstCurved.dy, lastCurved.dx, lastCurved.dy);

    final secondCurved = Offset(0, size.height-20);
    final secondLastCurved = Offset(size.width-30, size.height-20);
    path.quadraticBezierTo(secondCurved.dx, secondCurved.dy, secondLastCurved.dx, secondLastCurved.dy);

    final thirdCurved = Offset(size.width, size.height-20);
    final thirdLastCurved = Offset(size.width, size.height);
    path.quadraticBezierTo(thirdCurved.dx, thirdCurved.dy, thirdLastCurved.dx, thirdLastCurved.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;

  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }

}