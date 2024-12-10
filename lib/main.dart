import 'package:calculator_app/view/calculator_app_view.dart';
import 'package:flutter/material.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

@override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: ' Puja \'s Calculator App',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const CalculatorView(),
    );
  }
}