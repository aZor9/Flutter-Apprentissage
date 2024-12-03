import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tppizza/models/cart.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:tppizza/models/pizza.dart';
import 'package:tppizza/ui/share/pizzeria_style.dart';

class Panier extends StatefulWidget {
  final Cart _cart;
  const Panier(this._cart, {super.key});

  @override
  State<Panier> createState() => _PanierState();
}

class _PanierState extends State<Panier> {
  @override
  Widget build(BuildContext context) {
    double totalAmount = widget._cart.getItems().fold(0, (sum, item) => sum + (item.pizza.price * item.quantity));
    double TVA = 10;
    double totalTVA = (totalAmount / (100 + TVA)) * TVA;
    double totalAmountHT = totalAmount - totalTVA;

    return Scaffold(
      appBar: AppBar(
        title: Text('Panier'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _CartList(), // Affichage de la liste des produits
            ),
          ),
          _CartTotal(cart: widget._cart), // Affichage du total du panier
        ],
      ),
    );
  }
}

class _CartList extends StatelessWidget {
  var format = NumberFormat("###.00 €");

  @override
  Widget build(BuildContext context) {
    // Utilisation de Provider pour accéder au panier
    var cart = context.watch<Cart>();

    return ListView.builder(
      itemCount: cart.totalItems(), // Nombre d'éléments dans le panier
      itemBuilder: (context, index) {
        final cartItem = cart.getCartItem(index); // Récupère l'élément du panier à l'index donné
        return _buildItem(cartItem, cart); // Affiche l'élément du panier
      },
    );
  }

  Widget _buildItem(CartItem cartItem, Cart cart) {
    return Row(
      children: [
        // Affichage de l'image de la pizza
        Image.network(
          Pizza.fixUrl(cartItem.pizza.image),
          height: 120,
          width: 120,
          fit: BoxFit.fitWidth,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(cartItem.pizza.title), // Titre de la pizza
            Text('Quantité : ${cartItem.quantity}'), // Quantité
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Bouton pour retirer une unité de produit
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    cart.removeOneProduct(cartItem.pizza); // Retirer un produit
                  },
                ),
                Text('Prix : ${cartItem.pizza.total.toStringAsFixed(2)} €'), // Prix de la pizza
                // Bouton pour ajouter une unité de produit
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    cart.addProduct(cartItem.pizza); // Ajouter un produit
                  },
                ),
              ],
            ),
            // Affichage du sous-total pour cet élément du panier
            Text('Sous-total : ${(cartItem.pizza.total * cartItem.quantity).toStringAsFixed(2)} €'),
          ],
        ),
      ],
    );
  }
}

class _CartTotal extends StatelessWidget {
  final format = NumberFormat("###.00 €");
  final Cart cart;

  _CartTotal({required this.cart});

  @override
  Widget build(BuildContext context) {
    double totalAmount = cart.getItems().fold(0, (sum, item) => sum + (item.pizza.price * item.quantity ));
    double TVA = 10;
    double totalTVA = (totalAmount / (100 + TVA) ) * TVA ;
    double totalAmountHT = totalAmount - totalTVA;

    return Container(
      padding: EdgeInsets.all(12.0),
      height: 220,
      child: Consumer<Cart>(
          builder: (context, cart, child) {
            // final double _total = cart.getTotalPrice(); // Appeler la bonne méthode
            if (totalAmount == 0) {
              return Center(
                child: Text('Aucun produit',
                  style: PizzeriaStyle.priceTotalTextStyle,),
              );
            } else {
              return Column(
                children: [
                  Table(
                      border: TableBorder.all(),
                      children: [
                        TableRow(children: [
                          Text(' Total HT : ',
                              style: TextStyle(fontSize: 18)),
                          Text(' ${totalAmountHT.toStringAsFixed(2)} €',
                              style: TextStyle(fontSize: 18)),
                        ]),
                        TableRow(children: [
                          Text(' TVA : ', style: TextStyle(fontSize: 18)),
                          Text(' ${totalTVA.toStringAsFixed(2)} €',
                              style: TextStyle(fontSize: 18)),
                        ]),
                        TableRow(children: [
                          Text(' Total TTC : ',
                              style: TextStyle(fontSize: 18)),
                          Text(' ${totalAmount.toStringAsFixed(2)} €',
                              style: TextStyle(fontSize: 18)),
                        ]),
                      ]
                  ),
                  ElevatedButton(
                    child: Text('Valider'),
                    onPressed: () {
                      print('Valider');
                    },
                  ),
                ],
              );
            }
          }
      ),
    );
  }
}
