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

class projectListRepo {
  // final _baseUrl = 'http://10.0.2.2:3000/projectList?stproject=' + '1';

  Future getData() async {
    try {
      final response =
          await http.get(Uri.parse('${Utils.baseUrl}/projectList?stproject=1'));

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
  // final _baseUrl = 'http://10.0.2.2:3000/projectList?stproject=' + '2';

  Future getData() async {
    try {
      // final response = await http.get(Uri.parse(_baseUrl));
      final response =
          await http.get(Uri.parse('${Utils.baseUrl}/projectList?stproject=2'));

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

class projectListRepo3 {
  // final _baseUrl = 'http://10.0.2.2:3000/projectList?stproject=' + '3';

  Future getData() async {
    try {
      // final response = await http.get(Uri.parse(_baseUrl));
      final response =
          await http.get(Uri.parse('${Utils.baseUrl}/projectList?stproject=3'));

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

class activeTaskRepo {
  // final _baseUrl = 'http://10.0.2.2:3000/taskList?sttask=' + '1';

  Future getData() async {
    try {
      // final response = await http.get(Uri.parse(_baseUrl));
      final response =
          await http.get(Uri.parse('${Utils.baseUrl}/taskList?sttask=1'));

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        print(response.body);
        Iterable it = jsonDecode(response.body);
        List<Task> _dataProject = it.map((e) => Task.fromJson(e)).toList();
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

class pendingTaskRepo {
  // final _baseUrl = 'http://10.0.2.2:3000/taskList?sttask=' + '2';

  Future getData() async {
    try {
      // final response = await http.get(Uri.parse(_baseUrl));
      final response =
          await http.get(Uri.parse('${Utils.baseUrl}/taskList?sttask=3'));

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        print(response.body);
        Iterable it = jsonDecode(response.body);
        List<Task> _dataProject = it.map((e) => Task.fromJson(e)).toList();
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

class doneTaskRepo {
  // final _baseUrl = 'http://10.0.2.2:3000/taskList?sttask=' + '3';

  Future getData() async {
    try {
      // final response = await http.get(Uri.parse(_baseUrl));
      final response =
          await http.get(Uri.parse('${Utils.baseUrl}/taskList?sttask=2'));

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        print(response.body);
        Iterable it = jsonDecode(response.body);
        List<Task> _dataProject = it.map((e) => Task.fromJson(e)).toList();
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
