class ProjectResume {
  String projectDiv;
  String divName;
  String nonprogress;
  String inprogress;
  String done;
  String pending;

  ProjectResume(
      {required this.projectDiv,
      required this.divName,
      required this.nonprogress,
      required this.inprogress,
      required this.done,
      required this.pending,
      });

  factory ProjectResume.fromJson(Map<String, dynamic> json) {
    return ProjectResume(
      projectDiv: json['project_div'].toString(),
      divName: json['division_name'],
      nonprogress: json['nonprogress'].toString(),
      inprogress: json['inprogress'].toString(),
      done: json['done'].toString(),
      pending: json['pending'].toString(),
    );
  }
}
