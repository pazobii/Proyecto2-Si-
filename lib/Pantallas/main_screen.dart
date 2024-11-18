import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart'; 
import 'package:share_plus/share_plus.dart';
import 'detalle_recetas.dart';
import 'crear_recetas.dart';
import 'profile_screen.dart';
import 'listado_recetas.dart';
import 'comunidad_screen.dart';


class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Map<String, dynamic>> hotCoffees = [
    {
      'name': 'Espresso',
      'image': 'assets/images/Espresso.png',
      'ingredients': 'Agua y café molido',
      'preparation': 'Pasar el agua caliente a presión a través de café molido, para producir una bebida fuerte en el interior y cremosa en la parte superior.',
    },
    {
      'name': 'Capuccino',
      'image': 'assets/images/Capuccino.png',
      'ingredients': 'Espresso, leche al vapor y azúcar',
      'preparation': 'Primero, prepara un espresso. Luego, calienta y espuma la leche con una máquina de vapor hasta que esté cremosa. Vierte la leche espumada sobre el espresso, dejando una capa de espuma en la parte superior. Agregar azúcar al gusto!!!!.',
    },
    {
      'name': 'Americano',
      'image': 'assets/images/Americano.png',
      'ingredients': 'Espresso y agua caliente',
      'preparation': 'Prepara un espresso y, luego, agrega agua caliente al gusto (aproximadamente el doble del volumen del espresso). Esto diluye el café, creando una bebida más suave y de mayor volumen que un espresso, pero con el mismo sabor base.',
    },
    {
      'name': 'Cortado',
      'image': 'assets/images/Cortado.png',
      'ingredients': 'Espresso y leche caliente',
      'preparation': 'Prepara un espresso y, luego, agrega una pequeña cantidad de leche caliente (generalmente la misma cantidad o un poco menos que el espresso). La leche suaviza el sabor fuerte del espresso, creando una bebida equilibrada con un toque cremoso.',
    },
    {
      'name': 'Flat white',
      'image': 'assets/images/FlatWhite.png',
      'ingredients': 'Espresso y leche vaporizada',
      'preparation': 'Prepara un espresso y, luego, agrega leche vaporizada, pero sin mucha espuma, de manera que la leche tenga una textura suave y cremosa. La proporción de leche es mayor que en un cortado, creando una bebida suave, cremosa y con un sabor más equilibrado entre el café y la leche.',
    },
    {
      'name': 'Latte',
      'image': 'assets/images/Latte.png',
      'ingredients': '1 espresso, leche vaporizada y espuma de leche',
      'preparation': 'Prepara un espresso y, luego, agrega leche vaporizada, dejando una pequeña capa de espuma en la parte superior. El latte tiene una mayor cantidad de leche que un cappuccino, lo que lo hace más suave y cremoso, con un sabor más equilibrado entre el café y la leche.',
    },
    {
      'name': 'Machiatto',
      'image': 'assets/images/Machiatto.png',
      'ingredients': '1 espresso, leche vaporizada o espuma de leche',
      'preparation': 'Prepara un espresso y, luego, agrega una pequeña cantidad de leche vaporizada o espuma de leche sobre el café, justo en el centro. El macchiato tiene un sabor fuerte a café, con solo un toque de leche, a diferencia de otros cafés con más leche, como el latte. "Macchiato" significa "manchado", ya que la leche solo "mancha" el espresso.',
    },
     {
      'name': 'Mocha',
      'image': 'assets/images/Mocha.png',
      'ingredients': '1 espresso, 150 ml de leche vaporizada, 2 cucharadas de jarabe de chocolate y crema batida (opcional)',
      'preparation': 'Prepara un espresso y mezcla con el jarabe de chocolate hasta que se disuelva bien. Luego, agrega la leche vaporizada, creando una mezcla suave y cremosa. Si lo deseas, puedes coronar con crema batida para darle un toque extra. El mocha combina el sabor fuerte del café con la dulzura del chocolate, creando una bebida indulgente y deliciosa.',
    },
  ];

  final List<Map<String, dynamic>> coldCoffees = [
    {
      'name': 'Americano frío',
      'image': 'assets/images/AmericanoFrio.png',
      'ingredients': 'Agua, hielo y espresso',
      'preparation': 'Prepara un espresso y déjalo enfriar un poco. Llena un vaso con hielo y vierte el espresso frío sobre el hielo. Luego, agrega agua fría al gusto y mezcla bien. Esto crea una versión refrescante y fría del café americano.',
    },
    {
      'name': 'Affogato',
      'image': 'assets/images/Affogato.png',
      'ingredients': '1 bola de helado de vainilla y un espresso caliente',
      'preparation': 'Coloca una bola de helado de vainilla en un vaso o copa. Luego, vierte un espresso caliente por encima del helado. La combinación de la temperatura del espresso con el helado crea una mezcla deliciosa y cremosa.',
    },
    {
      'name': 'Latte frío',
      'image': 'assets/images/LatteFrio.png',
      'ingredients': '1 espresso, leche fría y hielo',
      'preparation': 'Prepara un espresso y déjalo enfriar. Llena un vaso con hielo y vierte el espresso frío sobre el hielo. Luego, agrega leche fría al gusto y mezcla bien. Si lo deseas, puedes añadir azúcar para endulzar. Esto crea una versión refrescante del latte, perfecta para días calurosos.',
    },
    {
      'name': 'Mocha frío',
      'image': 'assets/images/MochaFrio.png',
      'ingredients': '1 espresso, 2 cucharadas de jarabe de chocolate, leche fría. hielo y crema batida (opcional)',
      'preparation': 'Prepara un espresso y déjalo enfriar. En un vaso grande, mezcla el espresso frío con el jarabe de chocolate. Luego, llena el vaso con hielo y agrega leche fría al gusto. Mezcla bien y, si lo deseas, cubre con crema batida para darle un toque extra. El mocha frío es una bebida refrescante que combina el sabor del café con chocolate y leche fría.',
    },
  ];

  String searchText = '';
  TextEditingController searchController = TextEditingController();

  void shareRecipe(String recipe) {
    Share.share('Check out this recipe: $recipe');
  }

  List<Map<String, dynamic>> get filteredHotCoffees {
    if (searchText.isEmpty) {
      return hotCoffees;
    } else {
      return hotCoffees
          .where((coffee) =>
              coffee['name']!.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    }
  }

  List<Map<String, dynamic>> get filteredColdCoffees {
    if (searchText.isEmpty) {
      return coldCoffees;
    } else {
      return coldCoffees
          .where((coffee) =>
              coffee['name']!.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    }
  }

  Future<void> _findSavedRecipes() async {
  final String direct = Directory.current.path;
  final file = File('${direct}/receta.json');
  if (await file.exists()) {
    final String content = await file.readAsString();
    final List<dynamic> data = jsonDecode(content);

    setState(() {
      for (Map<String, dynamic> recipe in data) {
        if (recipe.containsKey('category')) {
          if (recipe['category'] == 'Caliente') {
            if (!hotCoffees.any((existingRecipe) => existingRecipe['name'] == recipe['name'])) {
              hotCoffees.add(recipe);
            }
          } else if (recipe['category'] == 'Helado') {
            if (!coldCoffees.any((existingRecipe) => existingRecipe['name'] == recipe['name'])) {
              coldCoffees.add(recipe);
            }
          }
        } else {
          print("Receta sin categoría: ${recipe['name']}");
        }
      }
    });
  }
}

 Future<void> _saveRecipes() async {
  final String direct = Directory.current.path;
  final file = File('${direct}/receta.json');
  List<dynamic> data;

  if (await file.exists()) {
    final String content = await file.readAsString();
    data = jsonDecode(content);
  } else {
    data = List.empty();
  }

  List<Map<String, dynamic>> toAdd = [];

  for (Map<String, dynamic> hot in hotCoffees) {
    bool exists = data.any((recipe) => recipe['name'] == hot['name']);
    if (!exists) {
      toAdd.add(hot);
    }
  }

  for (Map<String, dynamic> cold in coldCoffees) {
    bool exists = data.any((recipe) => recipe['name'] == cold['name']);
    if (!exists) {
      toAdd.add(cold);
    }
  }

  data.addAll(toAdd);

  final String jsonString = jsonEncode(data);
  await file.writeAsString(jsonString);
}


  @override
  void initState()
  {
    super.initState();
    _findSavedRecipes();
  }

  // AGREGAR UNA RECETA
  void _addRecipe(String name, String category, String ingredients, String preparation, String imagePath) {
    final newRecipe = {
      'name': name,
      'image': imagePath,
      'ingredients': ingredients,
      'preparation': preparation,
    };
    
    setState(() {
      if (category == 'Caliente') {
        hotCoffees.add(newRecipe);
      } else if (category == 'Helado') {
        coldCoffees.add(newRecipe);
      }
    });
  }

/*
  Future<void> _removeFromJson(String name, String category) async
  {
    final String direct = Directory.current.path;
    final file = File('${direct}/receta.json');
    List<dynamic> data;

    if(await file.exists())
    {
      final String content = await file.readAsString();
      data = jsonDecode(content);

      for(Map<String,dynamic> recipe in data)
      {
        if(recipe['name'] == name && recipe['category'] == category)
        {
          data.remove(recipe);
          break;
        }
      }
      final String jsonString = jsonEncode(data);
      await file.writeAsString(jsonString);
}
}
*/

  // ELIMINAR RECETA
  void _deleteRecipe(String name, String category) {
    setState(() {
      if (category == 'Caliente') {
        hotCoffees.removeWhere((coffee) => coffee['name'] == name);
      } else if (category == 'Helado') {
        coldCoffees.removeWhere((coffee) => coffee['name'] == name);
      }
      //_removeFromJson(name, category);
      _saveRecipes();
    });
  }

  // MCUADRO DIALOGO ELIMINAR RECETA
  void _showDeleteDialog(String name, String category) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('¿Deseas eliminar la receta?'),
          content: Text('Esta acción no se puede deshacer.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo sin eliminar
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                _deleteRecipe(name, category); // Eliminar la receta
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
              child: Text('Eliminar'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        );
      },
    );
  }
  void _editRecipe(String name, String category, String newName, String newIngredients, String newPreparation, String newImagePath) {
    setState(() {
      if (category == 'Caliente') {
        var recipe = hotCoffees.firstWhere((coffee) => coffee['name'] == name);
        recipe['name'] = newName;
        recipe['ingredients'] = newIngredients;
        recipe['preparation'] = newPreparation;
        recipe['image'] = newImagePath;
      } else if (category == 'Helado') {
        var recipe = coldCoffees.firstWhere((coffee) => coffee['name'] == name);
        recipe['name'] = newName;
        recipe['ingredients'] = newIngredients;
        recipe['preparation'] = newPreparation;
        recipe['image'] = newImagePath;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFb1e1a3),
      appBar: AppBar(
        backgroundColor: Color(0xFFFef9c2),
        title: Image.asset('assets/images/banner.png', height: 80,),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearchDialog(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            CategorySection(
              title: 'Caliente >',
              coffees: filteredHotCoffees,
              onEdit: (name) => print('Edit $name'),
              onDelete: (name) => _showDeleteDialog(name, 'Caliente'),
              onShare: (name) => shareRecipe(name),
            ),
            SizedBox(height: 20),
            CategorySection(
              title: 'Helado >',
              coffees: filteredColdCoffees,
              onEdit: (name) => print('Edit $name'),
              onDelete: (name) => _showDeleteDialog(name, 'Helado'),
              onShare: (name) => shareRecipe(name),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        color: Color(0xFFFef9c2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.coffee, color: Color(0xFFfc98a4)),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.library_books, color: Color(0xFFfc98a4)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListaRecetasScreen(
                      hotCoffees: hotCoffees,
                      coldCoffees: coldCoffees,
                    ),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.add, color: Color(0xFFfc98a4)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CrearRecetasScreen(
                      onAddRecipe: _addRecipe,
                    ),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.pets, color: Color(0xFFfc98a4)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ComunidadScreen()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.person, color: Color(0xFFfc98a4)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
             )
          ],
        ),
      ),
    );
  }

  void showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Buscar Receta'),
          content: TextField(
            controller: searchController,
            onChanged: (value) {
              setState(() {
                searchText = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Escribe el nombre de la receta...',
              prefixIcon: Icon(Icons.search),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  searchText = '';
                  searchController.clear();
                });
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}

class CategorySection extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> coffees;
  final Function(String) onEdit;
  final Function(String) onDelete;
  final Function(String) onShare;

  CategorySection({
    required this.title,
    required this.coffees,
    required this.onEdit,
    required this.onDelete,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
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
              color: Color(0xFFFef9c2),
            ),
          ),
          SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(), 
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, 
              crossAxisSpacing: 10, 
              mainAxisSpacing: 10, 
            ),
            itemCount: coffees.length,
            itemBuilder: (context, index) {
              final coffee = coffees[index];
              return Column(
                children: [
                  Container(
                    width: 200,
                    height: 180,
                    child: Card(
                      color: Color(0xFFFef9c2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.share),
                                  onPressed: () => onShare(coffee['name']!),
                                ),
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () => onEdit(coffee['name']!),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () => onDelete(coffee['name']!),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Center(
                              child: Image.asset(
                                coffee['image']!,
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              coffee['name']!,
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFfc98a4), 
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetalleRecetasScreen(
                            recipeName: coffee['name']!,
                            image: coffee['image']!,
                            ingredients: coffee['ingredients']!,
                            preparation: coffee['preparation']!,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'Preparación',
                      style: TextStyle(
                        color: Color(0xFFFef9c2), 
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}