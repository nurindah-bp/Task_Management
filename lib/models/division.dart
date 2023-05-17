class Division {
  int divisionId;
  String divisionName;

  Division({required this.divisionId, required this.divisionName});

  factory Division.fromJson(Map<String, dynamic> json) {
    return Division(
      divisionId: json['division_id'],
      divisionName: json['division_name'],
    );
  }
}
