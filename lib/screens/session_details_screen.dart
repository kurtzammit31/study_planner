import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import 'camera_capture_screen.dart';
import '../providers/sessions.provide.dart';

class SessionDetailsScreen extends StatelessWidget {
  const SessionDetailsScreen({super.key, required this.sessionId});

  final String sessionId;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SessionsProvider>();
    final s = provider.getById(sessionId);

    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: const Text("Session Details"),
        titleTextStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      backgroundColor: Colors.indigo[700],
      ),
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
                if (s.imagePath != null) ...[
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        File(s.imagePath!),
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                ],
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: () => provider.toggleCompleted(sessionId),
                  icon: Icon(s.isCompleted ? Icons.undo : Icons.check),
                  label: Text(s.isCompleted ? "Mark as Not Completed" : "Mark Completed"),
                ),
                const SizedBox(height: 8),
                OutlinedButton.icon(
                  onPressed: () async {
                    final path = await Navigator.of(context).push<String>(
                       MaterialPageRoute(builder: (_) => const CameraCaptureScreen()),
                      );
                    
                    if (path == null) return;
                    
                    provider.setImagePath(sessionId, path);
                    if (!context.mounted) return;
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Photo added to session.")),
                    );
                  }, label: const Text("Add Notes Photo"), 
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
