import 'package:flutter/material.dart';
import 'customer.dart'; // Fixed import
import 'provider.dart'; // Fixed import

class SelectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Role')),
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/customer');
              },
              child: Text('I am a Customer'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/provider');
              },
              child: Text('I am a Provider'),
            ),
          ],
        ),
      ),
    );
  }
}
