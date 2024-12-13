import 'package:mini_weather_app/ui/homePage.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'flutter Demo',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
}
}