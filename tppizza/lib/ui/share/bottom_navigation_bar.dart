import 'package:flutter/material.dart';
import 'package:tppizza/main.dart';

class BottomNavigationBar extends StatelessWidget {
  final int indexSelected;
  const BottomNavigationBar(this.indexSelected, {super.key});

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<Cart>();
    var _totalItems = cart.totalQuantity();

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: indexSelected,
      items:<BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Accueil',
          ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_shopping_cart_outlined),
          label: 'Commande',
        ),
        BottomNavigationBarItem(
          icon: _totalItems == 0
            ? Icon(Icons.shopping_cart_outlined),
            : BadgeWidget(
              child: Icon(Icons.shopping_cart),
              value: _totalItems,
              top: 0,
              right: 0,
            ),
        ),
        BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Profil',
        ),
      ],
    onTap: (index) {
        String page = '/';
        switch (index) {
          case 2:
            page = '/panier';
            break;
          case 3:
            page = '/profil';
            break;
        }
        Navigator.pushNamed(context, page);
      },
    );
  }
}
