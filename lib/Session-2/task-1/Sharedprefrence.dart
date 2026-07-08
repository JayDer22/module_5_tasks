import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage2 extends StatelessWidget {
  const HomePage2({super.key});

  Future<void> saveThemePreference(bool isDarkMode) async {

    SharedPreferences prefs =
    await SharedPreferences.getInstance();

    await prefs.setBool(
      "theme",
      isDarkMode,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SharedPreferences"),
      ),

      body: Center(
        child: ElevatedButton(
          onPressed: () {

            saveThemePreference(true);

          },

          child: const Text("Save Dark Theme"),
        ),
      ),
    );
  }
}
