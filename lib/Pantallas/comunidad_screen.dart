import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:mailto/mailto.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ComunidadScreen extends StatefulWidget {
  @override
  _ComunidadScreenState createState() => _ComunidadScreenState();
}

class _ComunidadScreenState extends State<ComunidadScreen> {
  Map<String, dynamic> feedbackData = {};
  Map<String, int> responses = {};
  List<String> comentarios = [];
  TextEditingController comentarioController = TextEditingController();
  TextEditingController userIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadFeedbackData();
    _cargarComentarios();
  }

  Future<void> loadFeedbackData() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/feedback.json');
      setState(() {
        feedbackData = json.decode(jsonString);
        feedbackData.forEach((category, questions) {
          for (var question in questions) {
            responses[question['titulo']] = 0;
          }
        });
      });
    } catch (e) {
      print('Error al cargar el archivo JSON: $e');
    }
  }

  void updateResponse(String questionTitle, int value) {
    setState(() {
      responses[questionTitle] = value;
    });
  }

  void _agregarComentario() async {
    if (comentarioController.text.isNotEmpty) {
      setState(() {
        comentarios.add(comentarioController.text);
        comentarioController.clear();
      });
      await _guardarComentarios();
    }
  }

  Future<void> _guardarComentarios() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('comentarios', comentarios);
  }

  Future<void> _cargarComentarios() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      comentarios = prefs.getStringList('comentarios') ?? [];
    });
  }

  Future<void> sendFeedback() async {
    final userId = userIdController.text;
    final List<String> feedbackEntries = responses.entries
        .map((entry) => "${entry.key}: ${entry.value} estrellas")
        .toList();
    final List<String> comentariosList = comentarios.isNotEmpty
        ? comentarios.map((comentario) => "- $comentario").toList()
        : ["No hay comentarios adicionales."];

    final emailBody = [
      "Identificación del usuario: $userId",
      "\nRespuestas de retroalimentación:",
      ...feedbackEntries,
      "\nComentarios adicionales:",
      ...comentariosList,
    ].join('\n');

    final mailtoLink = Mailto(
      to: ['alarconficam@gmail.com'],
      subject: 'Retroalimentación de la aplicación',
      body: emailBody,
    );

    if (await canLaunchUrl(Uri.parse(mailtoLink.toString()))) {
      await launchUrl(Uri.parse(mailtoLink.toString()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo enviar el correo')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Comeownidad',
          style: TextStyle(color: Color(0xFFfef9c2)), 
        ),
        backgroundColor: Color(0xFFfc98a4), 
      ),
      backgroundColor: Color(0xFFfef9c2), 
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '¡Bienvenido a la Comeownidad!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFfc98a4), 
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: userIdController,
                decoration: InputDecoration(
                  labelText: 'Identificación del usuario',
                  labelStyle: TextStyle(color: Color(0xFFfc98a4)),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: comentarioController,
                decoration: InputDecoration(
                  labelText: 'Escribe tu comentario',
                  labelStyle: TextStyle(color: Color(0xFFfc98a4)),
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _agregarComentario,
                child: Text(
                  'Agregar Comentario',
                  style: TextStyle(color: Color(0xFFfef9c2)), 
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFfc98a4), 
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Retroalimentación:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFfc98a4), 
                ),
              ),
              ...feedbackData.entries.map((category) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.key,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFfc98a4),
                      ),
                    ),
                    ...category.value.map<Widget>((question) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            question['titulo'],
                            style: TextStyle(color: Color(0xFFfc98a4)), 
                          ),
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              activeTrackColor: Color(0xFFb1e1a3), 
                              inactiveTrackColor: Color(0xFFd3e8cd), 
                              trackHeight: 4.0,
                              thumbColor: Color(0xFFb1e1a3),
                              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.0),
                              overlayColor: Color(0xFFb1e1a3).withAlpha(32),
                              overlayShape: RoundSliderOverlayShape(overlayRadius: 20.0),
                            ),
                            child: Slider(
                              value: (responses[question['titulo']] ?? 0).toDouble(),
                              min: 0,
                              max: 5,
                              divisions: 5,
                              label: "${responses[question['titulo']]} estrellas",
                              onChanged: (value) {
                                updateResponse(question['titulo'], value.toInt());
                              },
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ],
                );
              }).toList(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: sendFeedback,
                child: Text(
                  'Enviar Retroalimentación',
                  style: TextStyle(color: Color(0xFFfef9c2)), 
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFfc98a4), 
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
