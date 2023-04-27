import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:task_management/model/repo.dart';
import 'package:task_management/model/model.dart';
import 'package:task_management/views/addproject.dart';
import 'package:task_management/views/homepage.dart';
import 'package:task_management/views/projecttaskpage.dart';

class ProjectListPage extends StatefulWidget {
  const ProjectListPage({super.key});

  @override
  State<ProjectListPage> createState() => _ProjectListPageState();
}

class _ProjectListPageState extends State<ProjectListPage> {
  List<Project> listProject = [];
  List<Project> listProject2 = [];
  List<Project> listProject3 = [];
  projectListRepo repository = projectListRepo();
  projectListRepo2 repository2 = projectListRepo2();
  projectListRepo3 repository3 = projectListRepo3();

  getData() async {
    listProject = await repository.getData();
    listProject2 = await repository2.getData();
    listProject3 = await repository3.getData();
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
          title: const Text('Daftar Project'),
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
                  MaterialPageRoute(builder: (context) => const AddProject()),
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
                // final int params = listProject[index].id_proyek;
                return ListTile(
                  isThreeLine: true,
                  shape: Border(left: BorderSide(color: Colors.red, width: 5)),
                  title: Text(
                    listProject[index].nama_proyek,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        listProject[index].deskripsi_proyek,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(Icons.account_circle),
                          SizedBox(width: 6),
                          Text(
                            listProject[index].nama_pegawai,
                          ),
                        ],
                      )
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProjectTaskPage(
                                listProject[index].nama_pegawai)));
                  },
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: listProject.length,
            ),
            ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                    isThreeLine: true,
                    shape: Border(
                        left: BorderSide(color: Colors.yellow, width: 5)),
                    title: Text(
                      listProject3[index].nama_proyek,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          listProject3[index].deskripsi_proyek,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.account_circle),
                            SizedBox(width: 6),
                            Text(
                              listProject3[index].nama_pegawai,
                            ),
                          ],
                        )
                      ],
                    ));
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: listProject3.length,
            ),
            ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                    isThreeLine: true,
                    shape:
                        Border(left: BorderSide(color: Colors.green, width: 5)),
                    title: Text(
                      listProject2[index].nama_proyek,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          listProject2[index].deskripsi_proyek,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.account_circle),
                            SizedBox(width: 6),
                            Text(
                              listProject2[index].nama_pegawai,
                            ),
                          ],
                        )
                      ],
                    ));
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: listProject2.length,
            ),
          ],
        ),
      ),
      //   body: new TabBarView(
      //     children: <Widget>[
      //       new ListView(
      //         padding: const EdgeInsets.all(8),
      //         children: <Widget>[
      //           Container(
      //             margin: EdgeInsets.symmetric(vertical: 3, horizontal: 10.0),
      //             height: 50,
      //             color: Colors.amber[600],
      //             child: const Center(child: Text('Entry A')),
      //           ),
      //           Container(
      //             margin: EdgeInsets.symmetric(vertical: 3, horizontal: 10.0),
      //             height: 50,
      //             color: Colors.amber[500],
      //             child: const Center(child: Text('Entry B')),
      //           ),
      //           Container(
      //             margin: EdgeInsets.symmetric(vertical: 3, horizontal: 10.0),
      //             height: 50,
      //             color: Colors.amber[100],
      //             child: const Center(child: Text('Entry C')),
      //           ),
      //         ],
      //       ),
      //       new ListView(
      //         padding: const EdgeInsets.all(8),
      //         children: <Widget>[
      //           Container(
      //             margin: EdgeInsets.symmetric(vertical: 3, horizontal: 10.0),
      //             height: 50,
      //             color: Colors.amber[600],
      //             child: const Center(child: Text('Entry A')),
      //           ),
      //         ],
      //       ),
      //       new ListView(
      //         padding: const EdgeInsets.all(8),
      //         children: <Widget>[
      //           Container(
      //             margin: EdgeInsets.symmetric(vertical: 3, horizontal: 10.0),
      //             height: 50,
      //             color: Colors.amber[600],
      //             child: const Center(child: Text('Entry A')),
      //           ),
      //           Container(
      //             margin: EdgeInsets.symmetric(vertical: 3, horizontal: 10.0),
      //             height: 50,
      //             color: Colors.amber[500],
      //             child: const Center(child: Text('Entry B')),
      //           ),
      //           Container(
      //             margin: EdgeInsets.symmetric(vertical: 3, horizontal: 10.0),
      //             height: 50,
      //             color: Colors.amber[100],
      //             child: const Center(child: Text('Entry C')),
      //           ),
      //           Container(
      //             margin: EdgeInsets.symmetric(vertical: 3, horizontal: 10.0),
      //             height: 50,
      //             color: Colors.amber[600],
      //             child: const Center(child: Text('Entry A')),
      //           ),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
