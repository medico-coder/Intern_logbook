import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/patient_log.dart';
import 'add_log_screen.dart';
import 'edit_log_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final db = DatabaseHelper();
  List<PatientLog> logs = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    refresh();
  }

  Future refresh() async {
    setState(() => loading = true);
    logs = await db.getLogs();
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Intern Logbook')),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : logs.isEmpty
              ? Center(child: Text("No logs yet. Add one!"))
              : ListView.builder(
                  itemCount: logs.length,
                  itemBuilder: (context, index) {
                    final l = logs[index];
                    return Dismissible(
                      key: Key(l.id.toString()),
                      direction: DismissDirection.endToStart,
                      onDismissed: (_) async {
                        await db.deleteLog(l.id!);
                        refresh();
                      },
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 20),
                        child: Icon(Icons.delete, color: Colors.white),
                      ),
                      child: ListTile(
                        title: Text(l.name),
                        subtitle: Text('${l.department} • ${l.date}'),
                        trailing: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => EditLogScreen(log: l)),
                            );
                            refresh();
                          },
                        ),
                      ),
                    );
                  }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddLogScreen()),
          );
          refresh();
        },
      ),
    );
  }
}
