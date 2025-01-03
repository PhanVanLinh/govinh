import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'package:govinh/feature/codes/codes_screen.dart';
import 'package:govinh/feature/home/home_screen.dart';
import 'package:govinh/feature/redeem/redeem_screen.dart';
import 'package:govinh/feature/user_rewards/redeem_success_screen.dart';
import 'package:govinh/theme_data.dart';

void main() async {
  usePathUrlStrategy();
  await dotenv.load(fileName: ".env");
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
      path: '/codes/:start/:end',
      builder: (context, state) =>  CodesScreen(
        start: int.parse(state.pathParameters['start'] ?? ""),
        end: int.parse(state.pathParameters['end'] ?? ""),
        adminKey: state.uri.queryParameters['key'] ?? "",
        shopId: state.uri.queryParameters['shop_id'] ?? "",
      ),
    ),
    GoRoute(
      path: '/redeem/:shopSlug/:id',
      builder: (context, state) =>  RedeemScreen(
          shopSlug: state.pathParameters['shopSlug'],
          code: state.pathParameters['id']),
    ),
    GoRoute(
      path: '/redeem-success/:phone',
      builder: (context, state) =>  RedeemSuccessScreen(phone: state.pathParameters['phone']),
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