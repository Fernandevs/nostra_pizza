import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:testing_flutter/add_command.dart';
import 'package:testing_flutter/domain/entities/pizza.dart';
import 'package:testing_flutter/presentation/manager/app_state.dart';

class CommandDetail extends StatelessWidget {
  const CommandDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de la orden'),
      ),
      body: Builder(
        builder: (BuildContext context) {
          final provider = Provider.of<ApplicationState>(context, listen: false);
          Map<Pizza, int> pizzas = provider.orders;
          List<Widget> widgets = [];
          double subtotal = 0;

          pizzas.forEach((key, value) {
            if (value > 0) {
              subtotal += key.price * value;

              widgets.add(
                ListTile(
                  title: Text(key.title),
                  subtitle: Text('Cantidad: $value\ncosto: ${key.price * value}'),
                ),
              );
            }
          });

          widgets.add(
            ListTile(
              title: const Text('Subtotal'),
              subtitle: Text('$subtotal'),
            ),
          );

          widgets.add(
            ListTile(
              title: const Text('Total'),
              subtitle: Text('${subtotal * .16 + subtotal}'),
            ),
          );

          widgets.add(const AddCommand());

          return Material(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: widgets.length,
                itemBuilder: (context, index) {
                  return widgets[index];
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
