import 'dart:async';
import 'package:intl/intl.dart';
import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:task_management/controllers/auth_controller.dart';
import 'package:task_management/models/project_task.dart';
import 'package:task_management/views/project/addprojecttask.dart';
import 'package:task_management/views/project/projecttaskprogresspage.dart';

import '../../model/repo.dart';
import '../../utils/endpoint.dart';

class ProjectTaskListPage extends StatefulWidget {
  // // const ProjectTaskListPage(String params, {super.key});
  final String projectId;

  const ProjectTaskListPage({Key? key, required this.projectId}) : super(key: key);

  @override
  State<ProjectTaskListPage> createState() => _ProjectTaskListPageState();
}

class _ProjectTaskListPageState extends State<ProjectTaskListPage> {
  final AuthController authController = Get.find<AuthController>();
  List<ProjectTask> activeProjectTask = [];
  List<ProjectTask> pendingProjectTask = [];
  List<ProjectTask> doneProjectTask = [];
  activeProjectTaskRepo active = activeProjectTaskRepo();
  pendingProjectTaskRepo pending = pendingProjectTaskRepo();
  doneProjectTaskRepo done = doneProjectTaskRepo();
  bool loading = false;
  TextEditingController searchController = TextEditingController();
  int activeCount = 0;

  // getData() async {
  //   activeProjectTask = await active.getData(widget.projectId);
  //   pendingProjectTask = await pending.getData(widget.projectId);
  //   doneProjectTask = await done.getData(widget.projectId);
  //   setState(() {});
  // }

  Future<void> getData() async {
    activeProjectTask = await active.getData(widget.projectId);
    pendingProjectTask = await pending.getData(widget.projectId);
    doneProjectTask = await done.getData(widget.projectId);
    activeCount = countActiveTasks(activeProjectTask);
    setState(() {});
  }

  int countActiveTasks(List<ProjectTask> tasks) {
    return tasks.where((task) => task.projectId.isNotEmpty).length;
  }

  List<ProjectTask> searchResults = [];
  List<ProjectTask> searchPendingResults = [];
  List<ProjectTask> searchDoneResults = [];

  Future<void> getPTasks(String searchText) async {
    print("GET DATA LIST PROJECT");
    activeProjectTask = await active.getData(widget.projectId);
    pendingProjectTask = await pending.getData(widget.projectId);
    doneProjectTask = await done.getData(widget.projectId);

    if (searchText.isNotEmpty) {
      searchResults = activeProjectTask
          .where((pTask) =>
              pTask.employeeName.employeeName.toLowerCase().contains(searchText.toLowerCase()) ||
              pTask.ptaskName.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
      searchPendingResults = pendingProjectTask
          .where((pTask) =>
              pTask.employeeName.employeeName.toLowerCase().contains(searchText.toLowerCase()) ||
              pTask.ptaskName.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
      searchDoneResults = doneProjectTask
          .where((pTask) =>
              pTask.employeeName.employeeName.toLowerCase().contains(searchText.toLowerCase()) ||
              pTask.ptaskName.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    } else {
      searchResults = [];
      searchPendingResults = [];
      searchDoneResults = [];
    }

    setState(() {});
    loading = true;
  }

  @override
  void initState() {
    getData();
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    stopTimer(); // Stop the timer when the widget is disposed
    super.dispose();
  }

  Timer? timer;

  void startTimer() {
    const duration = Duration(seconds: 2); // Set the duration for auto-reload
    timer = Timer.periodic(duration, (Timer t) {
      getData(); // Trigger data retrieval and update
    });
  }

  void stopTimer() {
    timer?.cancel(); // Cancel the timer if it is running
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          // title: const Text('Daftar Tugas Proyek')
          title: AnimatedSearchBar(
            label: "Search Something Here",
            onChanged: (value) {
              setState(() {
                getPTasks(value);
              });
            },
          ),
          automaticallyImplyLeading: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add_box,
                color: Colors.white,
              ),
              onPressed: () {
// do something
                if (authController.currentUser.value?.positionId.toString() == '2') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddProjectTask()),
                  );
                }
              },
            ),
            IconButton(
              icon: Icon(
                Icons.check_circle_outline_outlined,
                color: Colors.white,
              ),
              onPressed: () async {
// do something
                if (authController.currentUser.value?.positionId.toString() == '2') {
                  if (activeCount == 0) {
                    String projID = widget.projectId;
                    var myResponse = await http.post(
                      Uri.parse('${Endpoint.baseUrl}/project/updateProjStatus'),
                      body: {
                        'projID': projID,
                      },
                    );
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Sukses'),
                          content: Text('Project Selesai. Semangat Menyelesaikan Project Lainnya'),
                          actions: [
                            TextButton(
                              child: Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Perhatian'),
                          content: Text('Tugas Proyek Tersisa : $activeCount'),
                          actions: [
                            TextButton(
                              child: Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Fitur Hanya Untuk Kepala Bidang', style: TextStyle(color: Colors.black),),
                      backgroundColor: Colors.yellow,

                    ),
                  );
                }
              },
            )
          ],
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Aktif',
              ),
              Tab(
                text: 'Pending',
              ),
              Tab(
                text: 'Selesai',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width * 0.9,
              child: ListView.separated(
                itemCount: searchResults.isNotEmpty ? searchResults.length : activeProjectTask.length,
                itemBuilder: (context, index) {
                  final ProjectTask pTask = searchResults.isNotEmpty ? searchResults[index] : activeProjectTask[index];
                  DateTime assignDate = DateTime.parse(pTask.ptaskDate);
                  DateTime deadline = DateTime.parse(pTask.ptaskDeadline);
                  String formattedAssignDate = DateFormat('dd-MM-yyyy').format(assignDate);
                  String formattedAssignTime = DateFormat('HH:mm:ss').format(assignDate);
                  String formattedDateline = DateFormat('dd-MM-yyyy').format(deadline);
                  String formattedDeadlineTime = DateFormat('HH:mm:ss').format(deadline);
                  return ListTile(
                    isThreeLine: true,
                    shape: Border(left: BorderSide(color: Colors.red, width: 5)),
                    title: Text(
                      // activeProjectTask[index].ptaskName,
                      pTask.ptaskName,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 6,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.note_alt_outlined,
                              color: Colors.blue[600],
                            ),
                            SizedBox(width: 6),
                            Flexible(child: Text(
                              // activeProjectTask[index].ptaskDescription,
                              pTask.ptaskDescription,
                            ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.account_circle, color: Colors.blue[600]),
                            SizedBox(width: 6),
                            Flexible(child: Text(
                              // activeProjectTask[index].employeeName.employeeName,
                              pTask.employeeName.employeeName,
                            ),),

                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.date_range_rounded, color: Colors.blue[600]),
                            SizedBox(width: 6),
                            Text(
                              formattedAssignDate,
                            ),
                            Text(
                              " " + formattedAssignTime,
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.timeline_rounded, color: Colors.red[400]),
                            SizedBox(width: 6),
                            Text(
                              formattedDateline,
                            ),
                            Text(
                              " " + formattedDeadlineTime,
                            ),
                          ],
                        ),
                      ],
                    ),
                    onTap: () {
                      if (authController.currentUser.value?.positionId.toString() != '1') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => projecttaskprogresspage(projectTaskId: pTask.ptaskId),
                          ),
                        );
                      }
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                // itemCount: activeProjectTask.length
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width * 0.9,
              child: ListView.separated(
                itemCount: searchPendingResults.isNotEmpty ? searchPendingResults.length : pendingProjectTask.length,
                itemBuilder: (context, index) {
                  final ProjectTask pTask = searchPendingResults.isNotEmpty ? searchPendingResults[index] : pendingProjectTask[index];
                  return ListTile(
                      isThreeLine: true,
                      shape: Border(left: BorderSide(color: Colors.yellow, width: 5)),
                      title: Text(
                        // pendingProjectTask[index].ptaskName,
                        pTask.ptaskName,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.note_alt_outlined,
                                color: Colors.blue[600],
                              ),
                              SizedBox(width: 6),
                              Text(
                                // pendingProjectTask[index].ptaskDescription,
                                pTask.ptaskDescription,
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Icon(Icons.account_circle, color: Colors.blue[600]),
                              SizedBox(width: 6),
                              Text(
                                // pendingProjectTask[index].employeeName.employeeName,
                                pTask.employeeName.employeeName,
                              ),
                            ],
                          )
                        ],
                      ));
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                // itemCount: pendingProjectTask.length
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width * 0.9,
              child: ListView.separated(
                itemCount: searchDoneResults.isNotEmpty ? searchDoneResults.length : doneProjectTask.length,
                itemBuilder: (context, index) {
                  final ProjectTask pTask = searchDoneResults.isNotEmpty ? searchDoneResults[index] : doneProjectTask[index];
                  return ListTile(
                      isThreeLine: true,
                      shape: Border(left: BorderSide(color: Colors.green, width: 5)),
                      title: Text(
                        // doneProjectTask[index].ptaskName,
                        pTask.ptaskName,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.note_alt_outlined,
                                color: Colors.blue[600],
                              ),
                              SizedBox(width: 6),
                              Text(
                                // doneProjectTask[index].ptaskDescription,
                                pTask.ptaskDescription,
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Icon(Icons.account_circle, color: Colors.blue[600]),
                              SizedBox(width: 6),
                              Text(
                                // doneProjectTask[index].employeeName.employeeName,
                                pTask.employeeName.employeeName,
                              ),
                            ],
                          )
                        ],
                      ));
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                // itemCount: doneProjectTask.length
              ),
            ),
          ],
        ),
      ),
    );
  }
}
