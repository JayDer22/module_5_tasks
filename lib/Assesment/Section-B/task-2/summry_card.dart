import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  final String address;
  final String pincode;

  const SummaryCard({
    super.key,
    required this.address,
    required this.pincode,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Submitted Details",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text("Address: $address"),
            Text("Pincode: $pincode"),
          ],
        ),
      ),
    );
  }
}