import 'package:flutter/material.dart';

class SessionDetailsScreen extends StatelessWidget {
  const SessionDetailsScreen({
    super.key,
    required this.title,
    required this.subject,
    required this.dateTime,
    required this.durationMinutes,
  });

  final String title;
  final String subject;
  final DateTime dateTime;
  final int durationMinutes;

  @override
  Widget build(BuildContext context) {
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
                Text(title, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                Text("Subject: $subject"),
                Text("Time: ${dateTime.toLocal()}"),
                Text("Duration: $durationMinutes minutes"),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: () {
                    // Step 3: mark complete in Provider + Hive
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Marked completed (dummy)")),
                    );
                  },
                  icon: const Icon(Icons.check),
                  label: const Text("Mark Completed"),
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
