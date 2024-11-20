import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tppizza/models/cart.dart';
import 'package:tppizza/models/pizza.dart';
import 'package:tppizza/ui/share/total_widget.dart';

class Panier extends StatefulWidget {
  final Cart _cart;
  const Panier(this._cart, {super.key});


  @override
  State<Panier> createState() => _PanierState();
}


class _PanierState extends State<Panier> {
  @override


  Widget build(BuildContext context) {
    double totalAmount = widget._cart.getItems().fold(0, (sum, item) => sum + (item.pizza.price * item.quantity ));
    double TVA = 10;
    double totalTVA = (totalAmount / (100 + TVA) ) * TVA ;
    double totalAmountHT = totalAmount - totalTVA;

    return Scaffold(
      appBar: AppBar(
        title: Text('Panier'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget._cart.totalItems(),
              itemBuilder: (context, index) {
                final cartItem = widget._cart.getCartItem(index);
                return _buildItem(cartItem);
              }

            ),
          ),
          Container(

            child: Table(
              border: TableBorder.all(),
              children: [
                TableRow(children : [
                Text(' Total HT : ', style: TextStyle(fontSize: 18)),
                Text(' ${totalAmountHT.toStringAsFixed(2)} €', style: TextStyle(fontSize: 18)),
                  ]),
                TableRow(children : [
                  Text(' TVA : ', style: TextStyle(fontSize: 18)),
                  Text(' ${totalTVA.toStringAsFixed(2)} €', style: TextStyle(fontSize: 18)),
                  ]),
                TableRow(children : [
                  Text(' Total TTC : ', style: TextStyle(fontSize: 18)),
                  Text(' ${totalAmount.toStringAsFixed(2)} €', style: TextStyle(fontSize: 18)),
                ]),
              ]
            )





          ),
          Container(
            child: ElevatedButton(
              child: Text('Valider'),
              onPressed: () {
                print('Valider');
              },
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildItem(CartItem cartItem) {
    return Row(
      children: [
/*
        Image.asset(

         'assets/images/pizza/${cartItem.pizza.image}',

          height: 120,
          width: 120,
          fit: BoxFit.fitWidth,
        ),
    */
        Image.network(

          Pizza.fixUrl(cartItem.pizza.image),
          height: 120,
          width: 120,
          fit: BoxFit.fitWidth,
        ),


        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(cartItem.pizza.title),
            Text('Quantité : ${cartItem.quantity}'),
            // Text('${widget._cart.findCartItemIndex(cartItem.pizza.id)}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      widget._cart.removeOneProduct(cartItem.pizza);

                    });
                  },
                ),
                Text('Prix : ${cartItem.pizza.total.toStringAsFixed(2)} €'),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                    widget._cart.addProduct(cartItem.pizza);
                    });
                  }
                )
                ]
              ),
              Text('Sous-total : ${(cartItem.pizza.total * cartItem.quantity).toStringAsFixed(2)} €'),
              ],



        )
      ],
    );
  }



}

