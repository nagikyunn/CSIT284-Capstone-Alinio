import 'package:flutter/material.dart';
import 'package:capstone_alinio/models/attendance_model.dart';

class AttendanceTile extends StatelessWidget {
  final AttendanceRecord record;

  const AttendanceTile({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.green.shade100,
          child: const Icon(Icons.check, color: Colors.green),
        ),
        title: Text(record.studentName, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('ID: ${record.studentId} • Scanned at ${record.scannedAt}'),
        trailing: Chip(
          label: Text(record.status),
          backgroundColor: Colors.green.shade50,
          labelStyle: const TextStyle(color: Colors.green, fontSize: 12),
        ),
      ),
    );
  }
}