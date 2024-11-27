/*
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tppizza/models/cart.dart';
import 'package:tppizza/ui/share/pizzeria_style.dart';

class _CartTotal extends StatelessWidget {
  var format = NumberFormat("###.00 €");
  final Cart cart;

  CartTotal({required this.cart});

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
              final double _total = cart.totalPrice();
              if (_total == 0) {
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
                      )

                    ]
                );
              }
            }
        )
    );
  }
}
*/