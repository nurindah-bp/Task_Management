import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/controllers/project_controller.dart';
import 'package:task_management/views/project/projectlistpage.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({super.key});

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  final ProjectController projectController = Get.find<ProjectController>();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    if (projectController.divisons.isEmpty) {
      await projectController.getDivisions();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project'),
      ),
      body: Obx(
        () => GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: projectController.divisons.length,
          itemBuilder: (context, index) {
            final item = projectController.divisons[index];
            return Card(
              margin: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.blueAccent,
                  ),
                  borderRadius: BorderRadius.circular(15.0)),
              child: InkWell(
                onTap: () {
                  Get.to(() => ProjectListPage(projectDivId: item.divisionId.toString()));
                },
                splashColor: Colors.blue,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(item.divisionName),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
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
