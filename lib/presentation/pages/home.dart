import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:testing_flutter/authentication.dart';
import 'package:testing_flutter/presentation/manager/app_state.dart';
import 'package:testing_flutter/presentation/pages/say_thanks.dart';
import 'package:testing_flutter/presentation/widgets/pizza_list.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    super.key,
    required this.loggedIn,
    required this.signOut,
  });

  final bool loggedIn;
  final void Function() signOut;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ApplicationState>(context, listen: false);
    if (widget.loggedIn) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Nostra Pizza'),
          centerTitle: true,
        ),
        body: const PizzaList(),
        floatingActionButton: FloatingActionButton(
          child: Text('${provider.orders.length}'),
          onPressed: () {
            provider.orders.clear();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SayThanks(),
              ),
            );
          },
        ),
      );
    } else {
      return const Authentication();
    }
  }
}
