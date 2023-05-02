import 'package:flutter/material.dart';
import 'package:testing_flutter/command.dart';
import 'package:testing_flutter/domain/entities/pizza.dart';
import 'package:testing_flutter/presentation/widgets/pizza_item.dart';

class PizzaList extends StatelessWidget {
  const PizzaList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        PizzaItem(
          pizza: Pizza(
            description: 'Pizza de 4 quesos',
            title: 'Pizza 4 quesos',
            price: 120.0,
          ),
        ),
        PizzaItem(
          pizza: Pizza(
            description: 'Pizza de peperoni',
            title: 'Pizza de pepperoni',
            price: 100,
          ),
        ),
        PizzaItem(
          pizza: Pizza(
            description: 'Pizza Mexicana',
            title: 'Pizza Mexicana',
            price: 110,
          ),
        ),
      ],
    );
  }
}
