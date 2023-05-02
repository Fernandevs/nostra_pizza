import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:testing_flutter/presentation/manager/app_state.dart';
import 'package:testing_flutter/authentication.dart';
import 'package:testing_flutter/presentation/pages/home.dart';
import 'package:testing_flutter/firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ChangeNotifierProvider(
    create: (context) => ApplicationState(),
    builder: ((context, child) => const MyApp()),
  ));
}

final _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => Consumer<ApplicationState>(
        builder: (context, appState, _) => DashboardScreen(
          loggedIn: appState.loggedIn,
          signOut: () {
            FirebaseAuth.instance.signOut();
          },
        ),
      ),
      routes: <RouteBase>[
        GoRoute(
          path: 'sign-in',
          builder: (context, state) => const Authentication(),
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: _router,
    );
  }
}
