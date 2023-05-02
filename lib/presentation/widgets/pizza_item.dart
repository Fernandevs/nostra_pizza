import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:testing_flutter/domain/entities/pizza.dart';
import 'package:testing_flutter/presentation/manager/app_state.dart';

class PizzaItem extends StatefulWidget {
  const PizzaItem({
    Key? key,
    required this.pizza
  }) : super(key: key);
  
  final Pizza pizza;

  @override
  State<PizzaItem> createState() => _PizzaItemState();
}

class _PizzaItemState extends State<PizzaItem> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            final snackBar = SnackBar(
              content: Text('Haz agregado la orden ${widget.pizza}'),
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Provider.of<ApplicationState>(context, listen: false).addOrder(widget.pizza);

            debugPrint('\nOrder:\n ${ Provider.of<ApplicationState>(context, listen: false).orders }');
          },
          child: Row(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                child: widget.pizza.image != null
                    ? Image.asset(widget.pizza.image!)
                    : const Icon(
                        Icons.local_pizza_rounded,
                        size: 100,
                      ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Text(
                        widget.pizza.title,
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.deepPurpleAccent,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        widget.pizza.description,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
