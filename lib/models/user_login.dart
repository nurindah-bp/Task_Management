class UserLogin {
  int userId, positionId, divisionId;
  String username, employeeName;

  UserLogin({
    required this.userId,
    required this.positionId,
    required this.divisionId,
    required this.username,
    required this.employeeName,
  });

  factory UserLogin.fromJson(Map<String, dynamic> json) {
    return UserLogin(
      userId: json['user_id'],
      positionId: json['pegawai']['position_id'],
      divisionId: json['pegawai']['division_id'],
      username: json['username'],
      employeeName: json['pegawai']['employee_name'],
    );
  }
}
