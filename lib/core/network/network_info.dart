import 'package:connectivity_plus/connectivity_plus.dart';

/// Abstract class for network information
abstract class NetworkInfo {
  /// Check if the device is connected to the internet
  Future<bool> get isConnected;
  
  /// Stream of connectivity changes
  Stream<bool> get onConnectivityChanged;
}
 

 class NetworkInfoImpl implements NetworkInfo {
 final Connectivity _connectivity;
    const NetworkInfoImpl(this._connectivity);

  @override
  Future<bool> get isConnected async {
    final result = await _connectivity.checkConnectivity();
    return isNetworkAvailable(result);
  }
  
  @override
  Stream<bool> get onConnectivityChanged {  
    return _connectivity.onConnectivityChanged.map(isNetworkAvailable);
  }
 


 }


bool isNetworkAvailable(List<ConnectivityResult> results) {
  return results.any((result) => 
    result == ConnectivityResult.ethernet || 
    result == ConnectivityResult.wifi || 
    result == ConnectivityResult.mobile || 
    result == ConnectivityResult.bluetooth
  );

}



