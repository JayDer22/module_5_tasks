import 'package:flutter/material.dart';
import 'package:module_5/session%201/task%203.dart';
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

  bool isDark = false;

  @override
  void initState() {
    super.initState();
    loadTheme();
  }

  Future<void> loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      isDark = prefs.getBool("theme") ?? false;
    });
  }

  Future<void> saveTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("theme", value);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),

      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,

      home: HomePage(
        isDark: isDark,
        onChanged: (value) {
          setState(() {
            isDark = value;
          });

          saveTheme(value);
        },
      ),
    );
  }
}
