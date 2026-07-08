import 'package:flutter/material.dart';
import 'package:module_5/session%202/task%202.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool? isLoggedIn;

  @override
  void initState() {
    super.initState();
    getLoginStatus();
  }

  // Read Login Status
  Future<void> getLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      isLoggedIn = prefs.getBool("isLoggedIn") ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {

    if (isLoggedIn == null) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoggedIn!
          ? const HomeScreen()
          : const LoginScreen(),
    );
  }
}
