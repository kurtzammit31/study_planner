import 'package:flutter/material.dart';
import 'add_session_screen.dart';
import 'session_details_screen.dart';

class SessionsHomeScreen extends StatelessWidget {
  const SessionsHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy session (Step 3 will replace with Provider + Hive)
    final demoSession = {
      "id": "s1",
      "title": "Database Revision",
      "subject": "Databases",
      "dateTime": DateTime.now().add(const Duration(hours: 2)),
      "duration": 60,
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Study Planner'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const AddSessionScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Card(
            child: ListTile(
              title: Text(demoSession["title"] as String),
              subtitle: Text(
                "${demoSession["subject"]} • ${(demoSession["dateTime"] as DateTime).toLocal()}",
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => SessionDetailsScreen(
                      title: demoSession["title"] as String,
                      subject: demoSession["subject"] as String,
                      dateTime: demoSession["dateTime"] as DateTime,
                      durationMinutes: demoSession["duration"] as int,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
