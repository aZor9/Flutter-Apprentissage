import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tppizza/models/pizza.dart';

class PizzeriaService {
  // URI de base pour l'appel
  // Ici, l'adresse IP 10.0.2.2 représente le localhost en émulateur Android.
  static final String uri = 'http://10.0.2.2/api/';

  Future<List<Pizza>> fetchPizzas() async {
    List<Pizza> list = [];

    try {
      // Appel HTTP bloquant
      final response = await http.get(Uri.parse('${uri}/pizzas'));

      if (response.statusCode == 200) {
        // Décodage JSON avec gestion des accents
        var json = jsonDecode(utf8.decode(response.bodyBytes));

        for (final value in json) {
          // Création de l'objet pizza avec le JSON et ajout dans la liste
          list.add(Pizza.fromJson(value));
        }
      } else {
        throw Exception('Impossible de récupérer les pizzas');
      }
    } catch (e) {
      throw e;
    }

    return list;
  }
}
