import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_template/error_handling_screen/not_found_screen.dart';
import 'package:flutter_riverpod_template/routes/app_routes_key.dart';
import 'package:flutter_riverpod_template/screens/splash_screen/splash_screen.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: kDebugMode,
    routes: [
      GoRoute(path: AppRoutesKey.instance.splash, name: AppRoutesKey.instance.splash, builder: (context, state) => SplashScreen()),
      GoRoute(path: AppRoutesKey.instance.splash, name: AppRoutesKey.instance.splash, builder: (context, state) => SplashScreen()),
      GoRoute(path: AppRoutesKey.instance.splash, name: AppRoutesKey.instance.splash, builder: (context, state) => SplashScreen()),
    ],
    errorBuilder: (context, state) {
      return NotFoundScreen();
    },
  );
});
