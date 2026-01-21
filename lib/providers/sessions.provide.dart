import 'dart:math';
import 'package:flutter/foundation.dart';
import '../models/study_session.dart';

class SessionsProvider extends ChangeNotifier {
  final List<StudySession> _sessions = [
    StudySession(
      id: "s1",
      title: "Database Revision",
      subject: "Databases",
      dateTime: DateTime.now().add(const Duration(hours: 2)),
      durationMinutes: 60,
      notes: "Cover ERD + queries",
    ),
  ];

  List<StudySession> get sessions {
    final copy = [..._sessions];
    copy.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    return copy;
  }

  StudySession getById(String id) {
    return _sessions.firstWhere((s) => s.id == id);
  }

  void addSession({
    required String title,
    required String subject,
    required DateTime dateTime,
    required int durationMinutes,
    String? notes,
    bool reminderEnabled = true,
  }) {
    final id = "s${Random().nextInt(999999)}";
    _sessions.add(
      StudySession(
        id: id,
        title: title,
        subject: subject,
        dateTime: dateTime,
        durationMinutes: durationMinutes,
        notes: notes,
        reminderEnabled: reminderEnabled,
      ),
    );
    notifyListeners();
  }

  void toggleCompleted(String id) {
    final s = getById(id);
    s.isCompleted = !s.isCompleted;
    notifyListeners();
  }

  void setImagePath(String id, String path) {
    final s = getById(id);
    s.imagePath = path;
    notifyListeners();
  }
}
