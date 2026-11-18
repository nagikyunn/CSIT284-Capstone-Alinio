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

  void _markAttendance(String status) {
    if (!AppStateData.isSessionActive) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error: No active session! Ask the teacher to start a session first.')),
      );
      return;
    }

    if (_selectedStudent == null) return;

    // Check if student is already in the list
    final existingIndex = AppStateData.liveAttendanceList.indexWhere(
      (record) => record.studentId == _selectedStudent!.studentId,
    );

    setState(() {
      if (existingIndex != -1) {
        // Update existing record status if already logged
        AppStateData.liveAttendanceList[existingIndex] = AttendanceRecord(
          attendanceId: AppStateData.liveAttendanceList[existingIndex].attendanceId,
          sessionId: "sess_csit284_g01",
          studentId: _selectedStudent!.studentId,
          studentName: _selectedStudent!.name,
          status: status,
          scannedAt: TimeOfDay.now().format(context),
        );
      } else {
        // Add new record to the top of the feed
        AppStateData.liveAttendanceList.insert(
          0,
          AttendanceRecord(
            attendanceId: DateTime.now().millisecondsSinceEpoch.toString(),
            sessionId: "sess_csit284_g01",
            studentId: _selectedStudent!.studentId,
            studentName: _selectedStudent!.name,
            status: status,
            scannedAt: TimeOfDay.now().format(context),
          ),
        );
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${_selectedStudent?.name} marked as $status!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final presentCount = AppStateData.liveAttendanceList.where((r) => r.status == "Present").length;

    return Scaffold(
      appBar: AppBar(title: const Text('Student Scanner & Attendance Log')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Student Selector Dropdown
            const Text('Select Student Profile (Testing Mode):', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            DropdownButtonFormField<Student>(
              value: _selectedStudent,
              decoration: const InputDecoration(border: OutlineInputBorder(), contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
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
            const SizedBox(height: 12),
            
            // Camera Scanner Box
            SizedBox(
              height: 180,
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
                            _markAttendance("Present");
                            break;
                          }
                        }
                      },
                    ),
                    Center(
                      child: Container(
                        width: 130,
                        height: 130,
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
            const SizedBox(height: 10),

            // Side-by-Side Action Buttons (Simulate Present & Mark Absent)
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _markAttendance("Present"),
                    icon: const Icon(Icons.check_circle, size: 18),
                    label: const Text('Simulate Present'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _markAttendance("Absent"),
                    icon: const Icon(Icons.cancel, size: 18),
                    label: const Text('Mark Absent'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade700,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Real-Time Feed Header & Count
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Real-Time Attendance Feed', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Chip(
                  label: Text('$presentCount / ${dummyStudents.length} Present'),
                  backgroundColor: Colors.blue.shade50,
                  labelStyle: TextStyle(color: Colors.blue.shade800, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(),

            // Real-Time Feed List
            Expanded(
              child: AppStateData.liveAttendanceList.isEmpty
                  ? const Center(
                      child: Text('No attendance logs yet. Use the buttons above to test!'),
                    )
                  : ListView.builder(
                      itemCount: AppStateData.liveAttendanceList.length,
                      itemBuilder: (context, index) {
                        final record = AppStateData.liveAttendanceList[index];
                        final isPresent = record.status == "Present";
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: isPresent ? Colors.green.shade100 : Colors.red.shade100,
                              child: Icon(
                                isPresent ? Icons.check : Icons.close,
                                color: isPresent ? Colors.green : Colors.red,
                                size: 18,
                              ),
                            ),
                            title: Text(record.studentName, style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text('ID: ${record.studentId} • ${record.scannedAt}'),
                            trailing: Text(
                              record.status,
                              style: TextStyle(
                                color: isPresent ? Colors.green : Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
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