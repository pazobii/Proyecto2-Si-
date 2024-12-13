import 'package:flutter/material.dart';

class EditarRecetasScreen extends StatefulWidget {
  final String recipeName;
  final String category;
  final String ingredients;
  final String preparation;
  final Function(String, String, String, String) onSave;

  EditarRecetasScreen({
    required this.recipeName,
    required this.category,
    required this.ingredients,
    required this.preparation,
    required this.onSave,
  });

  @override
  _EditarRecetasScreenState createState() => _EditarRecetasScreenState();
}

class _EditarRecetasScreenState extends State<EditarRecetasScreen> {
  late TextEditingController _nameController;
  late TextEditingController _ingredientsController;
  late TextEditingController _preparationController;
  late String _category;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.recipeName);
    _ingredientsController = TextEditingController(text: widget.ingredients);
    _preparationController = TextEditingController(text: widget.preparation);
    _category = widget.category;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ingredientsController.dispose();
    _preparationController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    widget.onSave(
      _nameController.text,
      _category,
      _ingredientsController.text,
      _preparationController.text,
    );
    Navigator.pop(context); // Regresa a la pantalla principal
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFb1e1a3), // Fondo verde
      appBar: AppBar(
        backgroundColor: Color(0xFFFef9c2), // Fondo amarillo
        title: Text(
          'Editar Receta',
          style: TextStyle(color: Color(0xFFb1e1a3)), // Letras verdes
        ),
        iconTheme: IconThemeData(color: Color(0xFFb1e1a3)), // Íconos verdes
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nombre de la receta',
                  labelStyle: TextStyle(color: Color(0xFFFef9c2)), // Amarillo
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFef9c2)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFef9c2)),
                  ),
                ),
                style: TextStyle(color: Color(0xFFFef9c2)), // Texto amarillo
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _category,
                items: ['Caliente', 'Helado', 'Postres']
                    .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(
                            category,
                            style: TextStyle(color: Color(0xFFb1e1a3)), // Verde
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _category = value!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Categoría',
                  labelStyle: TextStyle(color: Color(0xFFFef9c2)), // Amarillo
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFef9c2)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFef9c2)),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _ingredientsController,
                decoration: InputDecoration(
                  labelText: 'Ingredientes',
                  labelStyle: TextStyle(color: Color(0xFFFef9c2)), // Amarillo
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFef9c2)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFef9c2)),
                  ),
                ),
                maxLines: 4,
                style: TextStyle(color: Color(0xFFFef9c2)), // Texto amarillo
              ),
              SizedBox(height: 20),
              TextField(
                controller: _preparationController,
                decoration: InputDecoration(
                  labelText: 'Preparación',
                  labelStyle: TextStyle(color: Color(0xFFFef9c2)), // Amarillo
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFef9c2)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFef9c2)),
                  ),
                ),
                maxLines: 4,
                style: TextStyle(color: Color(0xFFFef9c2)), // Texto amarillo
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: _saveChanges,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFfc98a4), // Fondo rosado
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                child: Center(
                  child: Text(
                    'Guardar Cambios',
                    style: TextStyle(
                      color: Color(0xFFFef9c2), // Letras amarillas
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFfc98a4), // Fondo rojo
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                child: Center(
                  child: Text(
                    'Cancelar',
                    style: TextStyle(
                      color: Colors.white, // Letras blancas
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
