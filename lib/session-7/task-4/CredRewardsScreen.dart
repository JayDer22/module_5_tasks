import 'package:flutter/material.dart';
import 'dbhelper.dart';

class CredRewardsScreen extends StatefulWidget {
  const CredRewardsScreen({super.key});

  @override
  State<CredRewardsScreen> createState() => _CredRewardsScreenState();
}

class _CredRewardsScreenState extends State<CredRewardsScreen> {
  var _points = 0;

  @override
  void initState() {
    super.initState();
    _loadPoints();
  }

  Future<void> _loadPoints() async {
    final points = await DbHelper.instance.getPoints();
    setState(() {
      _points = points;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("CRED Rewards")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Total Points: $_points", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                // Task 4: Proper sequencing prevents race conditions
                // We call two updates. If not awaited properly or handled in DB, they could conflict.
                // Our updatePointsSecurely uses transactions to be safe.
                await Future.wait([
                  DbHelper.instance.updatePointsSecurely(50),
                  DbHelper.instance.updatePointsSecurely(50),
                ]);
                _loadPoints();
              },
              child: const Text("Claim 2x 50 Points Rewards"),
            ),
          ],
        ),
      ),
    );
  }
}
