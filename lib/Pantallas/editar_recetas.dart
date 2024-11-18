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
    Navigator.pop(context);  // Regresa a la pantalla principal
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Receta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nombre de la receta'),
            ),
            TextField(
              controller: _ingredientsController,
              decoration: InputDecoration(labelText: 'Ingredientes'),
              maxLines: 4,
            ),
            TextField(
              controller: _preparationController,
              decoration: InputDecoration(labelText: 'Preparación'),
              maxLines: 4,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveChanges,
              child: Text('Guardar Cambios'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}