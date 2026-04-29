import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_template/utils/app_log.dart';

const String _reachabilityUrl = 'clients3.google.com';
const String _reachabilityPath = '/generate_204';

Future<bool> _isActuallyOnline() async {
  try {
    final client = HttpClient()..connectionTimeout = const Duration(seconds: 5);
    final request = await client.getUrl(Uri.http(_reachabilityUrl, _reachabilityPath));
    final response = await request.close();
    client.close();
    return response.statusCode == 204;
  } catch (_) {
    return false;
  }
}

final internetStatusProvider = StreamProvider<bool>((ref) async* {
  yield await _isActuallyOnline();

  await for (final result in Connectivity().onConnectivityChanged) {
    if (result.contains(ConnectivityResult.none)) {
      yield false;
    } else {
      final online = await _isActuallyOnline();
      appLog('Internet reachability check: $online');
      yield online;
    }
  }
});
