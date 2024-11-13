
import 'voiture.dart';
import 'moteur.dart';

List<Voiture> voitures = [
  Voiture(immatriculation: 'AZ000', modele: 'A', prixHT: 35000, nbPortes: 3, moteur: Moteur(cylindre : 50, puissance : 50, energie: Energie.Electricque )),
  Voiture(immatriculation: 'AZ001', modele: 'B', prixHT: 60000, nbPortes: 5, moteur: Moteur(cylindre : 50, puissance : 50, energie: Energie.Essence  )),
  Voiture(immatriculation: 'AZ002', modele: 'C', prixHT: 55000, nbPortes: 4, moteur: Moteur(cylindre : 50, puissance : 50, energie: Energie.Gazole )),
  Voiture(immatriculation: 'AZ003', modele: 'X', prixHT: 65000, nbPortes: 5, moteur: Moteur(cylindre : 50, puissance : 50, energie: Energie.Electricque  )),
  Voiture(immatriculation: 'AZ004', modele: 'Y', prixHT: 50000, nbPortes: 5, moteur: Moteur(cylindre : 50, puissance : 50, energie: Energie.Gazole )),
  Voiture(immatriculation: 'AZ005', modele: 'Z', prixHT: 750000, nbPortes: 5, moteur: Moteur(cylindre : 50, puissance : 50 )),
];

void main () {
  double total = 0;
  print (' ');

  for (Voiture voiture in voitures) {
    if (voiture.moteur.energie == Energie.Electricque) {
      print('Voiture : ${voiture.immatriculation}');
      print('Modele : ${voiture.modele}');
      print('Prix HT : ${voiture.prixHT}');
      total += voiture.prixHT;
      print('Nombres de portes : ${voiture.nbPortes}');
      print('Cylindre moteur : ${voiture.moteur.cylindre}');
      print('Puissance moteur : ${voiture.moteur.puissance}');
      print('Energie moteur : ${voiture.moteur.energie}');
      print(' ');
    };
  };

  print('Total : ${total} €');



}