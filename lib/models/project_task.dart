import 'employee.dart';

class ProjectTask {
  final String projectId;
  final String ptaskId;
  String ptaskName;
  String ptaskDescription;
  String ptaskDate;
  String ptaskDeadline;
  Employee employeeName;

  ProjectTask({
    required this.projectId,
    required this.ptaskId,
    required this.ptaskName,
    required this.ptaskDescription,
    required this.ptaskDate,
    required this.ptaskDeadline,
    required this.employeeName,
  });

  factory ProjectTask.fromJson(Map<String, dynamic> json) {
    return ProjectTask(
      projectId: json['project_id'].toString(),
      ptaskId: json['ptask_id'].toString(),
      ptaskName: json['ptask_name'],
      ptaskDescription: json['ptask_description'],
      ptaskDate: json['ptask_date'],
      ptaskDeadline: json['ptask_deadline'],
      employeeName: Employee.fromJson(json['pegawai']),
    );
  }
}
