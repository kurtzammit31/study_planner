class StudySession {
  StudySession({
    required this.id,
    required this.title,
    required this.subject,
    required this.dateTime,
    required this.durationMinutes,
    this.notes,
    this.isCompleted = false,
    this.reminderEnabled = true,
    this.imagePath,
  });

  final String id;
  final String title;
  final String subject;
  final DateTime dateTime;
  final int durationMinutes;
  final String? notes;

  bool isCompleted;
  bool reminderEnabled;
  String? imagePath;
}
