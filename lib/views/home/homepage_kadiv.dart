import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:task_management/controllers/auth_controller.dart';
import 'package:task_management/controllers/procastionation_controller.dart';
import 'package:task_management/models/dash_procastination.dart';

class HomePageKadiv extends StatefulWidget {
  const HomePageKadiv({super.key});

  @override
  State<HomePageKadiv> createState() => _HomePageKadivState();
}

class _HomePageKadivState extends State<HomePageKadiv> {
  final ProcastinationController procastinationController = Get.find<ProcastinationController>();
  final AuthController authController = Get.find<AuthController>();

  bool isLoading = true;

  @override
  void initState() {
    loadData();
    super.initState();
  }

  void loadData() async {
    await procastinationController.getData();
    await procastinationController.getDataProductivity();
    await procastinationController.getDataResumeTask();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  flex: 0,
                  child: Icon(Icons.account_circle, size: 60, color: Colors.blueAccent),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsets.only(top: 20, left: 10, right: 20, bottom: 20),
                    padding: const EdgeInsets.all(12),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(border: Border.all(color: Color(0xff0693e3)), borderRadius: BorderRadius.circular(10)),
                    child: Obx(
                      () => Text(
                        'Hi! ${authController.currentUser.value?.employeeName}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          height: 1.2125,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 0,
                  child: Icon(
                    Icons.notifications_active,
                    size: 30,
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text('Dashboard In Progress'),
            ),
          ],
        ),
      ),
    );
  }
}
