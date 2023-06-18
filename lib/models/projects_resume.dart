class ProjectsResume {
  String divId;
  String divName;
  String done;
  String total;

  ProjectsResume(
      {required this.divId,
      required this.divName,
      required this.done,
      required this.total,
      });

  factory ProjectsResume.fromJson(Map<String, dynamic> json) {
    return ProjectsResume(
      divId: json['division_id'].toString(),
      divName: json['division_name'],
      done: json['done'].toString(),
      total: json['total'].toString(),
    );
  }
}
