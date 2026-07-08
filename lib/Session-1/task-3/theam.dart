import 'package:flutter/material.dart';
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

class HomePage extends StatelessWidget {

  final bool isDark;
  final ValueChanged<bool> onChanged;

  const HomePage({
    super.key,
    required this.isDark,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Instagram Settings"),
          centerTitle: true,
        ),

        body: Padding(
          padding: const EdgeInsets.all(15),

          child: Column(
              children: [

              const SizedBox(height: 20),

          CircleAvatar(
            radius: 45,
            backgroundColor: Colors.blue,
            child: const Icon(
              Icons.person,
              color: Colors.white,
              size: 45,
            ),
          ),

          const SizedBox(height: 15),

          const Text(
            "Riddhita Gosai",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 30),

          Card(
            elevation: 5,
            child: ListTile(
              leading: Icon(
                isDark
                    ? Icons.dark_mode
                    : Icons.light_mode,
              ),

              title: const Text(
                "Dark Mode",
              ),

              subtitle: const Text(
                "Enable or Disable Theme",
              ),

              trailing: Switch(
                value: isDark,
                onChanged: onChanged,
              ),
            ),
          ),

          const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey.shade800 : Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        isDark ? Icons.dark_mode : Icons.light_mode,
                        size: 60,
                        color: isDark ? Colors.amber : Colors.orange,
                      ),

                      const SizedBox(height: 10),

                      Text(
                        isDark
                            ? "Dark Mode is Enabled"
                            : "Light Mode is Enabled",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        "Your theme preference is saved using SharedPreferences. "
                            "After closing and reopening the app, the selected theme "
                            "will be remembered automatically.",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                const ListTile(
                  leading: Icon(Icons.person),
                  title: Text("Account"),
                ),

                const ListTile(
                  leading: Icon(Icons.lock),
                  title: Text("Privacy"),
                ),

                const ListTile(
                  leading: Icon(Icons.notifications),
                  title: Text("Notifications"),
                ),

                const ListTile(
                  leading: Icon(Icons.help),
                  title: Text("Help"),
                ),
              ],
          ),
        ),
    );
  }
}
