class AttendanceSession {
  final String sessionId;
  final String qrToken;
  final DateTime createdAt;
  final DateTime expiresAt;
  final bool isActive;

  const AttendanceSession({
    required this.sessionId,
    required this.qrToken,
    required this.createdAt,
    required this.expiresAt,
    required this.isActive,
  });
}