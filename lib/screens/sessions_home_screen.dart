import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/sessions.provide.dart';
import 'add_session_screen.dart';
import 'session_details_screen.dart';

class SessionsHomeScreen extends StatelessWidget {
  const SessionsHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SessionsProvider>();
    final sessions = provider.sessions;

    return Scaffold(
      appBar: AppBar(title: const Text('Study Planner')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const AddSessionScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: sessions.length,
        itemBuilder: (context, index) {
          final s = sessions[index];

          return Card(
            child: ListTile(
              leading: Icon(s.isCompleted ? Icons.check_circle : Icons.school),
              title: Text(s.title),
              subtitle: Text("${s.subject} • ${s.dateTime.toLocal()}"),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => SessionDetailsScreen(sessionId: s.id),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
