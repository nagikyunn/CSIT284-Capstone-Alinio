class AttendanceRecord {
  final String attendanceId;
  final String sessionId;
  final String studentId;
  final String studentName;
  final String status;
  final String scannedAt;

  const AttendanceRecord({
    required this.attendanceId,
    required this.sessionId,
    required this.studentId,
    required this.studentName,
    required this.status,
    required this.scannedAt,
  });
}