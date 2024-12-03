import 'package:flutter/cupertino.dart';
import 'package:tppizza/models/pizza.dart';

class CartItem {
  final Pizza pizza;
  int quantity;

  CartItem(this.pizza, [this.quantity = 1]);
}

class Cart extends ChangeNotifier {
  List<CartItem> _items = [];


  List<CartItem> getItems() {
    return _items;
  }


  int totalItems() { return _items.length; }
  CartItem getCartItem(int index) {
    return _items[index];
  }


  void addProduct(Pizza pizza) {
    // Recherche du produit
    int index = findCartItemIndex(pizza.id);
    if (index == -1) {
      // Ajout du produit
      _items.add(CartItem(pizza));
    } else {
      // Incrémente la quantité
      CartItem item = _items[index];
      item.quantity++;
    }
    print("Ajout produit");
    notifyListeners();
  }

  void removeProduct(Pizza pizza) {
    // Recherche du produit
    int index = findCartItemIndex(pizza.id);

    if (index != -1) {
      // Suppression
      _items.removeAt(index);
    }
    notifyListeners();
  }

  void removeOneProduct(Pizza pizza) {
    // Recherche du produit
    int index = findCartItemIndex(pizza.id);

    if (index == -1) {
      // Suppression
      _items.removeAt(index);
    } else {
      // Incrémente la quantité
      CartItem item = _items[index];
      item.quantity--;
      if (item.quantity == 0){
        _items.removeAt(index);
      }
    }
    notifyListeners();
  }



  int findCartItemIndex(int id) {
    return _items.indexWhere((element) => element.pizza.id == id);
  }
}

