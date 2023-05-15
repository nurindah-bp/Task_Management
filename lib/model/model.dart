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
  final String projectId;
  final String projectName;
  final String projectDescription;
  final Employee employeeName;

  const Project({
    required this.projectId,
    required this.projectName,
    required this.projectDescription,
    required this.employeeName,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      projectId: json['project_id'].toString(),
      projectName: json['project_name'],
      projectDescription: json['project_description'],
      employeeName: Employee.fromJson(json['pegawai']),
    );
  }
}

class ProjectTask {
  final String projectId;
  final String ptaskId;
  final String ptaskName;
  final String ptaskDescription;
  final Employee employeeName;

  const ProjectTask({
    required this.projectId,
    required this.ptaskId,
    required this.ptaskName,
    required this.ptaskDescription,
    required this.employeeName,
  });

  factory ProjectTask.fromJson(Map<String, dynamic> json) {
    return ProjectTask(
      projectId: json['project_id'].toString(),
      ptaskId: json['ptask_id'].toString(),
      ptaskName: json['ptask_name'],
      ptaskDescription: json['ptask_description'],
      employeeName: Employee.fromJson(json['pegawai']),
    );
  }
}

class ProjectTaskProgress {
  final String ptaskId;
  final String ptask_progress;
  final String ptask_progressdate;
  final String ptask_progressstatus;

  const ProjectTaskProgress({
    required this.ptaskId,
    required this.ptask_progress,
    required this.ptask_progressdate,
    required this.ptask_progressstatus,
  });

  factory ProjectTaskProgress.fromJson(Map<String, dynamic> json) {
    return ProjectTaskProgress(
      ptaskId: json['ptask_id'].toString(),
      ptask_progress: json['ptask_progress'],
      ptask_progressdate: json['ptask_progressdate'],
      ptask_progressstatus: json['ptask_progressstatus'].toString(),
    );
  }
}

class Task {
  final String taskId;
  final String taskName;
  final String taskDescription;
  final Employee employeeName;

  const Task({
    required this.taskId,
    required this.taskName,
    required this.taskDescription,
    required this.employeeName,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      taskId: json['task_id'].toString(),
      taskName: json['task_name'],
      taskDescription: json['task_description'],
      employeeName: Employee.fromJson(json['pegawai']),
    );
  }
}

class TaskProgress {
  final String taskId;
  final String taskProgress;
  final String taskProgressdate;
  final String taskProgressstatus;

  const TaskProgress({
    required this.taskId,
    required this.taskProgress,
    required this.taskProgressdate,
    required this.taskProgressstatus,
  });

  factory TaskProgress.fromJson(Map<String, dynamic> json) {
    return TaskProgress(
        taskId: json['task_id'].toString(),
        taskProgress: json['task_progress'],
        taskProgressdate: json['task_progressdate'],
        taskProgressstatus: json['task_progressstatus'].toString());
  }
}
