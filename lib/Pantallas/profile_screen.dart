import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFef9c2), 
        title: Text(
          'Perfil',
          style: TextStyle(
            color: Color(0xFFfc98a4), 
          ),
        ),
      ),
      body: Container(
        color: Color(0xFFb1e1a3), 
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/profile_picture.png'), 
              ),
              SizedBox(height: 20),
              Text(
                'GOHAN', 
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFef9c2), 
                ),
              ),
              SizedBox(height: 10),
              Text(
                '@chirimoyaalegre2023', 
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFFFef9c2), 
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}