import 'package:connectivity/connectivity.dart';

class NetworkCheck {
  // singleton boilerplate
  NetworkCheck._internal();

  static final NetworkCheck _singleInstance = NetworkCheck._internal();

  factory NetworkCheck() => _singleInstance;

  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  dynamic checkInternet(Function func) {
    check().then((internet) {
      if (internet != null && internet) {
        func(true);
      } else {
        func(false);
      }
    });
  }
}
