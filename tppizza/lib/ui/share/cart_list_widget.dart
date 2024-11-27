import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tppizza/models/cart.dart';
import 'package:intl/intl.dart';
import 'package:tppizza/models/pizza.dart';



// import 'share/cart_list_widget.dart';
// import 'share/cart_total_widget.dart';

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
                          _cart.addProduct(cartItem.pizza);
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
