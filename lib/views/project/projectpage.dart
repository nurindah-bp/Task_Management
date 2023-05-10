import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task_management/views/project/projectlistpage.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({super.key});

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  List<dynamic> _data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:3000/employee/division'));
    if (response.statusCode == 200) {
      setState(() {
        _data = json.decode(response.body);
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: _data.length,
        itemBuilder: (context, index) {
          final item = _data[index];
          return Container(
            child: Card(
              margin: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.blueAccent,
                  ),
                  borderRadius: BorderRadius.circular(15.0)),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProjectListPage()));
                },
                splashColor: Colors.blue,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(item['division_name']),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      // ListView.builder(
      //   itemCount: _data.length,
      //   itemBuilder: (BuildContext context, int index) {
      //     final item = _data[index];
      //     return ListTile(
      //       leading: Icon(Icons.person),
      //       title: Text(item['nama_bidang']),
      //     );
      //   },
      // ),

      // body: GridView.count(
      //   padding: const EdgeInsets.all(25),
      //   crossAxisCount: 2,
      //   children: <Widget>[
      //     Card(
      //       margin: const EdgeInsets.all(10),
      //       shape: RoundedRectangleBorder(
      //           side: BorderSide(
      //             color: Colors.blueAccent,
      //           ),
      //           borderRadius: BorderRadius.circular(15.0)),
      //       child: InkWell(
      //         onTap: () {
      //           Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                   builder: (context) => const ProjectListPage()));
      //         },
      //         splashColor: Colors.blue,
      //         child: Center(
      //           child: Column(
      //             mainAxisSize: MainAxisSize.min,
      //             children: const <Widget>[
      //               Text("Bidang Kesiswaan",
      //                   style: TextStyle(fontSize: 17.0)),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),
      //     Card(
      //       margin: const EdgeInsets.all(10),
      //       shape: RoundedRectangleBorder(
      //           side: BorderSide(
      //             color: Colors.blueAccent,
      //           ),
      //           borderRadius: BorderRadius.circular(15.0)),
      //       child: InkWell(
      //         onTap: () {},
      //         splashColor: Colors.blue,
      //         child: Center(
      //           child: Column(
      //             mainAxisSize: MainAxisSize.min,
      //             children: const <Widget>[
      //               Text("Bidang Kurikulum",
      //                   style: TextStyle(fontSize: 17.0)),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),
      //     Card(
      //       margin: const EdgeInsets.all(10),
      //       shape: RoundedRectangleBorder(
      //           side: BorderSide(
      //             color: Colors.blueAccent,
      //           ),
      //           borderRadius: BorderRadius.circular(15.0)),
      //       child: InkWell(
      //         onTap: () {},
      //         splashColor: Colors.blue,
      //         child: Center(
      //           child: Column(
      //             mainAxisSize: MainAxisSize.min,
      //             children: const <Widget>[
      //               Text("Bidang Humas", style: TextStyle(fontSize: 17.0)),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),
      //     Card(
      //       margin: const EdgeInsets.all(10),
      //       shape: RoundedRectangleBorder(
      //           side: BorderSide(
      //             color: Colors.blueAccent,
      //           ),
      //           borderRadius: BorderRadius.circular(15.0)),
      //       child: InkWell(
      //         onTap: () {},
      //         splashColor: Colors.blue,
      //         child: Center(
      //           child: Column(
      //             mainAxisSize: MainAxisSize.min,
      //             children: const <Widget>[
      //               Text("Bidang Sarpras", style: TextStyle(fontSize: 17.0)),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // )
    );
  }
}
