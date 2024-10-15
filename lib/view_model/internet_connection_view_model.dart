import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityModel with ChangeNotifier {
  String _connectionStatus = 'Unknown';

  String get connectionStatus => _connectionStatus;

  ConnectivityModel() {
    Connectivity().onConnectivityChanged.listen((results) {
      for (var result in results) {
        _updateConnectionStatus(result);
      }
    });
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    if (result == ConnectivityResult.wifi) {
      _connectionStatus = 'Connected to Wi-Fi';
    } else if (result == ConnectivityResult.mobile) {
      _connectionStatus = 'Connected to Mobile';
    } else {
      _connectionStatus = 'No Connection';
    }
    notifyListeners();
  }
}
