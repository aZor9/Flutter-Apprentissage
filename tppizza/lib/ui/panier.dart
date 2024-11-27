import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tppizza/models/cart.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:tppizza/models/pizza.dart';
import 'package:tppizza/ui/share/pizzeria_style.dart';
// import 'package:tppizza/models/pizza.dart';
// import 'package:tppizza/ui/share/cart_list_widget.dart';
// import 'package:tppizza/ui/share/cart_total_widget.dart';
// import 'package:tppizza/ui/share/total_widget.dart';

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
            child: Padding(padding: const EdgeInsets.all(8.0), child: _CartList(),),
            ),
          ),
          _CartTotal();
        ],
      ),
    );
  }

  /*
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
  */


}




class _CartList extends StatelessWidget {

  var format = NumberFormat("###.00 €");
  // const _CartList({super.key});

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<Cart>();
    return ListView.builder(
        itemCount: _cart.totalItems(),
    itemBuilder: (context, index) {
    final cartItem = _cart.getCartItem(index);
    return _buildItem(cartItem);
    };
  }


  Widget _buildItem(CartItem cartItem) {
    return Row(
      children: [

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
                        _cart.removeOneProduct(cartItem.pizza);

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






class TotalWidget extends StatelessWidget {
  final double total;
  const TotalWidget(this.total, {super.key});

  @override
  Widget build(BuildContext context) {
    var format = NumberFormat('###.00 €');
    String totalAffiche = format.format(total);

    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
      ),

      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 12.0),
              child: Text(
                'TOTAL',
                style: PizzeriaStyle.priceTotalTextStyle,
                textAlign: TextAlign.end,
              ),
            ),
          ),
          Expanded(
            child: Text(
              totalAffiche,
              style: PizzeriaStyle.priceTotalTextStyle,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),

    );
  }
}
