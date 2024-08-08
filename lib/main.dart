import 'package:blogs/Home/bloc/home_bloc.dart';
import 'package:blogs/Home/services/services.dart';
import 'package:blogs/Home/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => HomeBloc( apiServices: ApiServices() ),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: BlocProvider(
            create: (context) => HomeBloc( apiServices: ApiServices()),
            child: const Home(),
          ),
        ));
  }
}
