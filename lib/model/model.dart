class Project {
  final String nama_proyek;
  final String deskripsi_proyek;
  final String nama_pegawai;

  const Project({
    required this.nama_proyek,
    required this.deskripsi_proyek,
    required this.nama_pegawai,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      nama_proyek: json['nama_proyek'],
      deskripsi_proyek: json['deskripsi_proyek'],
      nama_pegawai: json['nama_pegawai'],
    );
  }
}

class Task {
  final String nama_tugas;
  final String deskripsi_tugas;
  final String nama_pegawai;

  const Task({
    required this.nama_tugas,
    required this.deskripsi_tugas,
    required this.nama_pegawai,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      nama_tugas: json['nama_tugas'],
      deskripsi_tugas: json['deskripsi_tugas'],
      nama_pegawai: json['nama_pegawai'],
    );
  }
}
