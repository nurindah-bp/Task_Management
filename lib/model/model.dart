class Project {
  final String nama_proyek;
  final String deskripsi_proyek;

  const Project({
    required this.nama_proyek,
    required this.deskripsi_proyek,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      nama_proyek: json['nama_proyek'],
      deskripsi_proyek: json['deskripsi_proyek'],
    );
  }
}
