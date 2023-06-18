import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:task_management/model/repo.dart';
import 'package:task_management/models/task.dart';
import 'package:task_management/views/task/addtask.dart';
import 'package:task_management/views/task/tasklistprogress.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
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
    activeTask = await active.getData();
      pendingTask = await pending.getData();
      doneTask = await done.getData();
      setState(() {});
    loading = true;
  }

  List<Task> searchResults = [];

  Future<void> getTasks(String searchText) async {
    // print("GET DATA LIST PROJECT");
    activeTask = await active.getData();
    pendingTask = await pending.getData();
    doneTask = await done.getData();

    if (searchText.isNotEmpty) {
      searchResults = activeTask
          .where((task) =>
      task.employeeName.employeeName.toLowerCase().contains(searchText.toLowerCase()) || task.taskName.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    } else {
      searchResults = [];
    }

    if (searchText.isNotEmpty) {
      searchResults = pendingTask
          .where((task) =>
      task.employeeName.employeeName.toLowerCase().contains(searchText.toLowerCase()) || task.taskName.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    } else {
      searchResults = [];
    }

    if (searchText.isNotEmpty) {
      searchResults = doneTask
          .where((task) =>
      task.employeeName.employeeName.toLowerCase().contains(searchText.toLowerCase()) || task.taskName.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    } else {
      searchResults = [];
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
                  return ListTile(
                    isThreeLine: true,
                    shape:
                        Border(left: BorderSide(color: Colors.red, width: 5)),
                    title: Text(
                      // activeTask[index].taskName,
                      task.taskName,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          // activeTask[index].taskDescription,
                          task.taskDescription,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.account_circle),
                            SizedBox(width: 6),
                            Text(
                              activeTask[index].employeeName.employeeName,
                            ),
                          ],
                        )
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TaskListProgress(
                                  taskId: activeTask[index].taskId)));
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                // itemCount: activeTask.length
            ),
            ListView.separated(
                itemCount: searchResults.isNotEmpty ? searchResults.length : pendingTask.length,
                itemBuilder: (context, index) {
                  final Task task = searchResults.isNotEmpty ? searchResults[index] : pendingTask[index];
                  return ListTile(
                      isThreeLine: true,
                      shape: Border(
                          left: BorderSide(color: Colors.yellow, width: 5)),
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
                          Text(
                            // pendingTask[index].taskDescription,
                            task.taskDescription,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(Icons.account_circle),
                              SizedBox(width: 6),
                              Text(
                                pendingTask[index].employeeName.employeeName,
                              ),
                            ],
                          )
                        ],
                      ));
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                // itemCount: pendingTask.length
            ),
            ListView.separated(
                itemCount: searchResults.isNotEmpty ? searchResults.length : doneTask.length,
                itemBuilder: (context, index) {
                  final Task task = searchResults.isNotEmpty ? searchResults[index] : doneTask[index];
                  return ListTile(
                      isThreeLine: true,
                      shape: Border(
                          left: BorderSide(color: Colors.green, width: 5)),
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
                          Text(
                            // doneTask[index].taskDescription,
                            task.taskDescription,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(Icons.account_circle),
                              SizedBox(width: 6),
                              Text(
                                doneTask[index].employeeName.employeeName,
                              ),
                            ],
                          )
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
