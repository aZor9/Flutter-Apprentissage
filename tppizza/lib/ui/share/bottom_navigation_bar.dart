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
      items:<BottomNavigationBarItem(

    )
    );
  }
}
