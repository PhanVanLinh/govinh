import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'package:govinh/home_screen.dart';
import 'package:govinh/redeem_screen.dart';
import 'package:govinh/redeem_success_screen.dart';
import 'package:govinh/theme_data.dart';

void main() {
  usePathUrlStrategy();
  runApp(const MyApp());
}

/// govinh
//     home, listed all shop
//     /redeem/{code}
//       / input phone number
//       / -> submit
//     / -> success screen
//     /

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/a',
      builder: (context, state) => const RedeemScreen(id: '123',),
    ),
    GoRoute(
      path: '/redeem/:id',
      builder: (context, state) =>  RedeemScreen(id: state.pathParameters['id']),
    ),
    GoRoute(
      path: '/redeem/success/:phone',
      builder: (context, state) =>  RedeemSuccessScreen(id: state.pathParameters['phone']),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: theme,
      routerConfig: _router,
    );
  }
}