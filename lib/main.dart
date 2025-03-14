import 'package:flutter/material.dart';
import 'screens/welcome.dart';
import 'screens/select.dart';
import 'screens/customer.dart';
import 'screens/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HalApp',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/', // Start with the welcome screen
      routes: {
        '/': (context) => WelcomePage(),  // Fixed class name
        '/select': (context) => SelectPage(), // Fixed class name
        '/customer': (context) => CustomerPage(), // Fixed class name
        '/provider': (context) => ProviderPage(), // Fixed class name
      },
    );
  }
}
