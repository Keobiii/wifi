import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wifi/bloc/connection_cubit.dart';
import 'package:wifi/pages/HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color.fromRGBO(24, 24, 32, 1),
      ),
      home: BlocProvider(create: (_) => ConnectionCubit(), child: HomePage()),
    );
  }
}
