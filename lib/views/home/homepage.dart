import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:task_management/controllers/auth_controller.dart';
import 'package:task_management/controllers/procastionation_controller.dart';
import 'package:task_management/models/dash_procastination.dart';
import 'package:task_management/models/task_resume.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'package:searchbar_animation/searchbar_animation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProcastinationController procastinationController = Get.find<ProcastinationController>();
  final AuthController authController = Get.find<AuthController>();
  RxList<TaskResume> dataResumeTask = RxList<TaskResume>();

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    await procastinationController.getData();
    await procastinationController.getDataProductivity();
    await procastinationController.getDataResumeTask();
    await procastinationController.getDataResumeTasks();
    await procastinationController.getDataResumeProjectBid();
    if (procastinationController.dataResumeAllProjects.isEmpty) {
      await procastinationController.getDataResumeProjects();
    }
    // await procastinationController.getDataResumeProjects();
    setState(() {
      isLoading = false;
    });
  }

  Widget buildKepsek() {
    return Column(
      children: [
        ResumeProjects(controller: procastinationController),
        SizedBox(height: 20),
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
        ResumeProjectBid(controller: procastinationController),
        SizedBox(height: 20),
        ResumeKabidTask(controller: procastinationController),
        SizedBox(height: 20),
        ResumeEmployeesTask(controller: procastinationController),
        SizedBox(height: 20),
      ],
    );
  }

  Widget buildEmployee() {
    return Column(
      children: [
        ResumeEmployeeTask(controller: procastinationController),
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
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    decoration: BoxDecoration(border: Border.all(color: Color(0xff0693e3)), borderRadius: BorderRadius.circular(10)),
                    child: Obx(
                          () =>
                          Text(
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
                  else
                    if (authController.currentUser.value?.positionId.toString() == '2')
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

class ResumeProjects extends StatelessWidget {
  final ProcastinationController controller;

  const ResumeProjects({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(8.0, 15.0, 8.0, 15.0),
            child: Text(
              'Persentase Project',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
              ), textAlign: TextAlign.center,
            ),
          ),
          Obx(
                () =>
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, // Number of columns in the grid
                    mainAxisSpacing: 5.0, // Spacing between rows
                    crossAxisSpacing: 5.0, // Spacing between columns
                  ),

                  itemCount: controller.dataResumeAllProjects.length,
                  itemBuilder: (BuildContext context, int index) {
                    // Build each item in the grid
                    final double doneValue = double.tryParse(controller.dataResumeAllProjects[index].done) ?? 0.0;
                    final double totalValue = double.tryParse(controller.dataResumeAllProjects[index].total) ?? 0.0;
                    final ratio = doneValue / totalValue * 100;
                    double ratioResult;
                    if (ratio.isNaN) {
                      ratioResult = 0.0; // or any other value you want to use for NaN
                    } else {
                      ratioResult = ratio;
                    }
                    final formattedRatio = NumberFormat("#,##0.0").format(ratioResult);
                    // print('Formatted ratio: $formattedRatio');
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(
                          color: Colors.blueAccent
                        )// Customize the color as needed
                      ),
                      child: Center(
                          // child: Text(controller.dataResumeAllProjects[index].divName)
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              controller.dataResumeAllProjects[index].divName,
                              // '10',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ), textAlign: TextAlign.center,
                            ),
                            Text(
                              formattedRatio.toString() + '%',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ), textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(), // Disable scrolling of the GridView
                ),
          ),
        ],
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
                () =>
                SfCartesianChart(
                  title: ChartTitle(text: 'Tingkat Prokrastinasi Pegawai'),
                  // Initialize category axis
                  primaryXAxis: CategoryAxis(),
                  series: <BarSeries<DashProcastination, String>>[
                    BarSeries<DashProcastination, String>(
                      color: Colors.lightBlue,
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
                () =>
                SfCartesianChart(
                  title: ChartTitle(text: 'Tingkat Produktivitas Pegawai'),
                  // Initialize category axis
                  primaryXAxis: CategoryAxis(),
                  series: <BarSeries<DashProcastination, String>>[
                    BarSeries<DashProcastination, String>(
                      color: Colors.lightGreen,
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

class ResumeProjectBid extends StatelessWidget {
  final ProcastinationController controller;

  const ResumeProjectBid({Key? key, required this.controller}) : super(key: key);

  // const ResumeKabidTask({super.key}) ;

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
              'Resume Project ' + controller.dataResumeProjectBidang[0].divName,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ), textAlign: TextAlign.center,
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
                        controller.dataResumeProjectBidang[0].nonprogress,
                        // '10',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ), textAlign: TextAlign.center,
                      ),
                      Text(
                        'Belum Dikerjakan',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ), textAlign: TextAlign.center,
                      ),

                    ],
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        controller.dataResumeProjectBidang[0].inprogress,
                        // '10',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ), textAlign: TextAlign.center,
                      ),
                      Text(
                        'Sedang Dikerjakan',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ), textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        controller.dataResumeProjectBidang[0].pending,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ), textAlign: TextAlign.center,
                      ),
                      Text(
                        'Project Dipending',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ), textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ), Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        controller.dataResumeProjectBidang[0].done,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ), textAlign: TextAlign.center,
                      ),
                      Text(
                        'Project Diselesaikan',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ), textAlign: TextAlign.center,
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

class ResumeKabidTask extends StatelessWidget {
  final ProcastinationController controller;

  const ResumeKabidTask({Key? key, required this.controller}) : super(key: key);

  // const ResumeKabidTask({super.key}) ;

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
              ), textAlign: TextAlign.center,
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
                        controller.dataResumeTask[0].nonprogress,
                        // '10',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ), textAlign: TextAlign.center,
                      ),
                      Text(
                        'Belum Dikerjakan',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ), textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        controller.dataResumeTask[0].inprogress,
                        // '10',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ), textAlign: TextAlign.center,
                      ),
                      Text(
                        'Sedang Dikerjakan',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ), textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        controller.dataResumeTask[0].pending,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ), textAlign: TextAlign.center,
                      ),
                      Text(
                        'Tugas Dipending',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ), textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ), Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        controller.dataResumeTask[0].done,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ), textAlign: TextAlign.center,
                      ),
                      Text(
                        'Tugas Diselesaikan',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ), textAlign: TextAlign.center,
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
  final ProcastinationController controller;

  const ResumeEmployeesTask({Key? key, required this.controller}) : super(key: key);

  // const ResumeEmployeesTask({super.key}) ;

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
              'Resume Tugas Harian Karyawan Bidang',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ), textAlign: TextAlign.center,
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
                        controller.dataResumeTasks[0].nonprogress.isEmpty ? '0' : controller.dataResumeTasks[0].nonprogress,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ), textAlign: TextAlign.center,
                      ),
                      Text(
                        'Belum Dikerjakan',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ), textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ), Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        controller.dataResumeTasks[0].inprogress.isEmpty ? '0' : controller.dataResumeTasks[0].inprogress,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ), textAlign: TextAlign.center,
                      ),
                      Text(
                        'Sedang Dikerjakan',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ), textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        controller.dataResumeTasks[0].pending.isEmpty ? '0' : controller.dataResumeTasks[0].pending,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ), textAlign: TextAlign.center,
                      ),
                      Text(
                        'Tugas Dipending',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ), textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ), Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        controller.dataResumeTasks[0].done.isEmpty ? '0' : controller.dataResumeTasks[0].done,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ), textAlign: TextAlign.center,
                      ),
                      Text(
                        'Tugas Diselesaikan',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ), textAlign: TextAlign.center,
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
  final ProcastinationController controller;

  const ResumeEmployeeTask({Key? key, required this.controller}) : super(key: key);

  // const ResumeEmployeeTask({super.key}) ;

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
              ), textAlign: TextAlign.center,
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
                        controller.dataResumeTask[0].nonprogress,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ), textAlign: TextAlign.center,
                      ),
                      Text(
                        'Belum Dikerjakan',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ), textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ), Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        controller.dataResumeTask[0].inprogress,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ), textAlign: TextAlign.center,
                      ),
                      Text(
                        'Sedang Dikerjakan',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ), textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ), Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        controller.dataResumeTask[0].pending,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ), textAlign: TextAlign.center,
                      ),
                      Text(
                        'Tugas Dipending',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ), textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ), Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        controller.dataResumeTask[0].done,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ), textAlign: TextAlign.center,
                      ),
                      Text(
                        'Tugas Diselesaikan',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ), textAlign: TextAlign.center,
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
