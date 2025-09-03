import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() => runApp(InternLogbookApp());

class InternLogbookApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Intern Logbook',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: HomeScreen(),
    );
  }
}
