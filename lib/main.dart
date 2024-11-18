import 'dart:async';
import 'package:flutter/material.dart';
import 'Pantallas/main_screen.dart';
import 'Pantallas/splashscreen.dart'; 

void main() {
  runApp(MeowCoffeeApp());
}

class MeowCoffeeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MeowCoffee',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: SplashScreenWithDelay(), 
    );
  }
}

class SplashScreenWithDelay extends StatefulWidget {
  @override
  _SplashScreenWithDelayState createState() => _SplashScreenWithDelayState();
}

class _SplashScreenWithDelayState extends State<SplashScreenWithDelay> {
  @override
  void initState() {
    super.initState();
    // 3 segundos
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}