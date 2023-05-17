import 'employee.dart';

class Project {
  final String projectId;
  String projectName;
  String projectDescription;
  Employee employeeName;

  Project({
    required this.projectId,
    required this.projectName,
    required this.projectDescription,
    required this.employeeName,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      projectId: json['project_id'].toString(),
      projectName: json['project_name'],
      projectDescription: json['project_description'],
      employeeName: Employee.fromJson(json['pegawai']),
    );
  }
}
