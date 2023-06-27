import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:get/get.dart';
import 'package:task_management/controllers/auth_controller.dart';
import 'package:task_management/model/repo.dart';
import 'package:task_management/models/project.dart';
import 'package:task_management/views/project/addproject.dart';
import 'package:task_management/views/project/projecttasklistpage.dart';

class ProjectListPage extends StatefulWidget {
  final String projectDivId;

  const ProjectListPage({Key? key, required this.projectDivId}) : super(key: key);

  @override
  State<ProjectListPage> createState() => _ProjectListPageState();
}

class _ProjectListPageState extends State<ProjectListPage> {
  final AuthController authController = Get.find<AuthController>();
  List<Project> listProject = [];
  List<Project> listProject2 = [];
  List<Project> listProject3 = [];
  projectListRepo repository = projectListRepo();
  projectListRepo2 repository2 = projectListRepo2();
  projectListRepo3 repository3 = projectListRepo3();
  bool loading = false;
  TextEditingController searchController = TextEditingController();

  Future<void> getData() async {
    print("GET DATA LIST PROJECT");
    listProject = await repository.getData(widget.projectDivId);
    listProject2 = await repository2.getData(widget.projectDivId);
    listProject3 = await repository3.getData(widget.projectDivId);
    setState(() {});
    loading = true;
  }

  List<Project> searchResults = [];
  List<Project> searchPendingResults = [];
  List<Project> searchDoneResults = [];

  Future<void> getProjects(String searchText) async {
    print("GET DATA LIST PROJECT");
    listProject = await repository.getData(widget.projectDivId);
    listProject2 = await repository2.getData(widget.projectDivId);
    listProject3 = await repository3.getData(widget.projectDivId);

    if (searchText.isNotEmpty) {
      searchResults = listProject
          .where((project) =>
              project.employeeName.employeeName.toLowerCase().contains(searchText.toLowerCase()) ||
              project.projectName.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
      searchPendingResults = listProject
          .where((project) =>
              project.employeeName.employeeName.toLowerCase().contains(searchText.toLowerCase()) ||
              project.projectName.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
      searchDoneResults = listProject
          .where((project) =>
              project.employeeName.employeeName.toLowerCase().contains(searchText.toLowerCase()) ||
              project.projectName.toLowerCase().contains(searchText.toLowerCase()))
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
    String projDivId = widget.projectDivId;
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: AnimatedSearchBar(
            label: "Search Something Here",
            onChanged: (value) {
              setState(() {
                getProjects(value);
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
                    MaterialPageRoute(
                      builder: (context) => AddProject(
                        projectDivId: projDivId,
                      ),
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
                itemCount: searchResults.isNotEmpty ? searchResults.length : listProject.length,
                itemBuilder: (context, index) {
                  // final int params = listProject[index].id_proyek;
                  final Project project = searchResults.isNotEmpty ? searchResults[index] : listProject[index];
                  DateTime assignDate = DateTime.parse(project.projectDate);
                  DateTime deadline = DateTime.parse(project.projectDeadline);
                  String formattedAssignDate = DateFormat('dd-MM-yyyy').format(assignDate);
                  String formattedAssignTime = DateFormat('HH:mm:ss').format(assignDate);
                  String formattedDateline = DateFormat('dd-MM-yyyy').format(deadline);
                  String formattedDeadlineTime = DateFormat('HH:mm:ss').format(deadline);
                  return ListTile(
                    isThreeLine: true,
                    shape: Border(left: BorderSide(color: Colors.red, width: 5)),
                    title: Wrap(
                      children: [
                        Text(
                          project.projectName,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
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
                            Flexible(
                              child: Text(
                                project.projectDescription,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.account_circle, color: Colors.blue[600]),
                            SizedBox(width: 6),
                            Flexible(
                              child: Text(project.employeeName.employeeName),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProjectTaskListPage(
                            projectId: project.projectId.toString(),
                          ),
                        ),
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width * 0.9,
              child: ListView.separated(
                // itemCount: listProject3 != null ? listProject3.length : 0,
                itemCount: searchPendingResults.isNotEmpty ? searchPendingResults.length : listProject3.length,
                itemBuilder: (context, index) {
                  final Project project = searchPendingResults.isNotEmpty ? searchPendingResults[index] : listProject3[index];
                  DateTime assignDate = DateTime.parse(project.projectDate);
                  DateTime deadline = DateTime.parse(project.projectDeadline);
                  String formattedAssignDate = DateFormat('dd-MM-yyyy').format(assignDate);
                  String formattedAssignTime = DateFormat('HH:mm:ss').format(assignDate);
                  String formattedDateline = DateFormat('dd-MM-yyyy').format(deadline);
                  String formattedDeadlineTime = DateFormat('HH:mm:ss').format(deadline);
                  return ListTile(
                    isThreeLine: true,
                    shape: Border(left: BorderSide(color: Colors.yellow, width: 5)),
                    title: Text(
                      // listProject3[index].projectName,
                      project.projectName,
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
                            Flexible(
                              child: Text(
                                project.projectDescription,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.account_circle, color: Colors.blue[600]),
                            SizedBox(width: 6),
                            Flexible(
                              child: Text(project.employeeName.employeeName),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProjectTaskListPage(
                            projectId: project.projectId.toString(),
                          ),
                        ),
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width * 0.9,
              child: ListView.separated(
                // itemCount: listProject2 != null ? listProject2.length : 0,
                itemCount: searchDoneResults.isNotEmpty ? searchDoneResults.length : listProject2.length,
                itemBuilder: (context, index) {
                  final Project project = searchDoneResults.isNotEmpty ? searchDoneResults[index] : listProject2[index];
                  DateTime assignDate = DateTime.parse(project.projectDate);
                  DateTime deadline = DateTime.parse(project.projectDeadline);
                  String formattedAssignDate = DateFormat('dd-MM-yyyy').format(assignDate);
                  String formattedAssignTime = DateFormat('HH:mm:ss').format(assignDate);
                  String formattedDateline = DateFormat('dd-MM-yyyy').format(deadline);
                  String formattedDeadlineTime = DateFormat('HH:mm:ss').format(deadline);
                  return ListTile(
                    isThreeLine: true,
                    shape: Border(left: BorderSide(color: Colors.green, width: 5)),
                    title: Text(
                      // listProject2[index].projectName,
                      project.projectName,
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
                            Flexible(
                              child: Text(
                                project.projectDescription,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.account_circle, color: Colors.blue[600]),
                            SizedBox(width: 6),
                            Flexible(
                              child: Text(project.employeeName.employeeName),
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProjectTaskListPage(
                                // projectId: listProject2[index].projectId.toString(),
                                projectId: project.projectId.toString(),
                              )));
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
