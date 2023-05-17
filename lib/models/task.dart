import 'employee.dart';

class Task {
  final String taskId;
  String taskName;
  String taskDescription;
  Employee employeeName;

  Task({
    required this.taskId,
    required this.taskName,
    required this.taskDescription,
    required this.employeeName,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      taskId: json['task_id'].toString(),
      taskName: json['task_name'],
      taskDescription: json['task_description'],
      employeeName: Employee.fromJson(json['pegawai']),
    );
  }
}