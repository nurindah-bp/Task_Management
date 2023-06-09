import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:task_management/controllers/auth_controller.dart';
import 'package:task_management/controllers/procastionation_controller.dart';
import 'package:task_management/models/dash_procastination.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    setState(() {
      isLoading = false;
    });
  }
  Widget buildKepsek() {
    return Column(
      children: [
        ProcastinationChart(controller: procastinationController),
        SizedBox(height: 20),
        ProductivityChart(controller: procastinationController),
        SizedBox(height: 20),
      ],
    );
  }

  Widget buildKabid() {
    return Column(
      children: [
        ResumeKabidTask(),
        SizedBox(height: 20),
        ResumeEmployeesTask(),
        SizedBox(height: 20),
      ],
    );
  }

  Widget buildEmployee() {
    return Column(
      children: [
        ResumeEmployeeTask(),
        SizedBox(height: 20),
      ],
    );
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
            Container(
              child: Column(
                children: <Widget>[
                  if (authController.currentUser.value?.positionId.toString() == '1')
                    buildKepsek()
                  else if (authController.currentUser.value?.positionId.toString() == '2')
                    buildKabid()
                  else
                    buildEmployee(),
                ],
              ),
            ),
            // Container(
            //   child: Column(
            //     children: <Widget>[
            //       // Container(
            //       //   // padding: EdgeInsets.all(50),
            //       //   width: MediaQuery.of(context).size.width,
            //       //   height: 160,
            //       //   decoration: BoxDecoration(
            //       //     border: Border.all(color: Colors.black),
            //       //     borderRadius: BorderRadius.circular(10),
            //       //   ),
            //       //   child: Text(
            //       //     "Resume Prokrastinasi Tugas Pegawai",
            //       //     textAlign: TextAlign.center,
            //       //   ),
            //       // ),
            //       // SizedBox(
            //       //   height: 20,
            //       // ),
            //       Obx(
            //         () => SfCartesianChart(
            //           title: ChartTitle(text: 'Tingkat Prokrastinasi Pegawai'),
            //           // Initialize category axis
            //           primaryXAxis: CategoryAxis(),
            //           series: <BarSeries<DashProcastination, String>>[
            //             BarSeries<DashProcastination, String>(
            //               color: Colors.blueAccent,
            //                 // Bind data source
            //                 dataSource: procastinationController.dataProkastinasi.toList(),
            //                 xValueMapper: (DashProcastination data, _) => data.employeeName,
            //                 yValueMapper: (DashProcastination data, _) => data.prokastinasi,
            //                 dataLabelSettings: DataLabelSettings(isVisible: true),),
            //           ],
            //         ),
            //       ),
            //       SizedBox(
            //         height: 20,
            //       ),
            //       Obx(
            //             () => SfCartesianChart(
            //           title: ChartTitle(text: 'Tingkat Produktivitas Pegawai'),
            //           // Initialize category axis
            //           primaryXAxis: CategoryAxis(),
            //           series: <BarSeries<DashProcastination, String>>[
            //             BarSeries<DashProcastination, String>(
            //               color: Colors.blueAccent,
            //               // Bind data source
            //               dataSource: procastinationController.dataProduktivitas.toList(),
            //               xValueMapper: (DashProcastination data, _) => data.employeeName,
            //               yValueMapper: (DashProcastination data, _) => data.prokastinasi,
            //               dataLabelSettings: DataLabelSettings(isVisible: true),),
            //           ],
            //         ),
            //       ),
            //       SizedBox(
            //         height: 20,
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class ProcastinationChart extends StatelessWidget {
  final ProcastinationController controller;

  const ProcastinationChart({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Obx(
                () => SfCartesianChart(
              title: ChartTitle(text: 'Tingkat Prokrastinasi Pegawai'),
              // Initialize category axis
              primaryXAxis: CategoryAxis(),
              series: <BarSeries<DashProcastination, String>>[
                BarSeries<DashProcastination, String>(
                  color: Colors.blueAccent,
                  // Bind data source
                  dataSource: controller.dataProkastinasi.toList(),
                  xValueMapper: (DashProcastination data, _) => data.employeeName,
                  yValueMapper: (DashProcastination data, _) => data.prokastinasi,
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductivityChart extends StatelessWidget {
  final ProcastinationController controller;

  const ProductivityChart({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Obx(
                () => SfCartesianChart(
              title: ChartTitle(text: 'Tingkat Produktivitas Pegawai'),
              // Initialize category axis
              primaryXAxis: CategoryAxis(),
              series: <BarSeries<DashProcastination, String>>[
                BarSeries<DashProcastination, String>(
                  color: Colors.blueAccent,
                  // Bind data source
                  dataSource: controller.dataProduktivitas.toList(),
                  xValueMapper: (DashProcastination data, _) => data.employeeName,
                  yValueMapper: (DashProcastination data, _) => data.prokastinasi,
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ResumeKabidTask extends StatelessWidget {

  const ResumeKabidTask({super.key}) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent, width: 1.0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(8.0, 15.0, 8.0, 15.0),
            child: Text(
              'Resume Tugas Kepala Bidang',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '10',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        'Aktif',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '2',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Pending',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '7',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      Text(
                        'Selesai',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
class ResumeEmployeesTask extends StatelessWidget {

  const ResumeEmployeesTask({super.key}) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent, width: 1.0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(8.0, 15.0, 8.0, 15.0),
            child: Text(
              'Resume Tugas Karyawan per Bidang',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '5',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        'Aktif',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '1',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Pending',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '10',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      Text(
                        'Selesai',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
class ResumeEmployeeTask extends StatelessWidget {

  const ResumeEmployeeTask({super.key}) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent, width: 1.0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(8.0, 15.0, 8.0, 15.0),
            child: Text(
              'Resume Tugas Karyawan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '5',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        'Aktif',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '1',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Pending',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '10',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      Text(
                        'Selesai',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
