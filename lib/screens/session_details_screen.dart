import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/sessions.provide.dart';

class SessionDetailsScreen extends StatelessWidget {
  const SessionDetailsScreen({super.key, required this.sessionId});

  final String sessionId;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SessionsProvider>();
    final s = provider.getById(sessionId);

    return Scaffold(
      appBar: AppBar(title: const Text("Session Details")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(s.title, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                Text("Subject: ${s.subject}"),
                Text("Time: ${s.dateTime.toLocal()}"),
                Text("Duration: ${s.durationMinutes} minutes"),
                if (s.notes != null) ...[
                  const SizedBox(height: 8),
                  Text("Notes: ${s.notes}"),
                ],
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: () => provider.toggleCompleted(sessionId),
                  icon: Icon(s.isCompleted ? Icons.undo : Icons.check),
                  label: Text(s.isCompleted ? "Mark as Not Completed" : "Mark Completed"),
                ),
                const SizedBox(height: 8),
                OutlinedButton.icon(
                  onPressed: () {
                    // Step 5: camera capture + attach photo
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Camera feature coming soon")),
                    );
                  },
                  icon: const Icon(Icons.camera_alt),
                  label: const Text("Attach Notes Photo"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
