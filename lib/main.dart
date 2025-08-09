import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod_template/main_app_entry.dart';
import 'package:flutter_riverpod_template/services/storage/storage_services.dart';
import 'package:flutter_riverpod_template/widgets/texts/app_date_time_formate.dart';

Future<void> main() async {
  //////////////  flutter binding initialize
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  ///////////native splash
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  ///////////// devices orientation set
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown]);
  ////////////// network
  HttpOverrides.global = MyHttpOverrides();
  //////////////////// storage services Initialize
  await StorageServices.instance.init();
  runApp(const MainAppEntry());
  ////////// time formate
  await AppDateTimeFormate.instance.initial();
  ///////////native splash remove
  FlutterNativeSplash.remove();
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (cert, host, port) => true;
  }
}
