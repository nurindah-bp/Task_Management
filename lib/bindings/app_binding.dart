import 'package:get/get.dart';
import 'package:task_management/controllers/auth_controller.dart';
import 'package:task_management/controllers/procastionation_controller.dart';
import 'package:task_management/controllers/project_controller.dart';

class AppBinding implements Bindings {

  @override
  void dependencies() {
    // put controller => create controller
    Get.put<AuthController>(AuthController());
    Get.put<ProcastinationController>(ProcastinationController());
    Get.put<ProjectController>(ProjectController());
  }
}
