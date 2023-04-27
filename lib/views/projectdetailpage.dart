import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:task_management/model/model.dart';
import 'package:task_management/model/repo.dart';

class ProjectDetailPage extends StatefulWidget {
  const ProjectDetailPage({super.key});

  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  List<ProjectTask> detilTask = [];
  List<TaskProgress> progressTask = [];
  projecttaskDetil detail = projecttaskDetil();
  projecttaskProgress progress = projecttaskProgress();

  getData() async {
    detilTask = await detail.getData();
    progressTask = await progress.getData();
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Tugas'),
      ),
      body: Row(
        children: <Widget>[
          Expanded(
            child: SizedBox(
                height: 200.0,
                child: new ListView.separated(
                    itemBuilder: (context, index) {
                      return ListTile(
                        shape: Border(
                          left: BorderSide(color: Colors.red, width: 5),
                        ),
                        title: Text(
                          progressTask[index].progres_tugas,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 6,
                            ),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.calendar_today_rounded,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  progressTask[index].tgl_progres,
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Icon(Icons.download),
                                SizedBox(width: 10),
                                Text("Lampiran"),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    itemCount: progressTask.length)),
          ),
        ],
      ),
    );
  }
}
