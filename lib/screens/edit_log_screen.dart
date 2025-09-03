import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/patient_log.dart';

class EditLogScreen extends StatefulWidget {
  final PatientLog log;
  EditLogScreen({required this.log});

  @override
  _EditLogScreenState createState() => _EditLogScreenState();
}

class _EditLogScreenState extends State<EditLogScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _name;
  late TextEditingController _age;
  late TextEditingController _dept;
  late TextEditingController _notes;
  final db = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.log.name);
    _age = TextEditingController(text: widget.log.age.toString());
    _dept = TextEditingController(text: widget.log.department);
    _notes = TextEditingController(text: widget.log.notes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Log')),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: ListView(children: [
            TextFormField(
              controller: _name,
              decoration: InputDecoration(labelText: 'Patient Name'),
              validator: (v) => v!.isEmpty ? 'Enter name' : null,
            ),
            TextFormField(
              controller: _age,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Age'),
              validator: (v) => v!.isEmpty ? 'Enter age' : null,
            ),
            TextFormField(
              controller: _dept,
              decoration: InputDecoration(labelText: 'Department/Rotation'),
            ),
            TextFormField(
              controller: _notes,
              decoration: InputDecoration(labelText: 'Notes'),
              maxLines: 4,
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () async {
                if (!_formKey.currentState!.validate()) return;
                final updated = PatientLog(
                  id: widget.log.id,
                  name: _name.text,
                  age: int.parse(_age.text),
                  department: _dept.text,
                  notes: _notes.text,
                  date: widget.log.date,
                );
                await db.updateLog(updated);
                Navigator.pop(context);
              },
              child: Text('Update'),
            ),
          ]),
        ),
      ),
    );
  }
}
