import 'employee.dart';

class ProjectTask {
  final String projectId;
  final String ptaskId;
  String ptaskName;
  String ptaskDescription;
  Employee employeeName;

  ProjectTask({
    required this.projectId,
    required this.ptaskId,
    required this.ptaskName,
    required this.ptaskDescription,
    required this.employeeName,
  });

  factory ProjectTask.fromJson(Map<String, dynamic> json) {
    return ProjectTask(
      projectId: json['project_id'].toString(),
      ptaskId: json['ptask_id'].toString(),
      ptaskName: json['ptask_name'],
      ptaskDescription: json['ptask_description'],
      employeeName: Employee.fromJson(json['pegawai']),
    );
  }
}
