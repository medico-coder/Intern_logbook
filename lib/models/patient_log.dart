class PatientLog {
  int? id;
  String name;
  int age;
  String department;
  String notes;
  String date;

  PatientLog({
    this.id,
    required this.name,
    required this.age,
    required this.department,
    required this.notes,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'department': department,
      'notes': notes,
      'date': date,
    };
  }

  static PatientLog fromMap(Map<String, dynamic> m) {
    return PatientLog(
      id: m['id'],
      name: m['name'],
      age: m['age'],
      department: m['department'],
      notes: m['notes'],
      date: m['date'],
    );
  }
}
