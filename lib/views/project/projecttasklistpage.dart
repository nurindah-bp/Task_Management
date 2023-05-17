import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:task_management/models/project_task.dart';
import 'package:task_management/views/project/addprojecttask.dart';
import 'package:task_management/views/project/projecttaskprogresspage.dart';

import '../../model/repo.dart';

class ProjectTaskListPage extends StatefulWidget {
  // // const ProjectTaskListPage(String params, {super.key});
  final String projectId;
  const ProjectTaskListPage({Key? key, required this.projectId})
      : super(key: key);

  @override
  State<ProjectTaskListPage> createState() => _ProjectTaskListPageState();
}

class _ProjectTaskListPageState extends State<ProjectTaskListPage> {
  List<ProjectTask> activeProjectTask = [];
  List<ProjectTask> pendingProjectTask = [];
  List<ProjectTask> doneProjectTask = [];
  activeProjectTaskRepo active = activeProjectTaskRepo();
  pendingProjectTaskRepo pending = pendingProjectTaskRepo();
  doneProjectTaskRepo done = doneProjectTaskRepo();

  getData() async {
    activeProjectTask = await active.getData(widget.projectId);
    pendingProjectTask = await pending.getData(widget.projectId);
    doneProjectTask = await done.getData(widget.projectId);
    setState(() {});
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
          title: const Text('Daftar Tugas Proyek'),
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
                  MaterialPageRoute(
                      builder: (context) => const AddProjectTask()),
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
                itemBuilder: (context, index) {
                  return ListTile(
                    isThreeLine: true,
                    shape:
                        Border(left: BorderSide(color: Colors.red, width: 5)),
                    title: Text(
                      activeProjectTask[index].ptaskName,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          activeProjectTask[index].ptaskDescription,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.account_circle),
                            SizedBox(width: 6),
                            Text(
                              activeProjectTask[index]
                                  .employeeName
                                  .employeeName,
                            ),
                          ],
                        )
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => projecttaskprogresspage(
                                  projectTaskId:
                                      activeProjectTask[index].ptaskId)));
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: activeProjectTask.length),
            ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                      isThreeLine: true,
                      shape: Border(
                          left: BorderSide(color: Colors.yellow, width: 5)),
                      title: Text(
                        pendingProjectTask[index].ptaskName,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            pendingProjectTask[index].ptaskDescription,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(Icons.account_circle),
                              SizedBox(width: 6),
                              Text(
                                pendingProjectTask[index]
                                    .employeeName
                                    .employeeName,
                              ),
                            ],
                          )
                        ],
                      ));
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: pendingProjectTask.length),
            ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                      isThreeLine: true,
                      shape: Border(
                          left: BorderSide(color: Colors.green, width: 5)),
                      title: Text(
                        doneProjectTask[index].ptaskName,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            doneProjectTask[index].ptaskDescription,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(Icons.account_circle),
                              SizedBox(width: 6),
                              Text(
                                doneProjectTask[index]
                                    .employeeName
                                    .employeeName,
                              ),
                            ],
                          )
                        ],
                      ));
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: doneProjectTask.length),
          ],
        ),
      ),
    );
  }
}
