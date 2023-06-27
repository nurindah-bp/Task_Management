import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:task_management/model/repo.dart';
import 'package:http/http.dart' as http;
import 'package:task_management/models/project_task.dart';
import 'package:task_management/models/project_task_progress.dart';
import 'package:task_management/utils/endpoint.dart';
import 'package:task_management/views/project/updateprojecttask.dart';

class projecttaskprogresspage extends StatefulWidget {
  final String projectTaskId;
  const projecttaskprogresspage({Key? key, required this.projectTaskId})
      : super(key: key);

  @override
  State<projecttaskprogresspage> createState() =>
      _projecttaskprogresspageState();
}

class Item {
  int id;
  String name;

  Item({required this.id, required this.name});
}

class _projecttaskprogresspageState extends State<projecttaskprogresspage> {
  TextEditingController ptaskProgress = TextEditingController();
  TextEditingController ptaskNote = TextEditingController();
  Item? _selectedItem;
  List<Item> ptaskStatus = [
    Item(id: 1, name: 'Proses'),
    Item(id: 3, name: 'Pending'),
    Item(id: 2, name: 'Selesai'),
  ];
  int _status = 1;

  List<ProjectTask> detilTask = [];
  List<ProjectTaskProgress> progressTask = [];
  projecttaskDetil detail = projecttaskDetil();
  projecttaskProgress progress = projecttaskProgress();

  // getData() async {
  Future<void> getData() async {
    detilTask = await detail.getData(widget.projectTaskId);
    progressTask = await progress.getData(widget.projectTaskId);
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    stopTimer(); // Stop the timer when the widget is disposed
    super.dispose();
  }

  Timer? timer;

  void startTimer() {
    const duration = Duration(seconds: 2); // Set the duration for auto-reload
    timer = Timer.periodic(duration, (Timer t) {
      getData(); // Trigger data retrieval and update
    });
  }

  void stopTimer() {
    timer?.cancel(); // Cancel the timer if it is running
  }

  @override
  Widget build(BuildContext context) {
    String projTaskId = widget.projectTaskId;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Detail Tugas Proyek'),
          automaticallyImplyLeading: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.edit_note_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UpdateProjectTask(
                            projectTaskId: projTaskId,
                          )),
                );
              },
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(
                height: 100,
                child: TextField(
                  controller: ptaskProgress,
                  maxLines: null,
                  expands: true,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    labelText: 'Progres Pengerjaan',
                    hintText: 'Progres Pengerjaan',
                  ),
                  autofocus: false,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: TextField(
                  controller: ptaskNote,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    labelText: 'Catatan',
                    hintText: 'Catatan',
                  ),
                  autofocus: false,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: DropdownButton(
                    hint: Text("Pilih Status"),
                    value: _status,
                    items: ptaskStatus.map((item) {
                      return DropdownMenuItem(
                        child: Text(item.name),
                        value: item.id,
                      );
                    }).toList(),
                    onChanged: (v) {
                      _status = v as int;
                      setState(() {});
                    }),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width,
                child: MaterialButton(
                  onPressed: () async {
                    var myResponse = await http.post(
                      Uri.parse('${Endpoint.baseUrl}/project/addProjTaskProgress'),
                      body: {
                        'projTaskProgress': ptaskProgress.text,
                        'projTaskProgressNote': ptaskNote.text,
                        'projTaskID': projTaskId,
                        'projTaskProgressStatus': _status.toString(),
                        // 'projDeadline': selectedDate.toString(),
                        // 'userID': '1',
                      },
                    );
                    print(myResponse.body);
                    setState(() {
                      ptaskProgress.clear();
                      ptaskNote.clear();
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Progres Tercatat'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  child: const Text(
                    "Simpan",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  // color: const Color(0xFFF58634),
                  color: Colors.lightBlueAccent,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  padding: const EdgeInsets.all(16),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: progressTask.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(),
                  itemBuilder: (BuildContext context, index) {
                    final colorLabel =
                        (progressTask[index].ptask_progressstatus == '0' ||
                                progressTask[index].ptask_progressstatus == '1')
                            ? Colors.red
                            : progressTask[index].ptask_progressstatus == '2'
                                ? Colors.green
                                : Colors.yellow;
                    DateTime assignDate = DateTime.parse(progressTask[index].ptask_progressdate);
                    String formattedAssignDate = DateFormat('dd-MM-yyyy').format(assignDate);
                    String formattedAssignTime = DateFormat('HH:mm:ss').format(assignDate);
                    return ListTile(
                      shape: Border(
                        left: BorderSide(color: colorLabel, width: 5),
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
                            children: [
                              Icon(
                                Icons.note_alt_outlined,
                                color: Colors.blue[600],
                              ),
                              SizedBox(width: 6),
                              Text(
                                // pendingProjectTask[index].ptaskDescription,
                                progressTask[index].ptask_progressnote,
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.calendar_today_rounded, color: Colors.blue[600]
                              ),
                              SizedBox(width: 10),
                              Text(
                                formattedAssignDate,
                              ),
                              Text(
                                " " + formattedAssignTime,
                              ),
                            ],
                          ),
                          // Row(
                          //   children: <Widget>[
                          //     Icon(Icons.download),
                          //     SizedBox(width: 10),
                          //     Text("Lampiran"),
                          //   ],
                          // )
                        ],
                      ),
                    );
                    // Divider(color: Colors.grey);
                  },
                ),
              ),
            ],
          ),
        )
        // body: Row(
        //   children: <Widget>[
        //     Expanded(
        //       child: SizedBox(
        //           height: 200.0,
        //           child: new ListView.separated(
        //               itemBuilder: (context, index) {
        //                 return ListTile(
        //                   shape: Border(
        //                     left: BorderSide(color: Colors.red, width: 5),
        //                   ),
        //                   title: Text(
        //                     progressTask[index].ptask_progress,
        //                     style: TextStyle(fontWeight: FontWeight.bold),
        //                   ),
        //                   subtitle: Column(
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     children: <Widget>[
        //                       SizedBox(
        //                         height: 6,
        //                       ),
        //                       Row(
        //                         children: <Widget>[
        //                           Icon(
        //                             Icons.calendar_today_rounded,
        //                           ),
        //                           SizedBox(width: 10),
        //                           Text(
        //                             progressTask[index].ptask_progressdate,
        //                           ),
        //                         ],
        //                       ),
        //                       Row(
        //                         children: <Widget>[
        //                           Icon(Icons.download),
        //                           SizedBox(width: 10),
        //                           Text("Lampiran"),
        //                         ],
        //                       )
        //                     ],
        //                   ),
        //                 );
        //               },
        //               separatorBuilder: (context, index) {
        //                 return Divider();
        //               },
        //               itemCount: progressTask.length)),
        //     ),
        //   ],
        // ),
        );
  }
}
