import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProviderPage extends StatefulWidget {
  @override
  _ProviderPageState createState() => _ProviderPageState();
}

class _ProviderPageState extends State<ProviderPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController regionController = TextEditingController();
  String errorMessage = "";

  Future<void> addProvider() async {
    final name = nameController.text.trim();
    final phone = phoneController.text.trim();
    final region = regionController.text.trim();

    if (name.isEmpty || phone.isEmpty || region.isEmpty) {
      setState(() {
        errorMessage = 'All fields are required';
      });
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://localhost:3001/providers'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'name': name, 'phone': phone, 'region': region}),
      );

      if (response.statusCode == 201) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Provider added successfully!'),
            backgroundColor: Colors.green,
          ),
        );

        // Wait for 1 second before navigating back
        Future.delayed(Duration(seconds: 1), () {
          Navigator.pop(context);
        });
      } else if (response.statusCode == 400) {
        setState(() {
          errorMessage = 'Provider already exists with this phone number.';
        });
      } else {
        setState(() {
          errorMessage = 'Failed to add provider';
        });
      }
    } catch (e) {
      print("Error: $e");
      setState(() {
        errorMessage = 'Error connecting to server';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Provider')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            TextField(
              controller: regionController,
              decoration: InputDecoration(labelText: 'Region'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: addProvider,
              child: Text('Add Provider'),
            ),
            if (errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
