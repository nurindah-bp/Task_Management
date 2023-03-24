import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task_management/model/model.dart';

class projectListRepo {
  final _baseUrl = 'http://10.0.2.2:3000/projectList?stproject=1';

  Future getData() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

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
