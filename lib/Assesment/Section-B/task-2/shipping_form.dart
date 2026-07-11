import 'package:flutter/material.dart';
import 'package:module_4/Assesment/Section-B/task-2/summry_card.dart';

class ShippingForm extends StatefulWidget {
  const ShippingForm({super.key});

  @override
  State<ShippingForm> createState() => _ShippingFormState();
}

class _ShippingFormState extends State<ShippingForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController addressController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();

  String address = "";
  String pincode = "";

  @override
  void dispose() {
    addressController.dispose();
    pincodeController.dispose();
    super.dispose();
  }

  void submitData() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        address = addressController.text;
        pincode = pincodeController.text;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shipping Address Form"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: addressController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: "Shipping Address",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Address cannot be empty";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: pincodeController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Pincode",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter pincode";
                      }

                      if (!RegExp(r'^\d{6}$').hasMatch(value)) {
                        return "Pincode must contain exactly 6 digits";
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: submitData,
                    child: const Text("Submit"),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            if (address.isNotEmpty)
              SummaryCard(
                address: address,
                pincode: pincode,
              ),
          ],
        ),
      ),
    );
  }
}