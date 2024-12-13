import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import '../dialogs.dart'; // Importamos el archivo del carrusel.

class CrearRecetasScreen extends StatefulWidget {
  final Function(String name, String category, String ingredients, String preparation, String imagePath) onAddRecipe;

  CrearRecetasScreen({required this.onAddRecipe});

  @override
  _CrearRecetasScreenState createState() => _CrearRecetasScreenState();
}

class _CrearRecetasScreenState extends State<CrearRecetasScreen> {
  final TextEditingController nameController = TextEditingController();

  String? selectedIngredient;
  String selectedCategory = 'Caliente'; // Categoría por defecto
  String? selectedStep;
  CameraController? _cameraController;
  XFile? _capturedImage;

  List<String> availableIngredients = [
    "Café molido",
    "Leche",
    "Azúcar",
    "Canela",
    "Chocolate",
    "Hielo",
    "Jarabe de vainilla",
  ];

  List<String> selectedIngredients = [];
  List<String> preparationSteps = [];
  List<String> availableSteps = [
    "Colocar agua hervida",
    "Calentar la leche",
    "Agregar azúcar",
    "Mezclar los ingredientes",
    "Servir en taza",
  ];

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

  void addCustomIngredient(String ingredient) {
    setState(() {
      if (!availableIngredients.contains(ingredient)) {
        availableIngredients.add(ingredient);
      }
      selectedIngredients.add(ingredient);
    });
  }

  void addCustomStep(String step) {
    setState(() {
      if (!availableSteps.contains(step)) {
        availableSteps.add(step);
      }
      preparationSteps.add(step);
    });
  }

  Future<void> _captureImage() async {
    if (_cameraController != null && _cameraController!.value.isInitialized) {
      XFile image = await _cameraController!.takePicture();
      setState(() {
        _capturedImage = image;
      });
    }
  }

  Future<void> _saveRecipe() async {
    widget.onAddRecipe(
      nameController.text,
      selectedCategory,
      selectedIngredients.join(", "),
      preparationSteps.join(", "),
      _capturedImage?.path ?? 'assets/images/splash_logo.png',
    );

    final directory = await getApplicationDocumentsDirectory();
    final jsonPath = '${directory.path}/receta.json';
    final file = File(jsonPath);

    if (await file.exists()) {
      final String content = await file.readAsString();
      final List<dynamic> data = jsonDecode(content);

      final Map<String, dynamic> newData = {
        "name": nameController.text,
        "category": selectedCategory,
        "ingredients": selectedIngredients.join(", "),
        "preparation": preparationSteps.join(", "),
        "image": _capturedImage?.path ?? 'assets/images/splash_logo.png'
      };

      data.add(newData);
      final String jsonString = jsonEncode(data);
      await file.writeAsString(jsonString);
    } else {
      final List<Map<String, dynamic>> data = [
        {
          "name": nameController.text,
          "category": selectedCategory,
          "ingredients": selectedIngredients.join(", "),
          "preparation": preparationSteps.join(", "),
          "image": _capturedImage?.path ?? 'assets/images/splash_logo.png'
        }
      ];

      final String jsonString = jsonEncode(data);
      await file.writeAsString(jsonString);
    }
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
        title: Text("Crear Nueva Receta"),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              // Lista de pasos para el carrusel
              List<String> createRecipeSteps = [
                "Ingresa el nombre de la receta.",
                "Selecciona la categoría: Caliente, Helado o Postre.",
                "Añade los ingredientes usando la lista o agrega nuevos.",
                "Especifica los pasos de preparación y personalízalos.",
                "Toma una foto y guarda la receta.",
              ];

              showCarouselDialog(context, "Cómo crear una receta", createRecipeSteps);
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Nombre'),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Categoría: ",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    DropdownButton<String>(
                      value: selectedCategory,
                      items: ['Caliente', 'Helado', 'postres'].map((String category) {
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
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Ingredientes: ",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    DropdownButton<String>(
                      value: selectedIngredient,
                      hint: Text("Selecciona un ingrediente"),
                      items: availableIngredients.map((String ingredient) {
                        return DropdownMenuItem<String>(
                          value: ingredient,
                          child: Text(ingredient),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          selectedIngredient = value!;
                          if (!selectedIngredients.contains(value)) {
                            selectedIngredients.add(value);
                          }
                        });
                      },
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        final customIngredientController = TextEditingController();
                        return AlertDialog(
                          title: Text("Agregar Ingrediente"),
                          content: TextField(
                            controller: customIngredientController,
                            decoration: InputDecoration(labelText: "Ingrediente"),
                          ),
                          actions: [
                            TextButton(
                              child: Text("Cancelar"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text("Agregar"),
                              onPressed: () {
                                final ingredient = customIngredientController.text;
                                if (ingredient.isNotEmpty) {
                                  addCustomIngredient(ingredient);
                                }
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text("Agregar otro ingrediente"),
                ),
                Wrap(
                  spacing: 10,
                  children: selectedIngredients.map((ingredient) {
                    return Chip(
                      label: Text(ingredient),
                      onDeleted: () {
                        setState(() {
                          selectedIngredients.remove(ingredient);
                        });
                      },
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Preparación: ",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    DropdownButton<String>(
                      value: selectedStep,
                      hint: Text("Selecciona un paso"),
                      items: availableSteps.map((String step) {
                        return DropdownMenuItem<String>(
                          value: step,
                          child: Text(step),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          selectedStep = value!;
                          if (!preparationSteps.contains(value)) {
                            preparationSteps.add(value);
                          }
                        });
                      },
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        final customStepController = TextEditingController();
                        return AlertDialog(
                          title: Text("Agregar Paso"),
                          content: TextField(
                            controller: customStepController,
                            decoration: InputDecoration(labelText: "Paso"),
                          ),
                          actions: [
                            TextButton(
                              child: Text("Cancelar"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text("Agregar"),
                              onPressed: () {
                                final step = customStepController.text;
                                if (step.isNotEmpty) {
                                  addCustomStep(step);
                                }
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text("Agregar otro paso"),
                ),
                Wrap(
                  spacing: 10,
                  children: preparationSteps.map((step) {
                    return Chip(
                      label: Text(step),
                      onDeleted: () {
                        setState(() {
                          preparationSteps.remove(step);
                        });
                      },
                    );
                  }).toList(),
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
        ),
      ),
    );
  }
}
