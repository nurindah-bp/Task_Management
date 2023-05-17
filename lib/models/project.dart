import 'employee.dart';

class Project {
  final int projectId, projectDiv;
  String projectName;
  String projectDescription;
  Employee employeeName;
  int projectStatus;

  Project({
    required this.projectId,
    required this.projectName,
    required this.projectDescription,
    required this.employeeName,
    required this.projectStatus,
    required this.projectDiv,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      projectId: json['project_id'],
      projectDiv: json['project_div'],
      projectName: json['project_name'],
      projectDescription: json['project_description'],
      employeeName: Employee.fromJson(json['pegawai']),
      projectStatus: json['project_status'],
    );
  }
}
