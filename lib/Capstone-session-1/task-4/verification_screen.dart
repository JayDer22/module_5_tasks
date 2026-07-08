import 'package:flutter/material.dart';
import '../task-3/saved_movies_screen.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Task 4: Verify Persistence")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.save_as, size: 80, color: Colors.blue),
            const SizedBox(height: 20),
            const Text(
              "Task 4 Verification Steps:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "1. Go to Movie List and save some movies.\n"
              "2. Close the app completely.\n"
              "3. Restart the app.\n"
              "4. Click the button below to see if your movies are still there.",
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SavedMoviesScreen()),
                );
              },
              child: const Text("Check Saved Movies"),
            ),
          ],
        ),
      ),
    );
  }
}
