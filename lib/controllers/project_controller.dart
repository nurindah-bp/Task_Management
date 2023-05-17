import 'dart:convert';
import 'package:get/get.dart';
import 'package:task_management/controllers/auth_controller.dart';
import 'package:task_management/models/division.dart';
import 'package:http/http.dart' as http;
import 'package:task_management/models/project.dart';
import 'package:task_management/utils/endpoint.dart';

class ProjectController extends GetxController {
  RxList<Division> divisons = RxList();
  RxList<Project> projects = RxList();

  Future<void> getDivisions() async {
    final AuthController authController = Get.find<AuthController>();
    String positionId = authController.currentUser.value?.positionId.toString() ?? '';
    String divisionId = authController.currentUser.value?.divisionId.toString() ?? '';
    String url;

    if (positionId == '1') {
      url = "${Endpoint.baseUrl}/employee/divisions";
    } else {
      url = "${Endpoint.baseUrl}/employee/division?division_id=$divisionId";
    }

    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) return;

    List data = jsonDecode(response.body);
    for (var divisionJson in data) {
      divisons.add(Division.fromJson(divisionJson));
    }
  }

  Future<void> getProjects(int divisionId) async {
    final response = await http.get(Uri.parse('${Endpoint.baseUrl}/project/projectList?projectdiv=$divisionId&stproject=1'));
    if (response.statusCode != 200) return;

    List data = jsonDecode(response.body);
    for (var divisionJson in data) {
      projects.add(Project.fromJson(divisionJson));
    }
  }
}
