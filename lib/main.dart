// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:greenifytransitcodefest/social_page.dart';
import 'package:greenifytransitcodefest/routes_planner.dart';
void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: RoutesPlanner(),
    );
  }
}
