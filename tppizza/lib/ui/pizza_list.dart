import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tppizza/models/cart.dart';
import 'package:tppizza/services/pizzeria_service.dart';
import 'package:tppizza/ui/pizza_details.dart';
import 'package:tppizza/ui/share/appbar_widget.dart';
import 'package:tppizza/ui/share/buy_button_widget.dart';
import 'package:tppizza/ui/share/pizzeria_style.dart';
import 'dart:ui';
import '../models/pizza.dart';
import '../models/pizza_data.dart';

class PizzaList extends StatefulWidget {
  final String title;
  final Cart _cart;
  const PizzaList(this.title, this._cart, {super.key});

  @override
  State<PizzaList> createState() => _PizzaListState();
}

class _PizzaListState extends State<PizzaList> {
// La liste des pizzas
  /* List<Pizza> _pizzas = []; */
  late Future<List<Pizza>> _pizzas;
  PizzeriaService _service = PizzeriaService();


  @override
  void initState() {
    /* _pizzas = PizzaData.buildList(); */
    _pizzas = _service.fetchPizzas();
  }


  /*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(widget.title, widget._cart),

        body: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: _pizzas.length,
            itemBuilder: (context, index) {
              return _buildRow(_pizzas[index]);
            }));
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget('Nos Pizzas', widget._cart),
      body: FutureBuilder(
        future: _pizzas,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _buildListView(snapshot.data!);
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Impossible de récupérer les données : ${snapshot.error}',
                style: PizzeriaStyle.errorTextStyle,
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }


  _buildListView(List<Pizza> pizzas) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: pizzas.length,
      itemBuilder: (context, index) {
        return _buildRow(pizzas[index]);
    }
      );
  }








  _buildRow(Pizza pizza) {
    return Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(10.0), top: Radius.circular(2.0)
            )
        ),

        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PizzaDetails(pizza, widget._cart, widget.title),
                    ),
                  );
                },
                child: _buildPizzaDetails(pizza),
              ),
              BuyButtonWidget(pizza, widget._cart),
            ],
        ),
    );
  }



  _buildPizzaDetails(Pizza pizza) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(pizza.title),
          subtitle: Text(pizza.garniture),
          leading: Icon(Icons.local_pizza),
        ),
        Image.asset(
          'assets/images/pizza/${pizza.image}',
          height: 120,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fitWidth,
        ),
        Container(
          padding: const EdgeInsets.all(4.0),
          child: Text(pizza.garniture),
        ),
      ],
    );
  }

}

/*
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(pizza.title),
              subtitle: Text(pizza.garniture),
              leading: Icon(Icons.local_pizza),
            ),
            Image.asset(
              'assets/images/pizza/${pizza.image}',
              height: 120,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              fit: BoxFit.fitWidth,
            ),
            Container(
              padding: const EdgeInsets.all(4.0),
              child: Text(pizza.garniture),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.red.shade800)),
                  child: Row(
                    children: [
                      Icon(Icons.shopping_cart),
                      SizedBox(width: 5),
                      Text("Commander"),
                    ],
                  ),
                  onPressed: () {
                    print('Commander une pizza');
                  },
                ),
              ],
            )
          ],
        )
    );
  }
}


*/