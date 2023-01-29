import 'package:fashion_ai/src/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fashion AI',
      theme: ThemeData(
          primarySwatch: Colors.blue
      ),
      home: const HomePage(),
    );
  }
}
