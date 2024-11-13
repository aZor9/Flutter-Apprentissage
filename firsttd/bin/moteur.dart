enum Energie { Gazole, Essence, Electricque }

class Moteur {
  int cylindre; // en cm3
  int puissance; // en kw
  Energie energie;

  Moteur({
    required this.cylindre,
    required this.puissance,
    this.energie = Energie.Essence
  });
}