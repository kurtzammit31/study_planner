import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../services/notification_service.dart';


import '../models/study_session.dart';

class SessionsProvider extends ChangeNotifier {
  final Box<StudySession> _box = Hive.box<StudySession>('sessions');

  SessionsProvider() {
    _loadSessions();
    _ensureNotifIds();
  }

  List<StudySession> _sessions = [];

  List<StudySession> get sessions {
    final copy = [..._sessions];
    copy.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    return copy;
  }

  void _loadSessions() {
    _sessions = _box.values.toList();
    notifyListeners();
  }

  void _ensureNotifIds() {
  bool changed = false;
  for (final s in _sessions) {
    if (s.notifId == null) {
      s.notifId = Random().nextInt(100000000);
      _box.put(s.id, s);
      changed = true;
    }
  }
  if (changed) notifyListeners();
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

    final notifId = Random().nextInt(100000000);

    final session = StudySession(
      id: id,
      title: title,
      subject: subject,
      dateTime: dateTime,
      durationMinutes: durationMinutes,
      notes: notes,
      reminderEnabled: reminderEnabled,
      notifId: notifId,
    );

    _sessions.add(session);
    _box.put(id, session);

    if (reminderEnabled) {
      NotificationService.instance.showSessionCreated(
      subject: subject,
      title: title,
      );
    }
    notifyListeners();
  }


  void toggleCompleted(String id) {
    final s = getById(id);
    s.isCompleted = !s.isCompleted;
    _box.put(s.id, s);
    notifyListeners();
  }

  void setImagePath(String id, String path) {
    final s = getById(id);
    s.imagePath = path;
    _box.put(s.id, s);
    notifyListeners();
  }
}
