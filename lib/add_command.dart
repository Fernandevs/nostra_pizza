import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'package:testing_flutter/domain/entities/command.dart';
import 'package:testing_flutter/presentation/manager/app_state.dart';
import 'package:testing_flutter/presentation/pages/say_thanks.dart';

class AddCommand extends StatefulWidget {
  const AddCommand({
    Key? key,
  }) : super(key: key);

  @override
  State<AddCommand> createState() => _AddCommandState();
}

class _AddCommandState extends State<AddCommand> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ApplicationState>(context, listen: false);
    final orders = provider.orders;
    final pizzas = provider.pizzas;
    final subtotal = provider.subtotal;
    final total = provider.total;

    return Material(
      child: TextButton(
        onPressed: () {
          CollectionReference orderDB = FirebaseFirestore.instance.collection('command');
          final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
          final Command command = Command(
            (firebaseAuth.currentUser?.email)!,
            orders,
            pizzas,
            subtotal,
            total,
          );

          orderDB.add(command.toJson()).then(
            (value) {
              const snackBar = SnackBar(
                content: Text('Su orden ha sido guardada'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              debugPrint('Command added');

              provider.orders.clear();

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SayThanks(),
                ),
              );
            },
          ).catchError(
            (error) {
              debugPrint('Fallo al intentar agregar la comanda: $error');
            },
          );
        },
        child: const Text('Guardar su pedido'),
      ),
    );
  }
}
