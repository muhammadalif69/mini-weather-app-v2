import 'package:flutter/material.dart';

class Constants {
  final primaryColor = Color.fromARGB(255, 134, 107, 252);
  final secondarycolor = const Color(0xffa1c6fd);
  final tertiarycolor = const Color(0xff205cf1);
  final blackcolor = const Color(0xff000000);

  final greycolor = const Color(0xffd9dadb);

  final Shader shader = const LinearGradient(
    colors: <Color> [Color (0xffABcff2), Color.fromARGB(255, 75, 111, 147)],
    ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  final linearGradientBlue = const LinearGradient(colors: <Color>[Color.fromARGB(255, 151, 198, 245), Color.fromARGB(255, 221, 203, 231)],
  begin:Alignment.topRight,
  end:Alignment.topLeft,
  stops:[0.0, 1.0]

  );

  final linearGradientPurple = const LinearGradient(
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
    colors:[Color(0xff51087e),Color.fromARGB(255, 123, 2, 199)],
    stops:[0.0, 1.0]);
}