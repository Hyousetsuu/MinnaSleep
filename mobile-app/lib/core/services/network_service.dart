import 'dart:async';
// import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkService {
  NetworkService._privateConstructor();
  static final NetworkService instance = NetworkService._privateConstructor();

  final StreamController<bool> _networkStatusController = StreamController<bool>.broadcast();
  Stream<bool> get onStatusChanged => _networkStatusController.stream;

  bool _isOnline = true; // Assume online by default
  bool get isOnline => _isOnline;
  bool get isOffline => !_isOnline;

  void initialize() {
    // Mocking connectivity plus
    // Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
    //   _isOnline = !result.contains(ConnectivityResult.none);
    //   _networkStatusController.add(_isOnline);
    // });
  }

  void dispose() {
    _networkStatusController.close();
  }
}
