import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:capstone_alinio/data/dummy_data.dart';
import 'package:capstone_alinio/models/attendance_model.dart';
import 'package:capstone_alinio/widgets/attendance_tile.dart';

class TeacherDashboardScreen extends StatefulWidget {
  const TeacherDashboardScreen({super.key});

  @override
  State<TeacherDashboardScreen> createState() => _TeacherDashboardScreenState();
}

class _TeacherDashboardScreenState extends State<TeacherDashboardScreen> {
  bool _isSessionActive = false;
  final List<AttendanceRecord> _liveAttendance = [];

  void _toggleSession() {
    setState(() {
      _isSessionActive = !_isSessionActive;
      if (_isSessionActive) {
        _liveAttendance.addAll(initialAttendanceLogs);
      } else {
        _liveAttendance.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Teacher Dashboard - ${currentClassInfo['section']}')),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.blue.shade50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _isSessionActive ? 'Status: Session Active' : 'Status: No Active Session',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _isSessionActive ? Colors.green.shade700 : Colors.red.shade700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text('${currentClassInfo['class_id']} - ${currentClassInfo['class_name']}'),
                  ],
                ),
                ElevatedButton(
                  onPressed: _toggleSession,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isSessionActive ? Colors.red : Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(_isSessionActive ? 'End Session' : 'Start Session'),
                ),
              ],
            ),
          ),
          if (_isSessionActive)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text(
                        'Scan QR Code to Check In',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      QrImageView(
                        data: activeSessionMock.qrToken,
                        version: QrVersions.auto,
                        size: 180.0,
                        backgroundColor: Colors.white,
                      ),
                      const SizedBox(height: 8),
                      Text('Token: ${activeSessionMock.qrToken}', style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ),
            ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Live Attendance List', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
          Expanded(
            child: _liveAttendance.isEmpty
                ? const Center(child: Text('No students checked in yet.'))
                : ListView.builder(
                    itemCount: _liveAttendance.length,
                    itemBuilder: (context, index) {
                      return AttendanceTile(record: _liveAttendance[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}