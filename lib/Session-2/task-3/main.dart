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

  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    loadTheme();
  }

  Future<void> loadTheme() async {

    SharedPreferences prefs =
    await SharedPreferences.getInstance();

    setState(() {
      isDarkMode = prefs.getBool("theme") ?? false;
    });
  }

  Future<void> saveTheme(bool value) async {

    SharedPreferences prefs =
    await SharedPreferences.getInstance();

    await prefs.setBool(
      "theme",
      value,
    );
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      theme: ThemeData.light(),

      darkTheme: ThemeData.dark(),

      themeMode:
      isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light,

      home: HomePage(

        isDarkMode: isDarkMode,

        onChanged: (value) {

          setState(() {

            isDarkMode = value;

          });

          saveTheme(value);

        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {

  final bool isDarkMode;
  final ValueChanged<bool> onChanged;

  const HomePage({

    super.key,

    required this.isDarkMode,

    required this.onChanged,

  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

        appBar: AppBar(

          title: const Text(
            "Settings",
          ),

          centerTitle: true,

        ),

        body: Padding(

          padding: const EdgeInsets.all(20),

          child: Column(

            children: [

            const SizedBox(
            height: 30,
          ),

          const CircleAvatar(

            radius: 45,

            child: Icon(

              Icons.person,

              size: 50,

            ),
          ),

          const SizedBox(
            height: 20,
          ),

          const Text(

            "Instagram Settings",

            style: TextStyle(

              fontSize: 22,

              fontWeight: FontWeight.bold,

            ),
          ),

          const SizedBox(
            height: 30,
          ),

          Card(

            elevation: 5,

            child: ListTile(

              leading: Icon(

                isDarkMode

                    ? Icons.dark_mode

                    : Icons.light_mode,

              ),

              title: const Text(

                "Dark Mode",

              ),

              subtitle: const Text(

                "Enable Dark Theme",

              ),

              trailing: Switch(

                value: isDarkMode,

                onChanged: onChanged,

              ),

            ),

          ),

          const SizedBox(
            height: 25,
          ),            Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? Colors.grey.shade800
                      : Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [

                    Icon(
                      isDarkMode
                          ? Icons.dark_mode
                          : Icons.light_mode,
                      size: 70,
                      color: isDarkMode
                          ? Colors.amber
                          : Colors.orange,
                    ),

                    const SizedBox(height: 15),

                    Text(
                      isDarkMode
                          ? "Dark Mode Enabled"
                          : "Light Mode Enabled",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      isDarkMode
                          ? "Dark theme is currently active."
                          : "Light theme is currently active.",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              const ListTile(
                leading: Icon(Icons.person),
                title: Text("Account"),
              ),

              const Divider(),

              const ListTile(
                leading: Icon(Icons.lock),
                title: Text("Privacy"),
              ),

              const Divider(),

              const ListTile(
                leading: Icon(Icons.notifications),
                title: Text("Notifications"),
              ),

              const Divider(),

              const ListTile(
                leading: Icon(Icons.help),
                title: Text("Help & Support"),
              ),
            ],
          ),
        ),
    );
  }
}
