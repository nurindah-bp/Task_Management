class TaskResume {
  final String employeeId;
  String nonprogress;
  String inprogress;
  String done;
  String pending;

  TaskResume(
      {required this.employeeId,
      required this.nonprogress,
      required this.inprogress,
      required this.done,
      required this.pending,
      });

  factory TaskResume.fromJson(Map<String, dynamic> json) {
    return TaskResume(
      employeeId: json['employee_id'].toString(),
      nonprogress: json['non_progres'].toString(),
      inprogress: json['in_progres'].toString(),
      done: json['done'].toString(),
      pending: json['pending'].toString(),
    );
  }
}
