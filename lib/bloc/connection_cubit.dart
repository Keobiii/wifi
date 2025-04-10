import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        switch (result) {
          case ConnectivityResult.wifi:
            bool hasInternet = await _checkInternetConnection();
            if (hasInternet) {
              emit(Connectionstatus.connectedToWifi);
              print("Connected");
            } else {
              emit(Connectionstatus.wifiNoInternet);
              print("Not Connected");
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

  Future<bool> _checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup(
        'google.com',
      ).timeout(Duration(seconds: 5));
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}
