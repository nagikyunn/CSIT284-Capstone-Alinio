import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:capstone_alinio/data/dummy_data.dart';
import 'package:capstone_alinio/models/students_model.dart';
import 'package:capstone_alinio/models/attendance_model.dart';

class StudentScannerScreen extends StatefulWidget {
  const StudentScannerScreen({super.key});

  @override
  State<StudentScannerScreen> createState() => _StudentScannerScreenState();
}

class _StudentScannerScreenState extends State<StudentScannerScreen> {
  Student? _selectedStudent;
  final MobileScannerController _controller = MobileScannerController();

  @override
  void initState() {
    super.initState();
    _selectedStudent = dummyStudents.first;
  }

  void _markPresent(String token) {
    if (!AppStateData.isSessionActive) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error: No active session! Ask the teacher to start a session first.')),
      );
      return;
    }

    // Check if student already checked in
    final alreadyCheckedIn = AppStateData.liveAttendanceList.any(
      (record) => record.studentId == _selectedStudent?.studentId,
    );

    if (alreadyCheckedIn) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${_selectedStudent?.name} is already marked Present!')),
      );
      return;
    }

    setState(() {
      AppStateData.liveAttendanceList.add(
        AttendanceRecord(
          attendanceId: DateTime.now().millisecondsSinceEpoch.toString(),
          sessionId: "sess_csit284_g01",
          studentId: _selectedStudent!.studentId,
          studentName: _selectedStudent!.name,
          status: "Present",
          scannedAt: TimeOfDay.now().format(context),
        ),
      );
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${_selectedStudent?.name} marked Present successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Scanner & Check-In')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Select Student Profile (Testing Mode):', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            DropdownButtonFormField<Student>(
              value: _selectedStudent,
              decoration: const InputDecoration(border: OutlineInputBorder(), contentPadding: EdgeInsets.symmetric(horizontal: 12)),
              items: dummyStudents.map((student) {
                return DropdownMenuItem(
                  value: student,
                  child: Text('${student.name} (${student.studentId})'),
                );
              }).toList(),
              onChanged: (val) {
                setState(() {
                  _selectedStudent = val;
                });
              },
            ),
            const SizedBox(height: 20),
            const Text('Camera Scanner:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  children: [
                    MobileScanner(
                      controller: _controller,
                      onDetect: (capture) {
                        final List<Barcode> barcodes = capture.barcodes;
                        for (final barcode in barcodes) {
                          if (barcode.rawValue != null) {
                            _markPresent(barcode.rawValue!);
                            break;
                          }
                        }
                      },
                    ),
                    Center(
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green, width: 3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => _markPresent(AppStateData.activeQrToken),
              icon: const Icon(Icons.bolt),
              label: const Text('Simulate QR Scan (For Emulators)'),
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}