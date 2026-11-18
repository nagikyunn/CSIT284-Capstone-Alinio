import 'package:flutter/material.dart';
import 'package:capstone_alinio/screens/role_selector_screen.dart';

void main() {
  runApp(const AttendanceApp());
}

class AttendanceApp extends StatelessWidget {
  const AttendanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Attendance Checker - CSIT284',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const RoleSelectorScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}