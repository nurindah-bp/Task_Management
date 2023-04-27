class Project {
  // final int id_proyek;
  final String nama_proyek;
  final String deskripsi_proyek;
  final String nama_pegawai;

  const Project({
    // required this.id_proyek,
    required this.nama_proyek,
    required this.deskripsi_proyek,
    required this.nama_pegawai,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      // id_proyek: json['id_proyek'],
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

class ProjectTask {
  final String nama_tugas;
  final String deskripsi_tugas;
  final String nama_pegawai;

  const ProjectTask({
    required this.nama_tugas,
    required this.deskripsi_tugas,
    required this.nama_pegawai,
  });

  factory ProjectTask.fromJson(Map<String, dynamic> json) {
    return ProjectTask(
      nama_tugas: json['nama_tugas'],
      deskripsi_tugas: json['deskripsi_tugas'],
      nama_pegawai: json['nama_pegawai'],
    );
  }
}

class TaskProgress {
  final String progres_tugas;
  final String tgl_progres;

  const TaskProgress({
    required this.progres_tugas,
    required this.tgl_progres,
  });

  factory TaskProgress.fromJson(Map<String, dynamic> json) {
    return TaskProgress(
      progres_tugas: json['progres_tugas'],
      tgl_progres: json['tgl_pengerjaan'],
    );
  }
}
