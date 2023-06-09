import 'dart:async';
import 'package:intl/intl.dart';
import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:task_management/model/repo.dart';
import 'package:task_management/models/task.dart';
import 'package:task_management/views/task/addtask.dart';
import 'package:task_management/views/task/tasklistprogress.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  final AuthController authController = Get.find<AuthController>();
  List<Task> activeTask = [];
  List<Task> pendingTask = [];
  List<Task> doneTask = [];
  activeTaskRepo active = activeTaskRepo();
  pendingTaskRepo pending = pendingTaskRepo();
  doneTaskRepo done = doneTaskRepo();
  bool loading = false;
  TextEditingController searchController = TextEditingController();

  // getData() async {
  //   activeTask = await active.getData();
  //   pendingTask = await pending.getData();
  //   doneTask = await done.getData();
  //   setState(() {});
  // }

  Future<void> getData() async {
    // print("GET DATA LIST PROJECT");
    if (authController.currentUser.value?.positionId.toString() == '1' || authController.currentUser.value?.positionId.toString() == '2') {
      String paramValue = '2';
      final sessionId = authController.currentUser.value?.userId;
      activeTask = await active.getData(paramValue, sessionId);
      pendingTask = await pending.getData(paramValue, sessionId);
      doneTask = await done.getData(paramValue, sessionId);
    } else {
      String paramValue = '3';
      final sessionId = authController.currentUser.value?.userId;
      activeTask = await active.getData(paramValue, sessionId);
      pendingTask = await pending.getData(paramValue, sessionId);
      doneTask = await done.getData(paramValue, sessionId);
    }
    // pendingTask = await pending.getData();
    // doneTask = await done.getData();
    setState(() {});
    loading = true;
  }

  List<Task> searchResults = [];
  List<Task> searchPendingResults = [];
  List<Task> searchDoneResults = [];

  Future<void> getTasks(String searchText) async {
    // print("GET DATA LIST PROJECT");
    if (authController.currentUser.value?.positionId.toString() == '1' || authController.currentUser.value?.positionId.toString() == '2') {
      String paramValue = '2';
      final sessionId = authController.currentUser.value?.userId;
      activeTask = await active.getData(paramValue, sessionId);
      pendingTask = await pending.getData(paramValue, sessionId);
      doneTask = await done.getData(paramValue, sessionId);
    } else {
      String paramValue = '3';
      final sessionId = authController.currentUser.value?.userId;
      activeTask = await active.getData(paramValue, sessionId);
      pendingTask = await pending.getData(paramValue, sessionId);
      doneTask = await done.getData(paramValue, sessionId);
    }

    if (searchText.isNotEmpty) {
      searchResults = activeTask
          .where((task) =>
              task.employeeName.employeeName.toLowerCase().contains(searchText.toLowerCase()) ||
              task.taskName.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
      searchPendingResults = pendingTask
          .where((task) =>
              task.employeeName.employeeName.toLowerCase().contains(searchText.toLowerCase()) ||
              task.taskName.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
      searchDoneResults = doneTask
          .where((task) =>
              task.employeeName.employeeName.toLowerCase().contains(searchText.toLowerCase()) ||
              task.taskName.toLowerCase().contains(searchText.toLowerCase()))
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
          // title: const Text('Daftar Tugas'),
          title: AnimatedSearchBar(
            label: "Search Something Here",
            onChanged: (value) {
              setState(() {
                getTasks(value);
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddTask()),
                );
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
            ListView.separated(
              itemCount: searchResults.isNotEmpty ? searchResults.length : activeTask.length,
              itemBuilder: (context, index) {
                final Task task = searchResults.isNotEmpty ? searchResults[index] : activeTask[index];
                DateTime assignDate = DateTime.parse(task.taskDate);
                DateTime deadline = DateTime.parse(task.taskDeadline);
                String formattedAssignDate = DateFormat('dd-MM-yyyy').format(assignDate);
                String formattedAssignTime = DateFormat('HH:mm:ss').format(assignDate);
                String formattedDateline = DateFormat('dd-MM-yyyy').format(deadline);
                String formattedDeadlineTime = DateFormat('HH:mm:ss').format(deadline);
                return ListTile(
                  isThreeLine: true,
                  shape: Border(left: BorderSide(color: Colors.red, width: 5)),
                  title: Text(
                    // activeTask[index].taskName,
                    task.taskName,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.note_alt_outlined,
                            color: Colors.blue[600],
                          ),
                          SizedBox(width: 6),
                          Text(
                            // activeTask[index].taskDescription,
                            task.taskDescription,
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Icon(Icons.account_circle, color: Colors.blue[600]),
                          SizedBox(width: 6),
                          Text(
                            task.employeeName.employeeName,
                          ),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => TaskListProgress(taskId: task.taskId)));
                  },
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
              // itemCount: activeTask.length
            ),
            ListView.separated(
              itemCount: searchPendingResults.isNotEmpty ? searchPendingResults.length : pendingTask.length,
              itemBuilder: (context, index) {
                final Task task = searchPendingResults.isNotEmpty ? searchPendingResults[index] : pendingTask[index];
                DateTime assignDate = DateTime.parse(task.taskDate);
                DateTime deadline = DateTime.parse(task.taskDeadline);
                String formattedAssignDate = DateFormat('dd-MM-yyyy').format(assignDate);
                String formattedAssignTime = DateFormat('HH:mm:ss').format(assignDate);
                String formattedDateline = DateFormat('dd-MM-yyyy').format(deadline);
                String formattedDeadlineTime = DateFormat('HH:mm:ss').format(deadline);
                return ListTile(
                    isThreeLine: true,
                    shape: Border(left: BorderSide(color: Colors.yellow, width: 5)),
                    title: Text(
                      // pendingTask[index].taskName,
                      task.taskName,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 6,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.note_alt_outlined,
                              color: Colors.blue[600],
                            ),
                            SizedBox(width: 6),
                            Text(
                              // pendingTask[index].taskDescription,
                              task.taskDescription,
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.account_circle),
                            SizedBox(width: 6),
                            Text(
                              task.employeeName.employeeName,
                            ),
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
                    ));
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
              // itemCount: pendingTask.length
            ),
            ListView.separated(
              itemCount: searchDoneResults.isNotEmpty ? searchDoneResults.length : doneTask.length,
              itemBuilder: (context, index) {
                final Task task = searchDoneResults.isNotEmpty ? searchDoneResults[index] : doneTask[index];
                DateTime assignDate = DateTime.parse(task.taskDate);
                DateTime deadline = DateTime.parse(task.taskDeadline);
                String formattedAssignDate = DateFormat('dd-MM-yyyy').format(assignDate);
                String formattedAssignTime = DateFormat('HH:mm:ss').format(assignDate);
                String formattedDateline = DateFormat('dd-MM-yyyy').format(deadline);
                String formattedDeadlineTime = DateFormat('HH:mm:ss').format(deadline);
                return ListTile(
                    isThreeLine: true,
                    shape: Border(left: BorderSide(color: Colors.green, width: 5)),
                    title: Text(
                      // doneTask[index].taskName,
                      task.taskName,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 6,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.note_alt_outlined, color: Colors.blue[600],),
                            SizedBox(width: 6),
                            Text(
                              // doneTask[index].taskDescription,
                              task.taskDescription,
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.account_circle, color: Colors.blue[600]),
                            SizedBox(width: 6),
                            Text(
                              task.employeeName.employeeName,
                            ),
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
                    ));
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
              // itemCount: doneTask.length
            ),
          ],
        ),
      ),
    );
  }
}
