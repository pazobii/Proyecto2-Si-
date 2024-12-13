import 'package:flutter/material.dart';
import 'package:meow_cafe/base_de_datos.dart';
import 'package:share_plus/share_plus.dart';
import 'detalle_recetas.dart';
import 'crear_recetas.dart';
import 'editar_recetas.dart';
import 'profile_screen.dart';
import 'listado_recetas.dart';
import 'comunidad_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;


class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Map<String, dynamic>> hotCoffees = [
    {
      'name': 'Espresso',
      'imageRoute': 'assets/images/Espresso.png',
      'ingredients': 'Agua y café molido',
      'preparation': 'Pasar el agua caliente a presión a través de café molido, para producir una bebida fuerte en el interior y cremosa en la parte superior.',
    },
    {
      'name': 'Capuccino',
      'imageRoute': 'assets/images/Capuccino.png',
      'ingredients': 'Espresso, leche al vapor y azúcar',
      'preparation': 'Primero, prepara un espresso. Luego, calienta y espuma la leche con una máquina de vapor hasta que esté cremosa. Vierte la leche espumada sobre el espresso, dejando una capa de espuma en la parte superior. Agregar azúcar al gusto!!!!.',
    },
    {
      'name': 'Americano',
      'imageRoute': 'assets/images/Americano.png',
      'ingredients': 'Espresso y agua caliente',
      'preparation': 'Prepara un espresso y, luego, agrega agua caliente al gusto (aproximadamente el doble del volumen del espresso). Esto diluye el café, creando una bebida más suave y de mayor volumen que un espresso, pero con el mismo sabor base.',
    },
    {
      'name': 'Cortado',
      'imageRoute': 'assets/images/Cortado.png',
      'ingredients': 'Espresso y leche caliente',
      'preparation': 'Prepara un espresso y, luego, agrega una pequeña cantidad de leche caliente (generalmente la misma cantidad o un poco menos que el espresso). La leche suaviza el sabor fuerte del espresso, creando una bebida equilibrada con un toque cremoso.',
    },
    {
      'name': 'Flat white',
      'imageRoute': 'assets/images/FlatWhite.png',
      'ingredients': 'Espresso y leche vaporizada',
      'preparation': 'Prepara un espresso y, luego, agrega leche vaporizada, pero sin mucha espuma, de manera que la leche tenga una textura suave y cremosa. La proporción de leche es mayor que en un cortado, creando una bebida suave, cremosa y con un sabor más equilibrado entre el café y la leche.',
    },
    {
      'name': 'Latte',
      'imageRoute': 'assets/images/Latte.png',
      'ingredients': '1 espresso, leche vaporizada y espuma de leche',
      'preparation': 'Prepara un espresso y, luego, agrega leche vaporizada, dejando una pequeña capa de espuma en la parte superior. El latte tiene una mayor cantidad de leche que un cappuccino, lo que lo hace más suave y cremoso, con un sabor más equilibrado entre el café y la leche.',
    },
    {
      'name': 'Machiatto',
      'imageRoute': 'assets/images/Machiatto.png',
      'ingredients': '1 espresso, leche vaporizada o espuma de leche',
      'preparation': 'Prepara un espresso y, luego, agrega una pequeña cantidad de leche vaporizada o espuma de leche sobre el café, justo en el centro. El macchiato tiene un sabor fuerte a café, con solo un toque de leche, a diferencia de otros cafés con más leche, como el latte. "Macchiato" significa "manchado", ya que la leche solo "mancha" el espresso.',
    },
     {
      'name': 'Mocha',
      'imageRoute': 'assets/images/Mocha.png',
      'ingredients': '1 espresso, 150 ml de leche vaporizada, 2 cucharadas de jarabe de chocolate y crema batida (opcional)',
      'preparation': 'Prepara un espresso y mezcla con el jarabe de chocolate hasta que se disuelva bien. Luego, agrega la leche vaporizada, creando una mezcla suave y cremosa. Si lo deseas, puedes coronar con crema batida para darle un toque extra. El mocha combina el sabor fuerte del café con la dulzura del chocolate, creando una bebida indulgente y deliciosa.',
    },

  ];

  List<Map<String, dynamic>> coldCoffees = [
    {
      'name': 'Americano frío',
      'imageRoute': 'assets/images/AmericanoFrio.png',
      'ingredients': 'Agua, hielo y espresso',
      'preparation': 'Prepara un espresso y déjalo enfriar un poco. Llena un vaso con hielo y vierte el espresso frío sobre el hielo. Luego, agrega agua fría al gusto y mezcla bien. Esto crea una versión refrescante y fría del café americano.',
    },
    {
      'name': 'Affogato',
      'imageRoute': 'assets/images/Affogato.png',
      'ingredients': '1 bola de helado de vainilla y un espresso caliente',
      'preparation': 'Coloca una bola de helado de vainilla en un vaso o copa. Luego, vierte un espresso caliente por encima del helado. La combinación de la temperatura del espresso con el helado crea una mezcla deliciosa y cremosa.',
    },
    {
      'name': 'Latte frío',
      'imageRoute': 'assets/images/LatteFrio.png',
      'ingredients': '1 espresso, leche fría y hielo',
      'preparation': 'Prepara un espresso y déjalo enfriar. Llena un vaso con hielo y vierte el espresso frío sobre el hielo. Luego, agrega leche fría al gusto y mezcla bien. Si lo deseas, puedes añadir azúcar para endulzar. Esto crea una versión refrescante del latte, perfecta para días calurosos.',
    },
    {
      'name': 'Mocha frío',
      'imageRoute': 'assets/images/MochaFrio.png',
      'ingredients': '1 espresso, 2 cucharadas de jarabe de chocolate, leche fría. hielo y crema batida (opcional)',
      'preparation': 'Prepara un espresso y déjalo enfriar. En un vaso grande, mezcla el espresso frío con el jarabe de chocolate. Luego, llena el vaso con hielo y agrega leche fría al gusto. Mezcla bien y, si lo deseas, cubre con crema batida para darle un toque extra. El mocha frío es una bebida refrescante que combina el sabor del café con chocolate y leche fría.',
    },
  ];

  List<Map<String, dynamic>> desserts = [
    {
      'name': 'Muffin',
      'imageRoute': 'assets/images/muffin.png',
      'ingredients': 'harina de trigo, huevo, aceite vegetal, leche de vaca, polvos de hornear, esencia vainilla y azúcar.',
      'preparation': 'Mezcla 2 tazas de harina de trigo, 1/2 taza de azúcar, y 2 cucharaditas de polvos de hornear en un bowl. En otro recipiente, bate 1 huevo con 1/3 de taza de aceite vegetal, 1 taza de leche y 1 cucharadita de esencia de vainilla. Combina ambas mezclas hasta que estén integradas, sin batir demasiado. Llena moldes para muffins hasta 2/3 de su capacidad y hornea a 180 °C (350 °F) durante 20-25 minutos, o hasta que un palillo salga limpio. Deja enfriar y disfruta.',
    },
    {
      'name': 'Tiramisú',
      'imageRoute': 'assets/images/Tiramisu.png',
      'ingredients': 'Mascarpone, café, azúcar, bizcocho.',
      'preparation': 'Monta las capas de bizcocho y crema de mascarpone con café.',
    },
    
  ];

  String searchText = '';
  TextEditingController searchController = TextEditingController();

  // Configuración del carrusel
  final PageController _pageController = PageController();
  final List<String> carouselItems = [
    "1. Navega entre categorías: caliente, helado y postres.",
    "2. Busca recetas usando el ícono de búsqueda en la barra superior.",
    "3. Añade una nueva receta con el botón de más (+).",
    "4. Edita o elimina recetas directamente desde la lista.",
    "5. Consulta detalles y preparación de cada receta.",
  ];

  bool firstTime = false;

  @override
  void initState()
  {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
      final users = await BaseDeDatos.getUsers();
      firstTime = users.isEmpty;
      if(users.isEmpty)
      {
        _showCarouselDialog(context);
        await BaseDeDatos.insertUser(
          {
            'id': 0
          }
        );

        print('Usuarios: ' + (await BaseDeDatos.getUsers()).length.toString());
        for(int i = 0; i < hotCoffees.length; i++)
        {
          hotCoffees[i]['category'] = 'Caliente';
          await BaseDeDatos.insertRecipe(hotCoffees[i]);
        }
        for(int i = 0; i < coldCoffees.length; i++)
        {
          coldCoffees[i]['category'] = 'Helado';
          await BaseDeDatos.insertRecipe(coldCoffees[i]);
        }
        for(int i = 0; i < desserts.length; i++)
        {
          desserts[i]['category'] = 'Postres';
          await BaseDeDatos.insertRecipe(desserts[i]);
        }
      }
      else
      {
        final recipes = await BaseDeDatos.getRecipes();
        hotCoffees.clear();
        coldCoffees.clear();
        desserts.clear();

        for(int i = 0; i < recipes.length; i++)
        {
          if(recipes[i]['category'] == 'Caliente')
          {
            hotCoffees.add(recipes[i]);
          }
          else if(recipes[i]['category'] == 'Helado')
          {
            coldCoffees.add(recipes[i]);
          }
          else if(recipes[i]['category'] == 'Postres')
          {
            desserts.add(recipes[i]);
          }
        }
      }
      
  }

  Future<File> getImageFileFromAssets(String path) async {
    Directory directory = await getApplicationDocumentsDirectory();
    var dbPath = p.join(directory.path, "app.txt");
    var data = await rootBundle.load(path);
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    return await File(dbPath).writeAsBytes(bytes);
  }

 void shareRecipe(String recipe, String imageRoute) {
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

  List<Map<String, dynamic>> get filteredDesserts {
    if (searchText.isEmpty) {
      return desserts;
    } else {
      return desserts
          .where((dessert) =>
              dessert['name']!.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    }
  }

  // Método para eliminar recetas de cualquier categoría
  Future<void> _deleteRecipe(String name, String category) async {
    await BaseDeDatos.deleteRecipe(name);
    setState(() {
      if (category == 'Caliente') {
        hotCoffees.removeWhere((coffee) => coffee['name'] == name);
      } else if (category == 'Helado') {
        coldCoffees.removeWhere((coffee) => coffee['name'] == name);
      } else if (category == 'Postres') {
        desserts.removeWhere((dessert) => dessert['name'] == name);
      }
    });
  }

  // Mostrar diálogo de confirmación para eliminar
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

  // Mostrar carrusel en un diálogo
  void _showCarouselDialog(BuildContext context) {
    int currentIndex = 0;
    showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Container(
                padding: EdgeInsets.all(16),
                height: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Cómo usar la pantalla principal",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: PageView.builder(
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                        itemCount: carouselItems.length,
                        itemBuilder: (_, index) {
                          return Center(
                            child: Text(
                              carouselItems[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16),
                            ),
                          );
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: currentIndex > 0
                              ? () {
                                  setState(() {
                                    currentIndex--;
                                    _pageController.animateToPage(
                                      currentIndex,
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                  });
                                }
                              : null,
                        ),
                        SmoothPageIndicator(
                          controller: _pageController,
                          count: carouselItems.length,
                          effect: WormEffect(),
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_forward),
                          onPressed: currentIndex < carouselItems.length - 1
                              ? () {
                                  setState(() {
                                    currentIndex++;
                                    _pageController.animateToPage(
                                      currentIndex,
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                  });
                                }
                              : null,
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text("Cerrar"),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFb1e1a3),
      appBar: AppBar(
        backgroundColor: Color(0xFFFef9c2),
        title: Image.asset('assets/images/banner.png', height: 80),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline, color: Colors.brown),
            onPressed: () => _showCarouselDialog(context),
          ),
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
                      onEdit: (name) {
                      final recipe = hotCoffees.firstWhere((recipe) => recipe['name'] == name);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditarRecetasScreen(
                            recipeName: recipe['name']!,
                            category: 'Caliente',
                            ingredients: recipe['ingredients']!,
                            preparation: recipe['preparation']!,
                            onSave: (updatedName, updatedCategory, updatedIngredients, updatedPreparation) async {
                              final updatedRecipe = {
                                  'name': updatedName,
                                  'imageRoute': recipe['imageRoute'],
                                  'ingredients': updatedIngredients,
                                  'preparation': updatedPreparation,
                                  'category': updatedCategory,
                              };
                              await BaseDeDatos.updateRecipe(updatedRecipe);
                              setState(() {
                                hotCoffees.removeWhere((r) => r['name'] == name);
                                if (updatedCategory == 'Caliente') {
                                  hotCoffees.insert(0, updatedRecipe);
                                } else if (updatedCategory == 'Helado') {
                                  coldCoffees.insert(0, updatedRecipe);
                                } else if (updatedCategory == 'Postres') {
                                  desserts.insert(0, updatedRecipe);
                                }
                              });
                            },
                          ),
                        ),
                      );
                    },
                      onDelete: (name) => _showDeleteDialog(name, 'Caliente'),
                      onShare: (name, imageRoute)  =>  shareRecipe(name, imageRoute),
                    ),
                    SizedBox(height: 20),
                    CategorySection(
                      title: 'Helado >',
                      coffees: filteredColdCoffees,
                      onEdit: (name) {
                      final recipe = coldCoffees.firstWhere((recipe) => recipe['name'] == name);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditarRecetasScreen(
                            recipeName: recipe['name']!,
                            category: 'Helado',
                            ingredients: recipe['ingredients']!,
                            preparation: recipe['preparation']!,
                            onSave: (updatedName, updatedCategory, updatedIngredients, updatedPreparation) async {
                              final updatedRecipe = {
                                  'name': updatedName,
                                  'imageRoute': recipe['imageRoute'],
                                  'ingredients': updatedIngredients,
                                  'preparation': updatedPreparation,
                                  'updatedCategory': updatedCategory,
                              };
                              await BaseDeDatos.updateRecipe(updatedRecipe);
                              setState(() {
                                coldCoffees.removeWhere((r) => r['name'] == name);
                                if (updatedCategory == 'Caliente') {
                                  hotCoffees.insert(0, updatedRecipe);
                                } else if (updatedCategory == 'Helado') {
                                  coldCoffees.insert(0, updatedRecipe);
                                } else if (updatedCategory == 'Postres') {
                                  desserts.insert(0, updatedRecipe);
                                }
                              });
                            },
                          ),
                        ),
                      );
                    },
                      onDelete: (name) => _showDeleteDialog(name, 'Helado'),
                      onShare: (name, imageRoute) =>  shareRecipe(name, imageRoute),
                    ),
                    SizedBox(height: 20),
                    CategorySection(
                      title: 'Postres >',
                      coffees: filteredDesserts,
                      onEdit: (name) {
                      final recipe = desserts.firstWhere((recipe) => recipe['name'] == name);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditarRecetasScreen(
                            recipeName: recipe['name']!,
                            category: 'Postres',
                            ingredients: recipe['ingredients']!,
                            preparation: recipe['preparation']!,
                            onSave: (updatedName, updatedCategory, updatedIngredients, updatedPreparation) async {
                              final updatedRecipe = {
                                  'name': updatedName,
                                  'imageRoute': recipe['imageRoute'],
                                  'ingredients': updatedIngredients,
                                  'preparation': updatedPreparation,
                                  'category': updatedCategory,
                              };
                              await BaseDeDatos.updateRecipe(updatedRecipe);
                              setState(() {
                                desserts.removeWhere((r) => r['name'] == name);
                                if (updatedCategory == 'Caliente') {
                                  hotCoffees.insert(0, updatedRecipe);
                                } else if (updatedCategory == 'Helado') {
                                  coldCoffees.insert(0, updatedRecipe);
                                } else if (updatedCategory == 'Postres') {
                                  desserts.insert(0, updatedRecipe);
                                }
                              });
                            },
                          ),
                        ),
                      );
                    },
                      onDelete: (name) => _showDeleteDialog(name, 'Postres'),
                      onShare: (name, imageRoute)  =>  shareRecipe(name, imageRoute),
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
                      desserts: desserts,
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
                    onAddRecipe: (name, category, ingredients, preparation, imagePath) async {
                      final newRecipe = {
                        'name': name,
                        'imageRoute': imagePath,
                        'ingredients': ingredients,
                        'preparation': preparation,
                        'category': category,
                      };
                      print((await BaseDeDatos.getRecipes()).length);
                      await BaseDeDatos.insertRecipe(newRecipe);
                      print('Añadido' + (await BaseDeDatos.getRecipes()).length.toString());
                      setState(() {
                        if (category == 'Caliente') {
                          hotCoffees.add(newRecipe);
                        } else if (category == 'Helado') {
                          coldCoffees.add(newRecipe);
                        } else {
                          desserts.add(newRecipe);
                        }
                     });
                    },
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
            ),
          ],
        ),
      ),
    );
  }
}

class CategorySection extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> coffees;
  final Function(String) onEdit;
  final Function(String) onDelete;
  final Function(String, String) onShare;

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
                                  onPressed: () => onShare(coffee['name']!, coffee ['imageRoute']!),
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
                                coffee['imageRoute']!,
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
                            image: coffee['imageRoute']!,
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
