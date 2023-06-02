// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:testing_flutter/domain/entities/pizza.dart';

import '../../firebase_options.dart';

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    _orders = {
      cheese: 0,
      pepperoni: 0,
      mexican: 0,
    };
    init();
  }

  bool _loggedIn = false;

  bool get loggedIn => _loggedIn;

  final Pizza _cheese = Pizza(
    description: 'Pizza de 4 quesos',
    title: 'Pizza 4 quesos',
    price: 120.0,
  );

  Pizza get cheese => _cheese;

  final Pizza _pepperoni = Pizza(
    description: 'Pizza de peperoni',
    title: 'Pizza de pepperoni',
    price: 100,
  );

  Pizza get pepperoni => _pepperoni;

  final Pizza _mexican = Pizza(
    description: 'Pizza Mexicana',
    title: 'Pizza Mexicana',
    price: 110,
  );

  Pizza get mexican => _mexican;

  late Map<Pizza, int> _orders = {
    cheese: 0,
    pepperoni: 0,
    mexican: 0,
  };

  Map<Pizza, int> get orders => _orders;

  int _pizzas = 0;
  int get pizzas => _pizzas;

  double _subtotal = 0;
  double get subtotal => _subtotal;
  double get total => _subtotal * .16 + _subtotal;

  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
    ]);

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loggedIn = true;
      } else {
        _loggedIn = false;
      }
      notifyListeners();
    });
  }

  void addOrder(Pizza order) {
    switch (order.title) {
      case 'Pizza 4 quesos':
        _orders[cheese] = (_orders[cheese]! + 1);
        break;
      case 'Pizza de pepperoni':
        _orders[pepperoni] = (_orders[pepperoni]! + 1);
        break;
      case 'Pizza Mexicana':
        _orders[mexican] = (_orders[mexican]! + 1);
        break;
    }

    _subtotal += order.price;
    _pizzas ++;

    notifyListeners();
  }
}
