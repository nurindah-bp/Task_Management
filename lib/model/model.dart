class Employee {
  final String employeeNumber;
  final String employeeName;

  Employee({required this.employeeNumber, required this.employeeName});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      employeeNumber: json['employee_number'],
      employeeName: json['employee_name'],
    );
  }
}

class Project {
  // final int id_proyek;
  final String projectName;
  final String projectDescription;
  final Employee employeeName;

  const Project({
    // required this.id_proyek,
    required this.projectName,
    required this.projectDescription,
    required this.employeeName,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      // id_proyek: json['id_proyek'],
      projectName: json['project_name'],
      projectDescription: json['project_description'],
      employeeName: Employee.fromJson(json['pegawai']),
    );
  }
}

class ProjectTask {
  final int projectId;
  final String ptaskName;
  final String ptaskDescription;
  final Employee employeeName;

  const ProjectTask({
    required this.projectId,
    required this.ptaskName,
    required this.ptaskDescription,
    required this.employeeName,
  });

  factory ProjectTask.fromJson(Map<String, dynamic> json) {
    return ProjectTask(
      projectId: json['project_id'],
      ptaskName: json['ptask_name'],
      ptaskDescription: json['ptask_description'],
      employeeName: Employee.fromJson(json['pegawai']),
    );
  }
}

class ProjectTaskProgress {
  final String ptask_progress;
  final String ptask_progressdate;

  const ProjectTaskProgress({
    required this.ptask_progress,
    required this.ptask_progressdate,
  });

  factory ProjectTaskProgress.fromJson(Map<String, dynamic> json) {
    return ProjectTaskProgress(
      ptask_progress: json['ptask_progress'],
      ptask_progressdate: json['ptask_progressdate'],
    );
  }
}

class Task {
  final String taskName;
  final String taskDescription;
  final Employee employeeName;

  const Task({
    required this.taskName,
    required this.taskDescription,
    required this.employeeName,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      taskName: json['task_name'],
      taskDescription: json['task_description'],
      employeeName: Employee.fromJson(json['pegawai']),
    );
  }
}

class TaskProgress {
  final String taskProgress;
  final String taskProgressdate;

  const TaskProgress({
    required this.taskProgress,
    required this.taskProgressdate,
  });

  factory TaskProgress.fromJson(Map<String, dynamic> json) {
    return TaskProgress(
      taskProgress: json['task_progress'],
      taskProgressdate: json['task_progressdate'],
    );
  }
}
