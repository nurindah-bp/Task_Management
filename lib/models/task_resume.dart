class TaskResume {
  final String employeeId;
  String progress;
  String done;
  String pending;

  TaskResume(
      {required this.employeeId,
      required this.progress,
      required this.done,
      required this.pending,
      });

  factory TaskResume.fromJson(Map<String, dynamic> json) {
    return TaskResume(
      employeeId: json['employee_id'].toString(),
      progress: json['progres'].toString(),
      done: json['done'].toString(),
      pending: json['pending'].toString(),
    );
  }
}
