import 'dart:convert';

import 'package:testing_flutter/domain/entities/pizza.dart';

class Command {
  String user;
  DateTime? datetime;
  Map<Pizza, int> orders;
  int pizzas;
  double subtotal;
  double total;

  Command(this.user, this.orders, this.pizzas, this.subtotal, this.total) {
    datetime = DateTime.now();
  }

  Map<String, dynamic> toJson() {
    final orderKeys = orders.keys.toList();
    final orderValues = orders.values.toList();
    final List<Map<String, dynamic>> command = [
      {
        'description': orderKeys[0].description,
        'title': orderKeys[0].title,
        'price': orderKeys[0].price,
        'quantity': orderValues[0],
      },
      {
        'description': orderKeys[1].description,
        'title': orderKeys[1].title,
        'price': orderKeys[1].price,
        'quantity': orderValues[1],
      },
      {
        'description': orderKeys[2].description,
        'title': orderKeys[2].title,
        'price': orderKeys[2].price,
        'quantity': orderValues[2],
      },
    ];

    return {
      'user': user,
      'datetime': datetime,
      'order': {
        'command': command,
        'pizzas': pizzas,
        'subtotal': subtotal,
        'total': total,
      }
    };
  }

  @override
  String toString() {
    return 'Command: {\n'
        '\tuser: $user,\n'
        '\tdatetime: $datetime,\n'
        '\torders:$orders,\n'
        '\tpizzas: $pizzas,\n'
        '\tsubtotal: $subtotal,\n'
        '\ttotal: $total\n'
        '}\n';
  }
}

/*
*
            'user': firebaseAuth.currentUser?.email,
            'datetime': now,
            'order': {
              'description': {
                jsonEncode(pizzas),
              },
              'pizzas': Provider.of<ApplicationState>(context).pizzas,
              'subtotal': Provider.of<ApplicationState>(context).subtotal,
              'total': Provider.of<ApplicationState>(context).total,
            }
* */
