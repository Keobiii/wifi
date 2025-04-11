import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:wifi/utils/ConnectionStatus.dart';

class ConnectionCubit extends Cubit<Connectionstatus> {
  final Connectivity _connection = Connectivity();

  ConnectionCubit() : super(Connectionstatus.loading) {
    monitorConnection();
  }

  void monitorConnection() {
    _connection.onConnectivityChanged.listen((
      List<ConnectivityResult> results,
    ) async {
      for (var result in results) {
        // first initialization is loading
        emit(Connectionstatus.loading);

        // then delayed 3 seconds and proceed to the status
        await Future.delayed(Duration(seconds: 3));

        switch (result) {
          case ConnectivityResult.wifi:
            if (await checkInternetAccess()) {
              emit(Connectionstatus.connectedToWifi);
            } else {
              emit(Connectionstatus.internetAvailableButNoConnection);
            }
            break;
          case ConnectivityResult.mobile:
            emit(Connectionstatus.connectedToMobile);
            break;
          case ConnectivityResult.none:
            emit(Connectionstatus.noInternetConnection);
            break;
          default:
            emit(Connectionstatus.loading);
        }
      }
    });
  }

  // connect to google and check if status
  // if theres conenection then its connected else not
  Future<bool> checkInternetAccess() async {
    try {
      final result = await InternetAddress.lookup('https://www.google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } catch (_) {
      return false;
    }
    return false;
  }
}
