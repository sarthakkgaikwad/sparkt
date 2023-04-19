import 'package:assignment/repository/user.dart';
import 'package:assignment/state/country_provider.dart';
import 'package:assignment/state/user_provider.dart';
import 'package:assignment/ui/task_1.dart';
import 'package:assignment/ui/task_2.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CountryProvider(),
          child: const Task2(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
          child: const Task1(),
        )
      ],
      child: MaterialApp(
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: const Task1(),
      ),
    );
  }
}


