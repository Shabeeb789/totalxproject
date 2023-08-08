import 'package:flutter/material.dart';

class Responsive {
  static double height(int height, BuildContext context) {
    return MediaQuery.of(context).size.height * (height / 812);
  }

  static double width(int width, BuildContext context) {
    return MediaQuery.of(context).size.width * (width / 375);
  }
}
