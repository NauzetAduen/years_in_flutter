import 'package:connectivity/connectivity.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;

  NetworkInfoImpl(this.connectivity);
  @override
  Future<bool> get isConnected async {
    return ConnectivityResult.none != await connectivity.checkConnectivity();
  }
}
