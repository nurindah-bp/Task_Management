import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task_management/model/model.dart';
import 'package:task_management/model/utils.dart';

Future userLogin(String nip, String passwd) async {
  final response = await http.post(
    Uri.parse("${Utils.baseUrl}/login"),
    headers: {"Accept": "Application/json"},
    body: {'noinduk_pegawai': nip, 'password': passwd},
  );

  var decodeData = jsonDecode(response.body);
  return decodeData;
}

// Project Start
class projectListRepo {
  Future getData() async {
    try {
      final response = await http
          .get(Uri.parse('${Utils.baseUrl}/project/projectList?stproject=1'));

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        print(response.body);
        Iterable it = jsonDecode(response.body);
        List<Project> _dataProject =
            it.map((e) => Project.fromJson(e)).toList();
        return _dataProject;
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
  Future getData() async {
    try {
      final response = await http
          .get(Uri.parse('${Utils.baseUrl}/project/projectList?stproject=2'));

      if (response.statusCode == 200) {
        print(response.body);
        Iterable it = jsonDecode(response.body);
        List<Project> _dataProject =
            it.map((e) => Project.fromJson(e)).toList();
        return _dataProject;
      } else {
        throw Exception('Failed to load album');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

class projectListRepo3 {
  Future getData() async {
    try {
      final response = await http
          .get(Uri.parse('${Utils.baseUrl}/project/projectList?stproject=3'));

      if (response.statusCode == 200) {
        print(response.body);
        Iterable it = jsonDecode(response.body);
        List<Project> _dataProject =
            it.map((e) => Project.fromJson(e)).toList();
        return _dataProject;
      } else {
        throw Exception('Failed to load album');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

class activeProjectTaskRepo {
  Future getData() async {
    try {
      final response = await http.get(Uri.parse(
          '${Utils.baseUrl}/project/ptaskList?projectid=1&stptask=1'));

      if (response.statusCode == 200) {
        print(response.body);
        Iterable it = jsonDecode(response.body);
        List<ProjectTask> _dataProject =
            it.map((e) => ProjectTask.fromJson(e)).toList();
        return _dataProject;
      } else {
        throw Exception('Failed to load album');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

class pendingProjectTaskRepo {
  Future getData() async {
    try {
      final response = await http.get(Uri.parse(
          '${Utils.baseUrl}/project/ptaskList?projectid=1&stptask=3'));

      if (response.statusCode == 200) {
        print(response.body);
        Iterable it = jsonDecode(response.body);
        List<ProjectTask> _dataProject =
            it.map((e) => ProjectTask.fromJson(e)).toList();
        return _dataProject;
      } else {
        throw Exception('Failed to load album');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

class doneProjectTaskRepo {
  Future getData() async {
    try {
      final response = await http.get(Uri.parse(
          '${Utils.baseUrl}/project/ptaskList?projectid=1&stptask=2'));

      if (response.statusCode == 200) {
        print(response.body);
        Iterable it = jsonDecode(response.body);
        List<ProjectTask> _dataProject =
            it.map((e) => ProjectTask.fromJson(e)).toList();
        return _dataProject;
      } else {
        throw Exception('Failed to load album');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

class projecttaskDetil {
  Future getData() async {
    try {
      final response = await http
          .get(Uri.parse('${Utils.baseUrl}/project/ptaskDetil?ptaskid=1'));

      if (response.statusCode == 200) {
        print(response.body);
        Iterable it = jsonDecode(response.body);
        List<ProjectTask> _dataProject =
            it.map((e) => ProjectTask.fromJson(e)).toList();
        return _dataProject;
      } else {
        throw Exception('Failed to load album');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

class projecttaskProgress {
  Future getData() async {
    try {
      final response = await http
          .get(Uri.parse('${Utils.baseUrl}/project/ptaskProgress?ptaskid=1'));

      if (response.statusCode == 200) {
        print(response.body);
        Iterable it = jsonDecode(response.body);
        List<ProjectTaskProgress> _dataProject =
            it.map((e) => ProjectTaskProgress.fromJson(e)).toList();
        return _dataProject;
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
  Future getData() async {
    try {
      final response =
          await http.get(Uri.parse('${Utils.baseUrl}/task/taskList?sttask=1'));

      if (response.statusCode == 200) {
        print(response.body);
        Iterable it = jsonDecode(response.body);
        List<Task> _dataProject = it.map((e) => Task.fromJson(e)).toList();
        return _dataProject;
      } else {
        throw Exception('Failed to load album');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

class pendingTaskRepo {
  Future getData() async {
    try {
      final response =
          await http.get(Uri.parse('${Utils.baseUrl}/task/taskList?sttask=3'));

      if (response.statusCode == 200) {
        print(response.body);
        Iterable it = jsonDecode(response.body);
        List<Task> _dataProject = it.map((e) => Task.fromJson(e)).toList();
        return _dataProject;
      } else {
        throw Exception('Failed to load album');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

class doneTaskRepo {
  Future getData() async {
    try {
      final response =
          await http.get(Uri.parse('${Utils.baseUrl}/task/taskList?sttask=2'));

      if (response.statusCode == 200) {
        print(response.body);
        Iterable it = jsonDecode(response.body);
        List<Task> _dataProject = it.map((e) => Task.fromJson(e)).toList();
        return _dataProject;
      } else {
        throw Exception('Failed to load album');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
//Task End