import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wifi/bloc/connection_cubit.dart';
import 'package:wifi/utils/ConnectionStatus.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ConnectionCubit, Connectionstatus>(
        listener: (context, state) {
          if (state == Connectionstatus.loading) {
            // Show loading indicator when state is loading
            setState(() {
              showLoading = true;
            });

            // Hide loading indicator after 3 seconds
            Future.delayed(Duration(seconds: 3), () {
              setState(() {
                showLoading = false;
              });
            });
          } else {
            // Hide loading indicator when state is updated
            setState(() {
              showLoading = false;
            });
          }
        },
        child: BlocBuilder<ConnectionCubit, Connectionstatus>(
          builder: (context, state) {
            if (showLoading) {
              return Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            }

            return _buildConnectionStatusBasedOnState(state);
          },
        ),
      ),
    );
  }

  Widget _buildConnectionStatusBasedOnState(Connectionstatus state) {
    if (state == Connectionstatus.connectedToWifi) {
      return _buildConnectionStatus(
        'assets/images/wifi.png',
        'Connected to Wifi',
      );
    } else if (state == Connectionstatus.wifiNoInternet) {
      return _buildConnectionStatus(
        'assets/images/no_connection.png',
        'Internet Access Available',
      );
    } else if (state == Connectionstatus.connectedToMobile) {
      return _buildConnectionStatus(
        'assets/images/mobile_data.png',
        'Connected to Mobile Data',
      );
    } else if (state == Connectionstatus.noInternetConnection) {
      return _buildConnectionStatus(
        'assets/images/no_connection.png',
        'No Internet Connection',
      );
    } else if (state == Connectionstatus.internetAvailableButNoConnection) {
      return _buildConnectionStatus(
        'assets/images/no_connection.png',
        'No Internet, But Connected',
      );
    }

    return SizedBox();
  }

  // Function to create connection status UI
  Widget _buildConnectionStatus(String imagePath, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 150,
            width: 150,
            child: Image.asset(imagePath, fit: BoxFit.contain),
          ),
          Text(message, style: TextStyle(fontSize: 20, color: Colors.white)),
        ],
      ),
    );
  }
}
