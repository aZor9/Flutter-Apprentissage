import 'moteur.dart';

class Voiture {
  String immatriculation;
  String modele;
  double prixHT;
  int nbPortes;
  Moteur moteur;


  Voiture({required this.immatriculation,
    required this.modele,
    required this.prixHT,
    this.nbPortes = 4,
    required this.moteur
  });
}




