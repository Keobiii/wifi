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
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        showLoading = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ConnectionCubit, Connectionstatus>(
        builder: (context, state) {
          if (state == Connectionstatus.loading) {
            return showLoading
                ? Center(child: CircularProgressIndicator())
                : SizedBox();
          } else if (state == Connectionstatus.connectedToWifi) {
            showLoading = false;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    child: Image.asset(
                      'assets/images/wifi.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  Text(
                    'Connected to Wifi',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
            );
          } else if (state == Connectionstatus.wifiNoInternet) {
            showLoading = false;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    child: Image.asset(
                      'assets/images/no_connection.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  Text(
                    'Internet Access Available',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
            );
          } else if (state == Connectionstatus.connectedToMobile) {
            showLoading = false;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    child: Image.asset(
                      'assets/images/mobile_data.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  Text(
                    'Connected to Mobile Data',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
            );
          } else if (state == Connectionstatus.noInternetConnection) {
            showLoading = false;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    child: Image.asset(
                      'assets/images/no_connection.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  Text(
                    'No Internet Connection',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
