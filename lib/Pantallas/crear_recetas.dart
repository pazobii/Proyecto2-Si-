import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class CrearRecetasScreen extends StatefulWidget {
  final Function(String name, String category, String ingredients, String preparation, String imagePath) onAddRecipe;

  CrearRecetasScreen({required this.onAddRecipe});

  @override
  _CrearRecetasScreenState createState() => _CrearRecetasScreenState();
}

class _CrearRecetasScreenState extends State<CrearRecetasScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ingredientsController = TextEditingController();
  final TextEditingController preparationController = TextEditingController();
  String jsonPath = '';
  String selectedCategory = 'Caliente';
  CameraController? _cameraController;
  XFile? _capturedImage;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    
    final cameras = await availableCameras();
    _cameraController = CameraController(cameras.first, ResolutionPreset.medium);
    await _cameraController!.initialize();
    setState(() {});
  }

  Future<void> _captureImage() async {
    if (_cameraController != null && _cameraController!.value.isInitialized) {
      XFile image = await _cameraController!.takePicture();
      setState(() {
        _capturedImage = image;
      });
    }
  }

  Future<void> GetPath() async{
    final direct = await getApplicationDocumentsDirectory();
    jsonPath = '${direct.path}/receta.json';
  }

  Future<void> _saveRecipe() async{
    final direct = Directory.current;
    print('Direct:$direct');
    jsonPath = 'receta.json';
    widget.onAddRecipe(
      nameController.text,
      selectedCategory,
      ingredientsController.text,
      preparationController.text,
      _capturedImage?.path ?? 'assets/images/splash_logo.png', 
    );

    final file = File('${direct.path}/$jsonPath');
    if(await file.exists())
    {
      final String content = await file.readAsString();
      final List<dynamic> data = jsonDecode(content);

      final Map<String, dynamic> newData ={
            "name": nameController.text,
            "category": selectedCategory,
            "ingredients": ingredientsController.text,
            "preparation": preparationController.text,
            "image": _capturedImage?.path ?? 'assets/images/splash_logo.png'
      };

      data.add(newData);

      final String jsonString = jsonEncode(data);
      await file.writeAsString(jsonString);

    }
    else
    {
      List<Map<String, dynamic>> data = [
        {
          "name": nameController.text,
          "category": selectedCategory,
          "ingredients": ingredientsController.text,
          "preparation": preparationController.text,
          "image": _capturedImage?.path ?? 'assets/images/splash_logo.png'
        }
      ];

      final String jsonString = jsonEncode(data);
      await file.writeAsString(jsonString);
    }
    print('Path:$jsonPath');
    //Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFb1e1a3),
      appBar: AppBar(
        backgroundColor: Color(0xFFFef9c2),
        title: Text('Crear Nueva Receta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            DropdownButton<String>(
              value: selectedCategory,
              items: ['Caliente', 'Helado'].map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
            ),
            TextField(
              controller: ingredientsController,
              decoration: InputDecoration(labelText: 'Ingredientes'),
              maxLines: 3,
            ),
            TextField(
              controller: preparationController,
              decoration: InputDecoration(labelText: 'Preparación'),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            _cameraController != null && _cameraController!.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _cameraController!.value.aspectRatio,
                    child: CameraPreview(_cameraController!),
                  )
                : CircularProgressIndicator(),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _captureImage,
              child: Text('Tomar Foto'),
            ),
            _capturedImage != null
                ? Image.file(
                    File(_capturedImage!.path),
                    width: 100,
                    height: 100,
                  )
                : Container(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveRecipe,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFfc98a4),
              ),
              child: Text('Guardar Receta'),
            ),
          ],
        ),
      ),
    );
  }
}