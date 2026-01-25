import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/sessions.provide.dart';


class AddSessionScreen extends StatefulWidget {
  const AddSessionScreen({super.key});

  @override
  State<AddSessionScreen> createState() => _AddSessionScreenState();
}

class _AddSessionScreenState extends State<AddSessionScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleCtrl = TextEditingController();
  final _subjectCtrl = TextEditingController();
  final _durationCtrl = TextEditingController(text: "60");
  final _notesCtrl = TextEditingController();

  DateTime _selectedDateTime = DateTime.now().add(const Duration(hours: 1));
  final bool _reminderEnabled = true;

  @override
  void dispose() {
    _titleCtrl.dispose();
    _subjectCtrl.dispose();
    _durationCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialDate: _selectedDateTime,
   );

  
    if (!mounted || date == null) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
   );

  
    if (!mounted || time == null) return;

    setState(() {
      _selectedDateTime =
          DateTime(date.year, date.month, date.day, time.hour, time.minute);
    });
  }


  void _save() {
  if (!_formKey.currentState!.validate()) return;

  final duration = int.parse(_durationCtrl.text.trim());

  context.read<SessionsProvider>().addSession(
        title: _titleCtrl.text.trim(),
        subject: _subjectCtrl.text.trim(),
        dateTime: _selectedDateTime,
        durationMinutes: duration,
        notes: _notesCtrl.text.trim().isEmpty ? null : _notesCtrl.text.trim(),
        reminderEnabled: _reminderEnabled,
      );

  Navigator.of(context).pop();
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: const Text("Add Study Session"),
        titleTextStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      backgroundColor: Colors.indigo[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleCtrl,
                decoration: const InputDecoration(labelText: "Title"),
                validator: (v) => (v == null || v.trim().isEmpty) ? "Enter a title" : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _subjectCtrl,
                decoration: const InputDecoration(labelText: "Subject"),
                validator: (v) => (v == null || v.trim().isEmpty) ? "Enter a subject" : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _durationCtrl,
                decoration: const InputDecoration(labelText: "Duration (minutes)"),
                keyboardType: TextInputType.number,
                validator: (v) {
                  final n = int.tryParse((v ?? "").trim());
                  if (n == null || n <= 0) return "Enter a valid duration";
                  return null;
                },
              ),
              const SizedBox(height: 12),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text("Session time"),
                subtitle: Text(_selectedDateTime.toLocal().toString()),
                trailing: TextButton(
                  onPressed: _pickDateTime,
                  child: const Text("Pick"),
                ),
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: _save,
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
