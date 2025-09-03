import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/patient_log.dart';
import 'package:intl/intl.dart';

class AddLogScreen extends StatefulWidget {
  @override
  _AddLogScreenState createState() => _AddLogScreenState();
}

class _AddLogScreenState extends State<AddLogScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _age = TextEditingController();
  final _dept = TextEditingController();
  final _notes = TextEditingController();
  final db = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Log')),
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
                final now = DateFormat.yMMMd().format(DateTime.now());
                final log = PatientLog(
                  name: _name.text,
                  age: int.parse(_age.text),
                  department: _dept.text,
                  notes: _notes.text,
                  date: now,
                );
                await db.insertLog(log);
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ]),
        ),
      ),
    );
  }
}
