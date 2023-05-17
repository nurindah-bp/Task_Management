import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:task_management/model/repo.dart';
import 'package:task_management/models/task.dart';
import 'package:task_management/models/task_progress.dart';
import 'package:task_management/utils/endpoint.dart';
import 'package:task_management/views/task/updatetask.dart';

class TaskListProgress extends StatefulWidget {
  final taskId;
  const TaskListProgress({Key? key, required this.taskId}) : super(key: key);

  @override
  State<TaskListProgress> createState() => _TaskListProgressState();
}

class Item {
  int id;
  String name;

  Item({required this.id, required this.name});
}

class _TaskListProgressState extends State<TaskListProgress> {
  TextEditingController ctaskProgress = TextEditingController();
  TextEditingController ctaskNote = TextEditingController();
  Item? _selectedItem;
  List<Item> ptaskStatus = [
    Item(id: 1, name: 'Proses'),
    Item(id: 3, name: 'Pending'),
    Item(id: 2, name: 'Selesai'),
  ];
  int _status = 1;

  List<Task> detilTask = [];
  List<TaskProgress> progressTask = [];
  taskDetil detail = taskDetil();
  taskProgress progress = taskProgress();

  getData() async {
    detilTask = await detail.getData(widget.taskId);
    progressTask = await progress.getData(widget.taskId);
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String taskId = widget.taskId;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Tugas'),
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
                    builder: (context) => UpdateTask(taskId: taskId)),
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
                controller: ctaskProgress,
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
                controller: ctaskNote,
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
                    Uri.parse('${Endpoint.baseUrl}/task/addTaskProgress'),
                    body: {
                      'taskProgress': ctaskProgress.text,
                      'taskProgressNote': ctaskNote.text,
                      'taskID': taskId,
                      'taskProgressStatus': _status.toString(),
                      // 'projDeadline': selectedDate.toString(),
                      // 'userID': '1',
                    },
                  );
                  print(myResponse.body);
                  setState(() {
                    ctaskProgress.clear();
                    ctaskNote.clear();
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
                      (progressTask[index].taskProgressstatus == '0' ||
                              progressTask[index].taskProgressstatus == '1')
                          ? Colors.red
                          : progressTask[index].taskProgressstatus == '2'
                              ? Colors.green
                              : Colors.yellow;
                  return ListTile(
                    shape: Border(
                      left: BorderSide(color: colorLabel, width: 5),
                    ),
                    title: Text(
                      progressTask[index].taskProgress,
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
                              progressTask[index].taskProgressdate,
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
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
