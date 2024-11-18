import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFef9c2),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/splash_logo.png', width: 600, height: 500),
            SizedBox(height: 20),
            Text(
              'Bienvenido a MeowCoffee',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}