import 'package:flutter_riverpod_template/constant/app_api_url.dart';
import 'package:flutter_riverpod_template/services/storage/storage_services.dart';
import 'package:flutter_riverpod_template/utils/app_log.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class AppSocketAllOperation {
  AppSocketAllOperation._privateConstructor();
  static final AppSocketAllOperation _instance = AppSocketAllOperation._privateConstructor();
  static AppSocketAllOperation get instance => _instance;

  io.Socket? appRootSocket;
  bool _isConnecting = false;
  final Map<String, List<void Function(dynamic)>> _eventHandlers = {};

  bool get isConnected => appRootSocket?.connected == true;

  Future<void> initializeSocket() async {
    if (appRootSocket != null) return;

    await _connectSocketToServer();
  }

  void readEvent({required String event, required void Function(dynamic) handler}) {
    try {
      _eventHandlers.putIfAbsent(event, () => []).add(handler);
      if (isConnected) {
        _setupEventListener(event, handler);
      } else {
        initializeSocket();
      }
    } catch (e, stackTrace) {
      errorLog("readEvent ($event)$e", stackTrace);
    }
  }

  void _setupEventListener(String event, void Function(dynamic) handler) {
    appRootSocket?.off(event);
    appRootSocket?.on(event, (data) {
      appLog("Received event: $event ");
      appLog("with data: $data");
      handler(data);
    });
  }

  void emitEvent(String event, dynamic data) {
    try {
      if (isConnected) {
        appRootSocket?.emit(event, data);
      } else {
        initializeSocket().then((_) {
          _onceConnected(() => appRootSocket?.emit(event, data));
        });
      }
    } catch (e, stackTrace) {
      errorLog("emitEvent ($event) $e", stackTrace);
    }
  }

  void _onceConnected(void Function() callback) {
    if (isConnected) {
      callback();
      return;
    }

    void listener(dynamic listener) {
      try {
        callback();
        appRootSocket?.off('connect', listener);
      } catch (e) {
        errorLog("_onceConnected listener", e);
      }
    }

    appRootSocket?.on('connect', listener);
  }

  Future<void> _connectSocketToServer() async {
    try {
      if (appRootSocket != null || _isConnecting) return;
      _isConnecting = true;
      appLog("Attempting to connect socket...");
      final token = await StorageServices.instance.getToken();
      appRootSocket = io.io(
        AppApiUrl.socket,
        io.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .enableReconnection()
            .setExtraHeaders({'foo': 'bar', if (token.isNotEmpty) 'Authorization': 'Bearer $token'})
            .setAuth({if (token.isNotEmpty) 'token': token})
            .build(),
      );

      appRootSocket?.onConnect((_) {
        _isConnecting = false;
        appLog("Socket connected");

        for (final entry in _eventHandlers.entries) {
          final event = entry.key;
          final handlers = entry.value;
          for (final handler in handlers) {
            _setupEventListener(event, handler);
          }
        }
      });

      appRootSocket?.onDisconnect((_) {
        errorLog("Socket disconnected", "");
        _isConnecting = false;
      });

      appRootSocket?.onConnectError((data) {
        errorLog("Connect error", data);
        _isConnecting = false;
      });

      appRootSocket?.onError((data) {
        errorLog("Error", data);
        _isConnecting = false;
      });

      appRootSocket?.onReconnect((_) {
        appLog("Socket reconnected");
      });

      appRootSocket?.connect();
    } catch (e, stackTrace) {
      _isConnecting = false;
      errorLog("_connectSocketToServer $e", stackTrace);
    }
  }

  void reconnect() {
    if (!isConnected && !_isConnecting) {
      initializeSocket();
    }
  }

  void dispose() {
    if (appRootSocket != null) {
      appRootSocket?.disconnect();
      appRootSocket?.dispose();
      appRootSocket = null;
    }
    _eventHandlers.clear();
    _isConnecting = false;
  }
}
