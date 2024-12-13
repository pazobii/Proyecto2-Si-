import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void showCarouselDialog(BuildContext context, String title, List<String> items) {
  final PageController pageController = PageController(); // Controlador del PageView

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          color: Color(0xFFfc98a4), // Fondo rosado
          child: SizedBox(
            height: 400,
            child: Column(
              children: [
                // Título del carrusel
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Color(0xFFFef9c2), // Texto amarillo
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Carrusel con PageView
                Expanded(
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: items.length,
                    physics: const BouncingScrollPhysics(), // Habilita scroll en web
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Paso ${index + 1}",
                              style: TextStyle(
                                color: Color(0xFFFef9c2), // Texto amarillo
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              items[index],
                              style: TextStyle(
                                color: Color(0xFFFef9c2), // Texto amarillo
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                // Indicadores de página
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: items.length,
                    effect: WormEffect(
                      activeDotColor: Color(0xFFFef9c2), // Amarillo
                      dotColor: Color(0xFFb1e1a3), // Verde claro
                    ), 
                  ),
                ),
                // Botones de navegación
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Color(0xFFFef9c2)), // Flecha amarilla
                      onPressed: () {
                        if (pageController.page! > 0) {
                          pageController.previousPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward, color: Color(0xFFFef9c2)), // Flecha amarilla
                      onPressed: () {
                        if (pageController.page! < items.length - 1) {
                          pageController.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                    ),
                  ],
                ),
                // Botón de cerrar
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFb1e1a3), // Verde
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Cerrar",
                      style: TextStyle(
                        color: Color(0xFFFef9c2), // Letras amarillas
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
