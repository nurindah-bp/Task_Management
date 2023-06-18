import 'dart:convert';
import 'package:get/get.dart';
import 'package:task_management/models/dash_procastination.dart';
import 'package:task_management/controllers/auth_controller.dart';
import 'package:http/http.dart' as http;
import 'package:task_management/models/project_resume.dart';
import 'package:task_management/models/projects_resume.dart';
import 'package:task_management/models/task_resume.dart';
import 'package:task_management/utils/endpoint.dart';

class ProcastinationController extends GetxController {
  RxList<DashProcastination> dataProkastinasi = RxList();
  RxList<DashProcastination> dataProduktivitas = RxList();
  RxList<TaskResume> dataResumeTasks = RxList();
  RxList<TaskResume> dataResumeTask = RxList();
  RxList<ProjectResume> dataResumeProjectBidang = RxList();
  RxList<ProjectsResume> dataResumeAllProjects = RxList();

  Future<void> getData() async {
    final response = await http.get(Uri.parse('${Endpoint.baseUrl}/dashboard/dashprocrastination/'));

    if (response.statusCode != 200) return;

    Iterable it = jsonDecode(response.body);
    dataProkastinasi.value = it.map((e) => DashProcastination.fromJson(e)).toList();
  }

  Future<void> getDataProductivity() async {
    final response = await http.get(Uri.parse('${Endpoint.baseUrl}/dashboard/dashproductivity/'));

    if (response.statusCode != 200) return;

    Iterable it = jsonDecode(response.body);
    dataProduktivitas.value = it.map((e) => DashProcastination.fromJson(e)).toList();
  }

  Future<void> getDataResumeProjects() async {
    final AuthController authController = Get.find<AuthController>();
    String userId = authController.currentUser.value?.userId.toString() ?? '';
    String divisionId = authController.currentUser.value?.divisionId.toString() ?? '';
    final response = await http.get(Uri.parse('${Endpoint.baseUrl}/dashboard/dashprojects?project_div=$divisionId'));

    if (response.statusCode != 200) return;

    // Iterable it = jsonDecode(response.body);
    // dataResumeAllProjects.value = it.map((e) => ProjectsResume.fromJson(e)).toList();
    List data = jsonDecode(response.body);
    for (var projectsJson in data) {
      dataResumeAllProjects.add(ProjectsResume.fromJson(projectsJson));
    }
  }
  Future<void> getDataResumeProjectBid() async {
    final AuthController authController = Get.find<AuthController>();
    String userId = authController.currentUser.value?.userId.toString() ?? '';
    String divisionId = authController.currentUser.value?.divisionId.toString() ?? '';
    final response = await http.get(Uri.parse('${Endpoint.baseUrl}/dashboard/dashproject?project_div=$divisionId'));

    if (response.statusCode != 200) return;

    Iterable it = jsonDecode(response.body);
    dataResumeProjectBidang.value = it.map((e) => ProjectResume.fromJson(e)).toList();
  }

  Future<void> getDataResumeTasks() async {
    final AuthController authController = Get.find<AuthController>();
    String userId = authController.currentUser.value?.userId.toString() ?? '';
    final response = await http.get(Uri.parse('${Endpoint.baseUrl}/dashboard/dashtasks?user_id=$userId'));

    if (response.statusCode != 200) return;

    Iterable it = jsonDecode(response.body);
    dataResumeTasks.value = it.map((e) => TaskResume.fromJson(e)).toList();
  }

  Future<void> getDataResumeTask() async {
    final AuthController authController = Get.find<AuthController>();
    String userId = authController.currentUser.value?.userId.toString() ?? '';
    final response = await http.get(Uri.parse('${Endpoint.baseUrl}/dashboard/dashtask?employee_id=$userId'));

    if (response.statusCode != 200) return;

    Iterable it = jsonDecode(response.body);
    dataResumeTask.value = it.map((e) => TaskResume.fromJson(e)).toList();
  }
}
