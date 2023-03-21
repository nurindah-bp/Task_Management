import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ProjectListPage extends StatefulWidget {
  const ProjectListPage({super.key});

  @override
  State<ProjectListPage> createState() => _ProjectListPageState();
}

class _ProjectListPageState extends State<ProjectListPage> {
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
        body: new TabBarView(
          children: <Widget>[
            new ListView(
              padding: const EdgeInsets.all(8),
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 3, horizontal: 10.0),
                  height: 50,
                  color: Colors.amber[600],
                  child: const Center(child: Text('Entry A')),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 3, horizontal: 10.0),
                  height: 50,
                  color: Colors.amber[500],
                  child: const Center(child: Text('Entry B')),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 3, horizontal: 10.0),
                  height: 50,
                  color: Colors.amber[100],
                  child: const Center(child: Text('Entry C')),
                ),
              ],
            ),
            new ListView(
              padding: const EdgeInsets.all(8),
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 3, horizontal: 10.0),
                  height: 50,
                  color: Colors.amber[600],
                  child: const Center(child: Text('Entry A')),
                ),
              ],
            ),
            new ListView(
              padding: const EdgeInsets.all(8),
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 3, horizontal: 10.0),
                  height: 50,
                  color: Colors.amber[600],
                  child: const Center(child: Text('Entry A')),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 3, horizontal: 10.0),
                  height: 50,
                  color: Colors.amber[500],
                  child: const Center(child: Text('Entry B')),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 3, horizontal: 10.0),
                  height: 50,
                  color: Colors.amber[100],
                  child: const Center(child: Text('Entry C')),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 3, horizontal: 10.0),
                  height: 50,
                  color: Colors.amber[600],
                  child: const Center(child: Text('Entry A')),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
