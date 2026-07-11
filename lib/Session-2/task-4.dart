import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController usernameController =
  TextEditingController();

  TextEditingController passwordController =
  TextEditingController();

  bool rememberMe = false;

  @override
  void initState() {
    super.initState();
    loadUsername();
  }

  Future<void> loadUsername() async {

    SharedPreferences prefs =
    await SharedPreferences.getInstance();

    setState(() {

      usernameController.text =
          prefs.getString("username") ?? "";

      rememberMe =
          prefs.getBool("rememberMe") ?? false;

    });
  }

  Future<void> saveUsername() async {

    SharedPreferences prefs =
    await SharedPreferences.getInstance();

    if (rememberMe) {

      await prefs.setString(
        "username",
        usernameController.text,
      );

      await prefs.setBool(
        "rememberMe",
        true,
      );

    } else {

      await prefs.remove("username");

      await prefs.setBool(
        "rememberMe",
        false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

        appBar: AppBar(

          title: const Text("Login"),

          centerTitle: true,

        ),

        body: Padding(

          padding: const EdgeInsets.all(20),

          child: Column(

            mainAxisAlignment:
            MainAxisAlignment.center,

            children: [

            const Icon(
            Icons.person,
            size: 80,
            color: Colors.blue,
          ),

          const SizedBox(height: 20),

          TextField(
            controller: usernameController,
            decoration: const InputDecoration(
              labelText: "Username",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 15),

          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: "Password",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 15),

          Row(

            children: [

              Checkbox(

                value: rememberMe,

                onChanged: (value) {

                  setState(() {

                    rememberMe = value!;

                  });

                },

              ),

              const Text(
                "Remember Me",
              ),

            ],

          ),

          const SizedBox(height: 20),            SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {

                    await saveUsername();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Login Successful",
                        ),
                      ),
                    );

                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Card(
                elevation: 5,
                child: ListTile(
                  leading: const Icon(
                    Icons.info,
                    color: Colors.blue,
                  ),
                  title: const Text("Remember Me"),
                  subtitle: const Text(
                    "Only username is saved locally.\nPassword is not stored.",
                  ),
                ),
              ),

            ],
          ),
        ),
    );
  }
}
