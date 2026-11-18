import 'package:flutter/material.dart';
import 'package:capstone_alinio/models/student_model.dart';
import 'package:capstone_alinio/models/session_model.dart';
import 'package:capstone_alinio/models/attendance_model.dart';

const currentClassInfo = {
  "class_id": "CSIT284-G01",
  "class_name": "Platform-Based Development (Mobile)",
  "section": "Section G01",
  "teacher_name": "Prof. Alinio",
};

const dummyStudents = [
  Student(
    studentId: '24-1001-231',
    name: 'Jan Lloyd Alinio',
    email: 'janlloyd@cit.edu',
  ),
  Student(
    studentId: '24-1003-911',
    name: 'Juan Dela Cruz',
    email: 'juan@cit.edu',
  ),
  Student(
    studentId: '24-1004-554',
    name: 'Maria Santos',
    email: 'maria@cit.edu',
  ),
  Student(
    studentId: '24-1005-773',
    name: 'Alex Rivera',
    email: 'alex@cit.edu',
  ),
  Student(
    studentId: '24-1006-112',
    name: 'Bea Alonzo',
    email: 'bea@cit.edu',
  ),
  Student(
    studentId: '24-1007-445',
    name: 'Carlos Yulo',
    email: 'carlos@cit.edu',
  ),
  Student(
    studentId: '24-1008-889',
    name: 'Sofia Pablo',
    email: 'sofia@cit.edu',
  ),
  Student(
    studentId: '24-1009-334',
    name: 'Miguel Tan',
    email: 'miguel@cit.edu',
  ),
  Student(
    studentId: '24-1010-556',
    name: 'Chloe Ramos',
    email: 'chloe@cit.edu',
  ),
  Student(
    studentId: '24-1011-789',
    name: 'Lucas Reyes',
    email: 'lucas@cit.edu',
  ),
];

// Active Session Mock
final activeSessionMock = AttendanceSession(
  sessionId: "sess_csit284_g01",
  qrToken: "CSIT284_G01_TOKEN_LIVE",
  createdAt: DateTime.now(),
  expiresAt: DateTime.now().add(const Duration(minutes: 5)),
  isActive: true,
);

// Initial Attendance Logs
final initialAttendanceLogs = [
  AttendanceRecord(
    attendanceId: "1",
    sessionId: "sess_csit284_g01",
    studentId: "24-1001-231",
    studentName: "Jan Lloyd Alinio",
    status: "Present",
    scannedAt: "15:40:12",
  ),
];