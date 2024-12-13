import 'package:flutter/material.dart';
import 'detalle_recetas.dart';

class ListaRecetasScreen extends StatelessWidget {
  final List<Map<String, dynamic>> hotCoffees;
  final List<Map<String, dynamic>> coldCoffees;
  final List<Map<String, dynamic>> desserts;

  ListaRecetasScreen({
    required this.hotCoffees,
    required this.coldCoffees,
    required this.desserts,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFb1e1a3),
      appBar: AppBar(
        backgroundColor: Color(0xFFFef9c2),
        title: Text(
          'Listado de Recetas',
          style: TextStyle(color: Color(0xFFfc98a4)),
        ),
      ),
      body: ListView(
        children: [
          _buildRecipeSection('Calientes', hotCoffees, context),
          _buildRecipeSection('Helados', coldCoffees, context),
          _buildRecipeSection('Postres', desserts, context),
        ],
      ),
    );
  }

  Widget _buildRecipeSection(String title, List<Map<String, dynamic>> recipes, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFFfc98a4),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              final recipe = recipes[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 5),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                color: Color(0xFFFef9c2),
                child: ListTile(
                  contentPadding: EdgeInsets.all(10),
                  leading: Image.asset(
                    recipe['imageRoute'] ?? 'assets/images/splash_logo.png',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    recipe['name']!,
                    style: TextStyle(color: Color(0xFFfc98a4)),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetalleRecetasScreen(
                          recipeName: recipe['name']!,
                          image: recipe['imageRoute'] ?? 'assets/images/splash_logo.png',
                          ingredients: recipe['ingredients']!,
                          preparation: recipe['preparation']!,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
