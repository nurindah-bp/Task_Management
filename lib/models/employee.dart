class Employee {
  final String employeeNumber;
  String employeeName;

  Employee({required this.employeeNumber, required this.employeeName});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      employeeNumber: json['employee_number'],
      employeeName: json['employee_name'],
    );
  }
}