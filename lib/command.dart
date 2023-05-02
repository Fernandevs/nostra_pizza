import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing_flutter/presentation/manager/app_state.dart';

class Command extends StatefulWidget {
  const Command({
    Key? key,
  }) : super(key: key);

  @override
  State<Command> createState() => _CommandState();
}

class _CommandState extends State<Command> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: TextButton(
        onPressed: () {
          debugPrint('Guardando la orden');

          CollectionReference orderDB =
              FirebaseFirestore.instance.collection('command');
          final now = DateTime.now();
          final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

          orderDB.add({
            'user': firebaseAuth.currentUser?.email,
            'datetime': now,
            'order': {'description': Provider.of<ApplicationState>(context, listen: false).orders.toList()},
          }).then(
            (value) {
              const snackBar = SnackBar(
                content: Text('Su orden ha sido guardada'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              debugPrint('Command added');
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
