import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_template/error_handling_screen/error_screen.dart';
import 'package:flutter_riverpod_template/routes/app_routes.dart';
import 'package:flutter_riverpod_template/utils/app_size.dart';
import 'package:flutter_riverpod_template/utils/app_theme.dart';
import 'package:flutter_riverpod_template/utils/app_theme_configuration.dart';
import 'package:flutter_riverpod_template/utils/observer/logger_ob_server.dart';

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();
final AppRoutes appRoutes = AppRoutes.instance;
final GlobalKey<OverlayState> appOverlayKey = GlobalKey<OverlayState>();

class MainAppEntry extends StatefulWidget {
  const MainAppEntry({super.key});

  @override
  State<MainAppEntry> createState() => _MainAppEntryState();
}

class _MainAppEntryState extends State<MainAppEntry> {
  Key providerKey = UniqueKey();
  void resetRiverpod() {
    setState(() {
      providerKey = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    /////////////////
    AppSize.size = MediaQuery.of(context).size;

    //////////////// main services
    return ProviderScope(
      key: providerKey,
      observers: [LoggerObServer()],
      child: MainApp(),
    );
  }
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  @override
  Widget build(BuildContext context) {
    final ThemeMode themeMode = ref.watch(themeProvider);
    return MaterialApp.router(
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      routerConfig: appRoutes.router,
      title: "Flutter",
      color: Colors.white,
      themeAnimationCurve: Curves.easeInOut,
      themeAnimationDuration: Duration.zero,
      theme: AppThemeConfiguration.instance.lightThemeData,
      darkTheme: AppThemeConfiguration.instance.darkThemeData,
      themeMode: themeMode,

      builder: (context, child) {
        ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
          return Overlay(
            key: appOverlayKey,
            initialEntries: [OverlayEntry(builder: (context) => ErrorScreen())],
          );
        };

        return Overlay(
          key: appOverlayKey,
          initialEntries: [
            OverlayEntry(builder: (context) => child ?? SizedBox()),
          ],
        );
      },
    );
  }
}
