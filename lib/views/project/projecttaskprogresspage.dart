import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:task_management/model/model.dart';
import 'package:task_management/model/repo.dart';

class projecttaskprogresspage extends StatefulWidget {
  const projecttaskprogresspage({super.key});

  @override
  State<projecttaskprogresspage> createState() =>
      _projecttaskprogresspageState();
}

class _projecttaskprogresspageState extends State<projecttaskprogresspage> {
  List<ProjectTask> detilTask = [];
  List<ProjectTaskProgress> progressTask = [];
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
        title: const Text('Detail Proyek Tugas'),
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
                          progressTask[index].ptask_progress,
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
                                  progressTask[index].ptask_progressdate,
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
