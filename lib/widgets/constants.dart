import 'package:flutter/material.dart';

class Constants{
  final primaryColor = Color.fromARGB(255, 134, 107, 252);
  final secondaryColor = const Color(0xffa1c6fd);
  final tertiaryColor = const Color(0xff205cf1);
  final blackColor = const Color(0xff000000);

  final greyColor = const Color(0xffd9dadb);

  final Shader shader = const LinearGradient(
    colors: <Color>[Color(0xffABcff2), Color.fromARGB(255, 75, 111, 147)],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  final linearGradientBlue = const LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.topLeft,
    colors: <Color>[Color(0xffABcff2), Color.fromARGB(255, 75, 111, 147)],
    stops: [0.0, 1.0]  // 10% of the width, so there are ten blinds.

  );

  final linearGradientPurple = const LinearGradient(
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
    colors: [Color(0xff51087e), Color.fromARGB(255, 94, 67, 111)],
    stops: [0.0, 1.0]  // 10% of the width, so there are ten blinds.
    );
}