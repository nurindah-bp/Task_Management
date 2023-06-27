import 'employee.dart';

class Task {
  final String taskId;
  String taskName;
  String taskDescription;
  String taskDate;
  String taskDeadline;
  Employee employeeName;

  Task({
    required this.taskId,
    required this.taskName,
    required this.taskDescription,
    required this.taskDate,
    required this.taskDeadline,
    required this.employeeName,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      taskId: json['task_id'].toString(),
      taskName: json['task_name'],
      taskDescription: json['task_description'],
      taskDate: json['task_date'],
      taskDeadline: json['task_deadline'],
      employeeName: Employee.fromJson(json['pegawai']),
    );
  }
}