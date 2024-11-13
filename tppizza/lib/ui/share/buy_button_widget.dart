import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tppizza/models/cart.dart';
import 'dart:ui';

import 'package:tppizza/models/pizza.dart';

class BuyButtonWidget extends StatelessWidget {
  final Pizza _pizza;
  final Cart _cart;
  const BuyButtonWidget(this._pizza, this._cart, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
              MaterialStateProperty.all<Color>(Colors.red.shade800)),
          child: Row(
            children: [
              Icon(Icons.shopping_cart),
              SizedBox(width: 5),
              Text('Commander'),
            ],
          ),
          onPressed: () {
                  print('Commander une pizza');
                  _cart.addProduct(_pizza);
          },
        ),
      ],
    );
  }
}

