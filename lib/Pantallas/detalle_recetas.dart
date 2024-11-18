import 'package:flutter/material.dart';
import 'dart:io';

class DetalleRecetasScreen extends StatelessWidget {
  final String recipeName;
  final String image;
  final String ingredients;
  final String preparation;

  DetalleRecetasScreen({
    required this.recipeName,
    required this.image,
    required this.ingredients,
    required this.preparation,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFfef9c2), 
      appBar: AppBar(
        backgroundColor: Color(0xFFfef9c2),
        title: Text(
          recipeName,
          style: TextStyle(color: Color(0xFFfc98a4)), 
        ),
        iconTheme: IconThemeData(color: Color(0xFFfc98a4)), 
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: _displayImage(),
            ),
            SizedBox(height: 16),
            Text(
              'Nombre: $recipeName',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFfc98a4)), 
            ),
            SizedBox(height: 16),
            Text(
              'Ingredientes:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFfc98a4)), 
            ),
            Text(
              ingredients,
              style: TextStyle(color: Color(0xFFfc98a4)),
            ),
            SizedBox(height: 16),
            Text(
              'Preparación:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFfc98a4)), 
            ),
            Text(
              preparation,
              style: TextStyle(color: Color(0xFFfc98a4)), 
            ),
          ],
        ),
      ),
    );
  }

  Widget _displayImage() {
    return image.startsWith('/')
        ? Image.file(
            File(image),
            width: 150,
            height: 150,
            fit: BoxFit.cover,
          )
        : Image.asset(
            image,
            width: 150,
            height: 150,
            fit: BoxFit.cover,
          );
  }
}