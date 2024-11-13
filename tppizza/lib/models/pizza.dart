import 'dart:convert';
import 'dart:ui';

import 'package:tppizza/models/option_item.dart';

class Pizza {
  final int id;
  final String title;
  final String garniture;
  final String image;
  final double price;

  // La sélection de l'utilisateur
  int pate = 0;
  int taille = 1;
  int sauce = 0;

// Les options possibles
  static final List<OptionItem> pates = [
    OptionItem(0, "Pâte fine"),
    OptionItem(1, "Pâte épaisse", supplement: 2),
  ];

  static final List<OptionItem> tailles = [
    OptionItem(0, "Small", supplement: -1),
    OptionItem(1, "Medium"),
    OptionItem(2, "Large", supplement: 2),
    OptionItem(3, "Extra large", supplement: 4),
  ];

  static final List<OptionItem> sauces = [
    OptionItem(0, "Base sauce tomate"),
    OptionItem(1, "Sauce Samouraï", supplement: 2),
  ];

  double get total {
    double total = price;
    total += pates[pate].supplement; // Prix de base + supplément pour la pâte
    total += tailles[taille].supplement; // Supplément pour la taille
    total += sauces[sauce].supplement; // Supplément pour la sauce
    return total;
  }


  Pizza(this.id, this.title, this.garniture, this.image, this.price);


  Pizza.formJson(Map<String, dynamic> json)
    : id = json['id'];
      title = json['title'];
      garniture = json['garniture'];
      image = json['image'];
      price = json['price'];


}


