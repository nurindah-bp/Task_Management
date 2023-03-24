import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:task_management/model/repo.dart';
import 'package:task_management/model/model.dart';

class ProjectListPage extends StatefulWidget {
  const ProjectListPage({super.key});

  @override
  State<ProjectListPage> createState() => _ProjectListPageState();
}

class _ProjectListPageState extends State<ProjectListPage> {
  List<Project> listProject = [];
  projectListRepo repository = projectListRepo();

  getData() async {
    listProject = await repository.getData();
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
        body: ListView.separated(
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 3, horizontal: 10.0),
                      height: 25,
                      child: Text(
                        listProject[index].nama_proyek,
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    Text(listProject[index].deskripsi_proyek)
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount: listProject.length),
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
