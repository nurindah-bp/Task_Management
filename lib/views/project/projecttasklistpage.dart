import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:task_management/controllers/auth_controller.dart';
import 'package:task_management/models/project_task.dart';
import 'package:task_management/views/project/addprojecttask.dart';
import 'package:task_management/views/project/projecttaskprogresspage.dart';

import '../../model/repo.dart';

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
    setState(() {});
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
      pTask.employeeName.employeeName.toLowerCase().contains(searchText.toLowerCase()) || pTask.ptaskName.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
      searchPendingResults = pendingProjectTask
          .where((pTask) =>
      pTask.employeeName.employeeName.toLowerCase().contains(searchText.toLowerCase()) || pTask.ptaskName.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
      searchDoneResults = doneProjectTask
          .where((pTask) =>
      pTask.employeeName.employeeName.toLowerCase().contains(searchText.toLowerCase()) || pTask.ptaskName.toLowerCase().contains(searchText.toLowerCase()))
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
                itemCount: searchResults.isNotEmpty ? searchResults.length : activeProjectTask.length,
                itemBuilder: (context, index) {
                  final ProjectTask pTask = searchResults.isNotEmpty ? searchResults[index] : activeProjectTask[index];
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
                        Text(
                          // activeProjectTask[index].ptaskDescription,
                          pTask.ptaskDescription,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.account_circle),
                            SizedBox(width: 6),
                            Text(
                              // activeProjectTask[index].employeeName.employeeName,
                              pTask.employeeName.employeeName,
                            ),
                          ],
                        )
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
            ListView.separated(
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
                          Text(
                            // pendingProjectTask[index].ptaskDescription,
                            pTask.ptaskDescription,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(Icons.account_circle),
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
            ListView.separated(
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
                          Text(
                            // doneProjectTask[index].ptaskDescription,
                            pTask.ptaskDescription,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(Icons.account_circle),
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
          ],
        ),
      ),
    );
  }
}
