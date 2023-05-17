class DashProcastination {
  final String employeeId;
  String employeeName;
  double prokastinasi;

  DashProcastination(
      {required this.employeeId,
      required this.employeeName,
      required this.prokastinasi});

  factory DashProcastination.fromJson(Map<String, dynamic> json) {
    return DashProcastination(
      employeeId: json['employee_number'].toString(),
      employeeName: json['employee_name'],
      prokastinasi: double.parse(json['prokastinasi']),
    );
  }
}
