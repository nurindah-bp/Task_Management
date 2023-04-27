import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:task_management/views/projectdetailpage.dart';

import '../model/model.dart';
import '../model/repo.dart';

class ProjectTaskPage extends StatefulWidget {
  const ProjectTaskPage(String params, {super.key});

  @override
  State<ProjectTaskPage> createState() => _ProjectTaskPageState();
}

class _ProjectTaskPageState extends State<ProjectTaskPage> {
  List<ProjectTask> activeProjectTask = [];
  List<ProjectTask> pendingProjectTask = [];
  List<ProjectTask> doneProjectTask = [];
  activeProjectTaskRepo active = activeProjectTaskRepo();
  pendingProjectTaskRepo pending = pendingProjectTaskRepo();
  doneProjectTaskRepo done = doneProjectTaskRepo();

  getData() async {
    activeProjectTask = await active.getData();
    pendingProjectTask = await pending.getData();
    doneProjectTask = await done.getData();
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
                      activeProjectTask[index].nama_tugas,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          activeProjectTask[index].deskripsi_tugas,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.account_circle),
                            SizedBox(width: 6),
                            Text(
                              activeProjectTask[index].nama_pegawai,
                            ),
                          ],
                        )
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProjectDetailPage()));
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
                        pendingProjectTask[index].nama_tugas,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            pendingProjectTask[index].deskripsi_tugas,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(Icons.account_circle),
                              SizedBox(width: 6),
                              Text(
                                pendingProjectTask[index].nama_pegawai,
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
                        doneProjectTask[index].nama_tugas,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            doneProjectTask[index].deskripsi_tugas,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(Icons.account_circle),
                              SizedBox(width: 6),
                              Text(
                                doneProjectTask[index].nama_pegawai,
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
