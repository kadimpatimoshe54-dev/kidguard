import 'package:flutter/material.dart';

void main() {
  runApp(const KidGuardApp());
}

class KidGuardApp extends StatelessWidget {
  const KidGuardApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KidGuard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const KidGuardHome(),
    );
  }
}

class KidGuardHome extends StatelessWidget {
  const KidGuardHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KidGuard Parental Control'),
      ),
      body: const Center(
        child: Text(
          'Welcome to KidGuard (MVVM Setup)',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
