import 'package:flutter/material.dart';

class SayThanks extends StatelessWidget {
  const SayThanks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Gracias'),
      ),
      body: const Center(
        child: Text('Gracias por su compra'),
      ),
    );
  }
}
