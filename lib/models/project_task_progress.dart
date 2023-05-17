class ProjectTaskProgress {
  final String ptaskId;
  String ptask_progress;
  String ptask_progressdate;
  String ptask_progressstatus;

  ProjectTaskProgress({
    required this.ptaskId,
    required this.ptask_progress,
    required this.ptask_progressdate,
    required this.ptask_progressstatus,
  });

  factory ProjectTaskProgress.fromJson(Map<String, dynamic> json) {
    return ProjectTaskProgress(
      ptaskId: json['ptask_id'].toString(),
      ptask_progress: json['ptask_progress'],
      ptask_progressdate: json['ptask_progressdate'],
      ptask_progressstatus: json['ptask_progressstatus'].toString(),
    );
  }
}
