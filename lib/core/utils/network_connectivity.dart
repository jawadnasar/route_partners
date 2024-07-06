import 'dart:async';

// import 'package:bike_gps/core/enums/network_status.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:route_partners/core/enums/network_status.dart';

class NetworkConnectivity {
  //singleton instance
  static NetworkConnectivity get instance => NetworkConnectivity();

  StreamController<NetworkStatus> networkStatusStream =
      StreamController<NetworkStatus>();

  //method to check if the device is connected to network
  Future<NetworkStatus> getNetworkStatus() async {
  // Initializing ConnectivityResult
  List<ConnectivityResult> result = await Connectivity().checkConnectivity();

  // Checking if the device is connected to a network
  NetworkStatus networkStatus = result == ConnectivityResult.none
      ? NetworkStatus.offline
      : NetworkStatus.online;

  return networkStatus;
}

}
