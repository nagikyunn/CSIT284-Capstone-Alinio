import 'package:capstone_alinio/models/students_model.dart';
import 'package:capstone_alinio/models/attendance_model.dart';

const currentClassInfo = {
  "class_id": "CSIT284-G01",
  "class_name": "Platform-Based Development (Mobile)",
  "section": "Section G01",
  "teacher_name": "Prof. Alinio",
};

const dummyStudents = [
  Student(studentId: '24-1001-231', name: 'Jan Lloyd Alinio', email: 'janlloyd@cit.edu'),
  Student(studentId: '24-1003-911', name: 'Juan Dela Cruz', email: 'juan@cit.edu'),
  Student(studentId: '24-1004-554', name: 'Maria Santos', email: 'maria@cit.edu'),
  Student(studentId: '24-1005-773', name: 'Alex Rivera', email: 'alex@cit.edu'),
  Student(studentId: '24-1006-112', name: 'Bea Alonzo', email: 'bea@cit.edu'),
  Student(studentId: '24-1007-445', name: 'Carlos Yulo', email: 'carlos@cit.edu'),
  Student(studentId: '24-1008-889', name: 'Sofia Pablo', email: 'sofia@cit.edu'),
  Student(studentId: '24-1009-334', name: 'Miguel Tan', email: 'miguel@cit.edu'),
  Student(studentId: '24-1010-556', name: 'Chloe Ramos', email: 'chloe@cit.edu'),
  Student(studentId: '24-1011-789', name: 'Lucas Reyes', email: 'lucas@cit.edu'),
];

class AppStateData {
  // Global session state shared between Teacher and Student screens
  static bool isSessionActive = false;
  static String activeQrToken = "CSIT284_G01_TOKEN_LIVE";
  static List<AttendanceRecord> liveAttendanceList = [];
}