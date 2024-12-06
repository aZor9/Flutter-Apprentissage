import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pizzeria/models/cart.dart';
import 'package:pizzeria/models/pizza.dart';
import 'package:pizzeria/ui/share/bottom_navigation_bar_widget.dart';
import 'package:pizzeria/ui/share/pizza_style.dart';
import 'package:provider/provider.dart';

class Panier extends StatefulWidget {
  const Panier({Key? key}) : super(key: key);

  @override
  _PanierState createState() => _PanierState();
}

class _PanierState extends State<Panier> {


  @override
  Widget build(BuildContext context) {
    var cart= Provider.of<Cart>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Panier'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _CartList(cart: cart), // Passe l'objet Cart
          ),
          _CartTotal(),
          Container(
            padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.blue.shade600),
                  foregroundColor: WidgetStatePropertyAll(Colors.white),
                  minimumSize: WidgetStatePropertyAll(
                      Size(double.infinity, 50)),
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ))),
              child: Text(
                'VALIDER LE PANIER',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                print('Valider');
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarWidget(2),
    );
  }
}
class _CartList extends StatefulWidget {
  final Cart cart; // Déclare l'objet Cart comme paramètre

  const _CartList({required this.cart, Key? key}) : super(key: key);

  @override
  _CartListState createState() => _CartListState();
}

class _CartListState extends State<_CartList> {
  @override
  Widget build(BuildContext context) {
    // Utilise `widget.cart` car nous sommes dans un StatefulWidget
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: widget.cart.totalItems(),
      itemBuilder: (context, index) {
        return _buildItem(widget.cart.getCartItem(index));
      },
    );
  }

  Widget _buildItem(CartItem cartItem) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          Pizza.fixUrl(cartItem.pizza.image),
          height: 120,
          width: 120,
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cartItem.pizza.title,
                style: PizzeriaStyle.pageTitleTextStyle,
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Text('${Pizza.pates[cartItem.pizza.pate].name}',
                      style: PizzeriaStyle.baseTextStyle),
                  SizedBox(width: 10),
                  Text('${Pizza.tailles[cartItem.pizza.taille].name}',
                      style: PizzeriaStyle.baseTextStyle),
                  SizedBox(width: 10),
                  Text('${Pizza.sauces[cartItem.pizza.sauce].name}',
                      style: PizzeriaStyle.baseTextStyle),
                ],
              ),
              Row(
                children: [
                  Text(
                    '${cartItem.pizza.total} €',
                    style: PizzeriaStyle.itemPriceTextStyle,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              widget.cart.removeProduct(cartItem.pizza);
                            });
                          },
                          icon: Icon(Icons.remove),
                        ),
                        Text('${cartItem.quantity}'),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              widget.cart.addProduct(cartItem.pizza);
                            });
                          },
                          icon: Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Text(
                'Sous Total: ${cartItem.pizza.total * cartItem.quantity} €',
                style: PizzeriaStyle.subPriceTextStyle,
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CartTotal extends StatelessWidget {
  var format = NumberFormat("###.00 €");
  @override
  Widget build (BuildContext context) {
    return Container(
        padding: EdgeInsets.all(12.0),
        height: 220,
        child : Consumer<Cart>(
          builder: (context, cart, child) {
            final double _total = cart.getTotalPrice();
            if (_total == 0) {
              return Center(
                child: Text('Aucun produit',
                  style: PizzeriaStyle.priceTotalTextStyle,),
              );
            } else {
              return Column(
                children: [
                  Table(
                    children: [
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 8.0),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 8.0),
                            child: Text(
                              'TOTAL HC',
                              style: PizzeriaStyle.priceSubTotalTextStyle,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 8.0),
                            child: Text(
                              '${cart.getTotalPrice()} €',
                              style: PizzeriaStyle.priceSubTotalTextStyle,
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 8.0),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 8.0),
                            child: Text(
                              'TVA (20%)',
                              style: PizzeriaStyle.priceSubTotalTextStyle,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 8.0),
                            child: Text(
                              '${cart.getTotalTVA(0.2).toStringAsFixed(2)} €',
                              style: PizzeriaStyle.priceSubTotalTextStyle,
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 8.0),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 1.0),
                            child: Text(
                              'TOTAL TTC',
                              style: PizzeriaStyle.priceTotalTextStyle,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 8.0),
                            child: Text(
                              '${cart.getTotalWithTVA(cart.getTotalTVA(0.2)).toStringAsFixed(2)} €',
                              style: PizzeriaStyle.priceTotalTextStyle,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              );
            }
          }
        ),
    );
  }
}
