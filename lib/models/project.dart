import 'employee.dart';

class Project {
  final int projectId, projectDiv;
  String projectName;
  String projectDescription;
  String projectDate;
  String projectDeadline;
  Employee employeeName;
  int projectStatus;

  Project({
    required this.projectId,
    required this.projectName,
    required this.projectDescription,
    required this.employeeName,
    required this.projectStatus,
    required this.projectDate,
    required this.projectDeadline,
    required this.projectDiv,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      projectId: json['project_id'],
      projectDiv: json['project_div'],
      projectName: json['project_name'],
      projectDescription: json['project_description'],
      employeeName: Employee.fromJson(json['pegawai']),
      projectDate: json['project_date'],
      projectDeadline: json['project_deadline'],
      projectStatus: json['project_status'],
    );
  }
}
