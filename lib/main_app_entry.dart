import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_template/routes/app_routes.dart';
import 'package:flutter_riverpod_template/utils/app_size.dart';
import 'package:flutter_riverpod_template/utils/app_theme.dart';
import 'package:flutter_riverpod_template/utils/app_theme_configuration.dart';

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
final AppRoutes appRoutes = AppRoutes.instance;

class MainAppEntry extends ConsumerStatefulWidget {
  const MainAppEntry({super.key});

  @override
  ConsumerState<MainAppEntry> createState() => _MainAppEntryState();
}

class _MainAppEntryState extends ConsumerState<MainAppEntry> {
  @override
  Widget build(BuildContext context) {
    /////////////////
    AppSize.size = MediaQuery.of(context).size;
    final ThemeMode themeMode = ref.watch(themeProvider);

    //////////////// main services
    return MaterialApp.router(
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      routerConfig: appRoutes.router,
      title: "IgniBlu",
      color: Colors.white,
      themeAnimationCurve: Curves.easeInOut,
      themeAnimationDuration: Duration.zero,
      theme: AppThemeConfiguration.instance.lightThemeData,
      darkTheme: AppThemeConfiguration.instance.darkThemeData,
      themeMode: themeMode,
    );
  }
}
