import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task_management/model/repo.dart';
import 'package:task_management/utils/endpoint.dart';
import 'package:task_management/utils/session_manager.dart';

class HomePage extends StatefulWidget {
  // const HomePage({super.key});
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _sessionValue = '';
  // List<BarChartModel> data = [];
  late List<BarChartModel> _employeeDataList;

  @override
  void initState() {
    super.initState();
    loadData();
    SessionManager.getSession().then((value) {
      setState(() {
        _sessionValue = value.split('-')[1];
      });
    });
  }

  Future<void> loadData() async {
    final response = await http.get(Uri.parse('${Endpoint.baseUrl}/dashboard/'));
    final jsonData = jsonDecode(response.body);
    setState(() {
      _employeeDataList = (jsonData as List)
          .map((item) => BarChartModel.fromJson(item))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SizedBox(
        height: 300,
        child: StackBarChart(
          employeeDataList: _employeeDataList,
        ),
      )),
    );
  }
}

class BarChartModel {
  final int employeeId;
  final String employeeName;
  final double value;

  const BarChartModel(
      {required this.employeeId,
      required this.employeeName,
      required this.value});

  factory BarChartModel.fromJson(Map<String, dynamic> json) {
    return BarChartModel(
      employeeId: json['employee_number'],
      employeeName: json['employee_name'],
      value: double.parse(json['prokastinasi']),
    );
  }
}

class StackBarChart extends StatelessWidget {
  final List<BarChartModel> employeeDataList;

  const StackBarChart({required this.employeeDataList});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        groupsSpace: 16,
        barGroups: employeeDataList
            .map(
              (employeeData) => BarChartGroupData(
                x: employeeData.employeeId,
                barRods: [
                  BarChartRodData(
                    toY: employeeData.value,
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
