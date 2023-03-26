import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:task_management/model/model.dart';
import 'package:task_management/model/repo.dart';

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

  getData() async {
    activeTask = await active.getData();
    pendingTask = await pending.getData();
    doneTask = await done.getData();
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
          title: const Text('Daftar Tugas'),
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
                        activeTask[index].nama_tugas,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            activeTask[index].deskripsi_tugas,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(Icons.account_circle),
                              SizedBox(width: 6),
                              Text(
                                activeTask[index].nama_pegawai,
                              ),
                            ],
                          )
                        ],
                      ));
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: activeTask.length),
            ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                      isThreeLine: true,
                      shape: Border(
                          left: BorderSide(color: Colors.yellow, width: 5)),
                      title: Text(
                        pendingTask[index].nama_tugas,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            pendingTask[index].deskripsi_tugas,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(Icons.account_circle),
                              SizedBox(width: 6),
                              Text(
                                pendingTask[index].nama_pegawai,
                              ),
                            ],
                          )
                        ],
                      ));
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: pendingTask.length),
            ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                      isThreeLine: true,
                      shape: Border(
                          left: BorderSide(color: Colors.green, width: 5)),
                      title: Text(
                        doneTask[index].nama_tugas,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            doneTask[index].deskripsi_tugas,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(Icons.account_circle),
                              SizedBox(width: 6),
                              Text(
                                doneTask[index].nama_pegawai,
                              ),
                            ],
                          )
                        ],
                      ));
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: doneTask.length),
          ],
        ),
      ),
    );
  }
}
