import 'package:flutter/material.dart';
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

  Future<void> _saveRecipe() async {
    widget.onAddRecipe(
      nameController.text,
      selectedCategory,
      selectedIngredients.join(", "),
      preparationSteps.join(", "),
      'assets/images/splash_logo.png', // Imagen por defecto
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
        "image": 'assets/images/splash_logo.png'
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
          "image": 'assets/images/splash_logo.png'
        }
      ];

      final String jsonString = jsonEncode(data);
      await file.writeAsString(jsonString);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFb1e1a3),
      appBar: AppBar(
        backgroundColor: Color(0xFFFef9c2),
        title: Text(
          "Crear Nueva Receta",
          style: TextStyle(color: Color(0xFFfc98a4)),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline, color: Color(0xFFfc98a4)),
            onPressed: () {
              List<String> createRecipeSteps = [
                "Ingresa el nombre de la receta.",
                "Selecciona la categoría: Caliente, Helado o Postre.",
                "Añade los ingredientes usando la lista o agrega nuevos.",
                "Especifica los pasos de preparación y personalízalos.",
              ];

              showCarouselDialog(context, "Cómo crear una receta", createRecipeSteps);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20), // Espacio superior uniforme
              Text(
                "Nombre:",
                style: TextStyle(fontSize: 16, color: Color(0xFFFef9c2), fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Ingresa el nombre de la receta',
                  labelStyle: TextStyle(color: Color(0xFFFef9c2)),
                ),
                style: TextStyle(color: Color(0xFFFef9c2)),
              ),
              SizedBox(height: 30), // Espaciado uniforme entre secciones
              Text(
                "Categoría:",
                style: TextStyle(fontSize: 16, color: Color(0xFFFef9c2), fontWeight: FontWeight.bold),
              ),
              DropdownButton<String>(
                value: selectedCategory,
                items: ['Caliente', 'Helado', 'Postres'].map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category, style: TextStyle(color: Color(0xFFFef9c2))),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedCategory = value!;
                  });
                },
                dropdownColor: Color(0xFFfc98a4),
              ),
              SizedBox(height: 30),
              Text(
                "Ingredientes:",
                style: TextStyle(fontSize: 16, color: Color(0xFFFef9c2), fontWeight: FontWeight.bold),
              ),
              DropdownButton<String>(
                value: selectedIngredient,
                hint: Text("Selecciona un ingrediente", style: TextStyle(color: Color(0xFFFef9c2))),
                items: availableIngredients.map((String ingredient) {
                  return DropdownMenuItem<String>(
                    value: ingredient,
                    child: Text(ingredient, style: TextStyle(color: Color(0xFFFef9c2))),
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
                dropdownColor: Color(0xFFfc98a4),
              ),
              TextButton(
                onPressed: () {
                  final customIngredientController = TextEditingController();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Color(0xFFfc98a4),
                        title: Text("Agregar Ingrediente", style: TextStyle(color: Color(0xFFFef9c2))),
                        content: TextField(
                          controller: customIngredientController,
                          decoration: InputDecoration(
                            labelText: "Ingrediente",
                            labelStyle: TextStyle(color: Color(0xFFFef9c2)),
                          ),
                          style: TextStyle(color: Color(0xFFFef9c2)),
                        ),
                        actions: [
                          TextButton(
                            child: Text("Cancelar", style: TextStyle(color: Color(0xFFFef9c2))),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text("Agregar", style: TextStyle(color: Color(0xFFFef9c2))),
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
                child: Text("Agregar otro ingrediente", style: TextStyle(color: Color(0xFFFef9c2))),
                style: TextButton.styleFrom(
                  backgroundColor: Color(0xFFfc98a4),
                ),
              ),
              Wrap(
                spacing: 10,
                children: selectedIngredients.map((ingredient) {
                  return Chip(
                    label: Text(ingredient, style: TextStyle(color: Color(0xFFFef9c2))),
                    backgroundColor: Color(0xFFfc98a4),
                    onDeleted: () {
                      setState(() {
                        selectedIngredients.remove(ingredient);
                      });
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 30),
              Text(
                "Preparación:",
                style: TextStyle(fontSize: 16, color: Color(0xFFFef9c2), fontWeight: FontWeight.bold),
              ),
              DropdownButton<String>(
                value: selectedStep,
                hint: Text("Selecciona un paso", style: TextStyle(color: Color(0xFFFef9c2))),
                items: availableSteps.map((String step) {
                  return DropdownMenuItem<String>(
                    value: step,
                    child: Text(step, style: TextStyle(color: Color(0xFFFef9c2))),
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
                dropdownColor: Color(0xFFfc98a4),
              ),
              TextButton(
                onPressed: () {
                  final customStepController = TextEditingController();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Color(0xFFfc98a4),
                        title: Text("Agregar Paso", style: TextStyle(color: Color(0xFFFef9c2))),
                        content: TextField(
                          controller: customStepController,
                          decoration: InputDecoration(
                            labelText: "Paso",
                            labelStyle: TextStyle(color: Color(0xFFFef9c2)),
                          ),
                          style: TextStyle(color: Color(0xFFFef9c2)),
                        ),
                        actions: [
                          TextButton(
                            child: Text("Cancelar", style: TextStyle(color: Color(0xFFFef9c2))),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text("Agregar", style: TextStyle(color: Color(0xFFFef9c2))),
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
                child: Text("Agregar otro paso", style: TextStyle(color: Color(0xFFFef9c2))),
                style: TextButton.styleFrom(
                  backgroundColor: Color(0xFFfc98a4),
                ),
              ),
              Wrap(
                spacing: 10,
                children: preparationSteps.map((step) {
                  return Chip(
                    label: Text(step, style: TextStyle(color: Color(0xFFFef9c2))),
                    backgroundColor: Color(0xFFfc98a4),
                    onDeleted: () {
                      setState(() {
                        preparationSteps.remove(step);
                      });
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveRecipe,
                child: Text('Guardar Receta', style: TextStyle(color: Color(0xFFFef9c2))),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFfc98a4),
                ),
              ),
              SizedBox(height: 30), // Espaciado inferior
            ],
          ),
        ),
      ),
    );
  }
}
