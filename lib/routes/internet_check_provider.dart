import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final internetStatusProvider = StreamProvider<bool>((ref) {
  return Connectivity().onConnectivityChanged.asyncMap((connectivityResult) async {
    if (connectivityResult.contains(ConnectivityResult.none)) return false;
    return true;
  });
});
