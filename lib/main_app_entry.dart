import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_template/routes/app_routes.dart';
import 'package:flutter_riverpod_template/routes/app_routes_config.dart';
import 'package:flutter_riverpod_template/utils/app_log.dart';
import 'package:flutter_riverpod_template/utils/app_size.dart';
import 'package:flutter_riverpod_template/utils/app_theme.dart';
import 'package:flutter_riverpod_template/utils/app_theme_configuration.dart';

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class MainAppEntry extends ConsumerStatefulWidget {
  const MainAppEntry({super.key});

  @override
  ConsumerState<MainAppEntry> createState() => _MyWidgetState();
}

class _MyWidgetState extends ConsumerState<MainAppEntry> {
  void onInitialData() {
    try {
      final router = ref.watch(routerProvider);
      AppRoutes.instance.setRouter(router);
      Size size = MediaQuery.of(context).size;
      AppSize.size = size;
    } catch (e) {
      errorLog("onInitialData", e);
    }
  }

  @override
  void initState() {
    super.initState();
    onInitialData();
  }

  @override
  Widget build(BuildContext context) {
    /////////////////
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeProvider);
    //////////////// main services
    return MaterialApp.router(
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      title: "App",
      color: Colors.white,
      themeAnimationCurve: Curves.easeInOut,
      themeAnimationDuration: Duration.zero,
      theme: AppThemeConfiguration.instance.lightThemeData,
      darkTheme: AppThemeConfiguration.instance.darkThemeData,
      themeMode: themeMode,
    );
  }
}

// class MainAppEntry extends ConsumerWidget {
//   const MainAppEntry({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {

//   }
// }
