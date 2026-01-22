import 'package:hive/hive.dart';

part 'study_session.g.dart';

@HiveType(typeId: 0)
class StudySession {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String subject;

  @HiveField(3)
  final DateTime dateTime;

  @HiveField(4)
  final int durationMinutes;

  @HiveField(5)
  final String? notes;

  @HiveField(6)
  bool isCompleted;

  @HiveField(7)
  bool reminderEnabled;

  @HiveField(8)
  String? imagePath;

  @HiveField(9)
  int? notifId;

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
    this.notifId,
  });
}
