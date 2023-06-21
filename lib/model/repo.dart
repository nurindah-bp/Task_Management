import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:task_management/models/project_task_progress.dart';
import 'package:task_management/models/task.dart';
import 'package:task_management/models/task_progress.dart';
import 'package:task_management/utils/endpoint.dart';

import '../models/dash_procastination.dart';
import '../models/project.dart';
import '../models/project_task.dart';

Future userLogin(String nip, String passwd) async {
  final response = await http.post(
    Uri.parse("${Endpoint.baseUrl}/login"),
    headers: {"Accept": "Application/json"},
    body: {'noinduk_pegawai': nip, 'password': passwd},
  );

  var decodeData = jsonDecode(response.body);
  return decodeData;
}

// Dashboard Start
class Procastination {
  Future getData() async {
    try {
      final response = await http.get(Uri.parse('${Endpoint.baseUrl}/dashboard/'));

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        print(response.body);
        Iterable it = jsonDecode(response.body);
        List<DashProcastination> dataProkastinasi =
            it.map((e) => DashProcastination.fromJson(e)).toList();
        return dataProkastinasi;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load prokrastination data');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
// Dashboard End

// Project Start
class projectListRepo {
  Future getData(String projDiv) async {
    try {
      final response = await http.get(Uri.parse(
          '${Endpoint.baseUrl}/project/projectList?projectdiv=$projDiv&stproject=1'));

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        print(response.body);
        Iterable it = jsonDecode(response.body);
        List<Project> dataProject =
            it.map((e) => Project.fromJson(e)).toList();
        return dataProject;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load album');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

class projectListRepo2 {
  Future getData(String projDiv) async {
    try {
      final response = await http.get(Uri.parse(
          '${Endpoint.baseUrl}/project/projectList?projectdiv=$projDiv&stproject=2'));

      if (response.statusCode == 200) {
        print(response.body);
        Iterable it = jsonDecode(response.body);
        List<Project> dataProject =
            it.map((e) => Project.fromJson(e)).toList();
        return dataProject;
      } else {
        throw Exception('Failed to load album');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

class projectListRepo3 {
  Future getData(String projDiv) async {
    try {
      final response = await http.get(Uri.parse(
          '${Endpoint.baseUrl}/project/projectList?projectdiv=$projDiv&stproject=3'));

      if (response.statusCode == 200) {
        print(response.body);
        Iterable it = jsonDecode(response.body);
        List<Project> dataProject =
            it.map((e) => Project.fromJson(e)).toList();
        return dataProject;
      } else {
        throw Exception('Failed to load album');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

class activeProjectTaskRepo {
  Future getData(String id) async {
    try {
      final response = await http.get(Uri.parse(
          '${Endpoint.baseUrl}/project/ptaskList?projectid=$id&stptask=1'));

      if (response.statusCode == 200) {
        print(response.body);
        Iterable it = jsonDecode(response.body);
        List<ProjectTask> dataProject =
            it.map((e) => ProjectTask.fromJson(e)).toList();
        return dataProject;
      } else {
        throw Exception('Failed to load album');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

class pendingProjectTaskRepo {
  Future getData(String id) async {
    try {
      final response = await http.get(Uri.parse(
          '${Endpoint.baseUrl}/project/ptaskList?projectid=$id&stptask=3'));

      if (response.statusCode == 200) {
        print(response.body);
        Iterable it = jsonDecode(response.body);
        List<ProjectTask> dataProject =
            it.map((e) => ProjectTask.fromJson(e)).toList();
        return dataProject;
      } else {
        throw Exception('Failed to load album');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

class doneProjectTaskRepo {
  Future getData(String id) async {
    try {
      final response = await http.get(Uri.parse(
          '${Endpoint.baseUrl}/project/ptaskList?projectid=$id&stptask=2'));

      if (response.statusCode == 200) {
        print(response.body);
        Iterable it = jsonDecode(response.body);
        List<ProjectTask> dataProject =
            it.map((e) => ProjectTask.fromJson(e)).toList();
        return dataProject;
      } else {
        throw Exception('Failed to load album');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

class projecttaskDetil {
  Future getData(String id) async {
    try {
      final response = await http
          .get(Uri.parse('${Endpoint.baseUrl}/project/ptaskDetil?ptaskid=$id'));

      if (response.statusCode == 200) {
        print(response.body);
        Iterable it = jsonDecode(response.body);
        List<ProjectTask> dataProject =
            it.map((e) => ProjectTask.fromJson(e)).toList();
        return dataProject;
      } else {
        throw Exception('Failed to load album');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

class projecttaskProgress {
  Future getData(String id) async {
    try {
      final response = await http
          .get(Uri.parse('${Endpoint.baseUrl}/project/ptaskProgress?ptaskid=$id'));

      if (response.statusCode == 200) {
        print(response.body);
        Iterable it = jsonDecode(response.body);
        List<ProjectTaskProgress> dataProject =
            it.map((e) => ProjectTaskProgress.fromJson(e)).toList();
        return dataProject;
      } else {
        throw Exception('Failed to load album');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

// Project End
// Task Start
class activeTaskRepo {
  Future getData(String paramValue, int? sessionId) async {
    try {
      final response =
          await http.get(Uri.parse('${Endpoint.baseUrl}/task/taskList?sttask=1&position=$paramValue&sessionId=$sessionId'));

      if (response.statusCode == 200) {
        print(response.body);
        Iterable it = jsonDecode(response.body);
        List<Task> dataProject = it.map((e) => Task.fromJson(e)).toList();
        return dataProject;
      } else {
        throw Exception('Failed to load album');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

class pendingTaskRepo {
  Future getData(String paramValue, int? sessionId) async {
    try {
      final response =
          await http.get(Uri.parse('${Endpoint.baseUrl}/task/taskList?sttask=3&position=$paramValue&sessionId=$sessionId'));

      if (response.statusCode == 200) {
        print(response.body);
        Iterable it = jsonDecode(response.body);
        List<Task> dataProject = it.map((e) => Task.fromJson(e)).toList();
        return dataProject;
      } else {
        throw Exception('Failed to load album');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

class doneTaskRepo {
  Future getData(String paramValue, int? sessionId) async {
    try {
      final response =
          await http.get(Uri.parse('${Endpoint.baseUrl}/task/taskList?sttask=2&position=$paramValue&sessionId=$sessionId'));

      if (response.statusCode == 200) {
        print(response.body);
        Iterable it = jsonDecode(response.body);
        List<Task> dataProject = it.map((e) => Task.fromJson(e)).toList();
        return dataProject;
      } else {
        throw Exception('Failed to load album');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

class taskDetil {
  Future getData(String id) async {
    try {
      final response = await http
          .get(Uri.parse('${Endpoint.baseUrl}/task/taskDetil?idtask=$id'));

      if (response.statusCode == 200) {
        print(response.body);
        Iterable it = jsonDecode(response.body);
        List<Task> dataTasks = it.map((e) => Task.fromJson(e)).toList();
        return dataTasks;
      } else {
        throw Exception('Failed to load album');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

class taskProgress {
  Future getData(String id) async {
    try {
      final response = await http
          .get(Uri.parse('${Endpoint.baseUrl}/task/taskProgress?idtask=$id'));

      if (response.statusCode == 200) {
        print(response.body);
        Iterable it = jsonDecode(response.body);
        List<TaskProgress> dataTaskProgress =
            it.map((e) => TaskProgress.fromJson(e)).toList();
        return dataTaskProgress;
      } else {
        throw Exception('Failed to load album');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
//Task End