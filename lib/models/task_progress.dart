class TaskProgress {
  final String taskId;
  String taskProgress;
  String taskProgressdate;
  String taskProgressstatus;

  TaskProgress({
    required this.taskId,
    required this.taskProgress,
    required this.taskProgressdate,
    required this.taskProgressstatus,
  });

  factory TaskProgress.fromJson(Map<String, dynamic> json) {
    return TaskProgress(
        taskId: json['task_id'].toString(),
        taskProgress: json['task_progress'],
        taskProgressdate: json['task_progressdate'],
        taskProgressstatus: json['task_progressstatus'].toString());
  }
}