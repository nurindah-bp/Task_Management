import 'dart:convert';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task_management/utils/endpoint.dart';
import 'package:task_management/utils/endpoint.dart';
import 'package:task_management/utils/session_manager.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  String _sessionId = '';
  List _data = [];
  int _pic = 1;

  TextEditingController taskName = TextEditingController();
  TextEditingController taskDesc = TextEditingController();
  DateTime? selectedDate;

  @override
  void initState() {
    SessionManager.getSession().then((value) {
      setState(() {
        _sessionId = value.split('-')[0];
      });
    });
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('${Endpoint.baseUrl}/employee/'));
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
        title: Text("Tambah Tugas"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Container(
              child: TextField(
                controller: taskName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  labelText: 'Nama Tugas',
                  hintText: 'Nama Tugas',
                ),
                autofocus: false,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 150,
              child: TextField(
                controller: taskDesc,
                maxLines: null,
                expands: true,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  labelText: 'Detail Tugas',
                  hintText: 'Detail Tugas',
                ),
                autofocus: false,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: DropdownButton(
                  items: _data.map((e) {
                    return DropdownMenuItem(
                      child: Text(e["employee_name"]),
                      value: e["employee_id"],
                    );
                  }).toList(),
                  hint: Text("Pilih PIC"),
                  value: _pic,
                  onChanged: (v) {
                    _pic = v as int;
                    setState(() {});
                  }),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: DateTimeField(
                decoration: const InputDecoration(hintText: 'Deadline'),
                selectedDate: selectedDate,
                onDateSelected: (DateTime value) {
                  setState(() {
                    selectedDate = value;
                  });
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            // Container(
            //   child: Row(
            //     children: [
            //       Checkbox(
            //         value: this._urgent,
            //         onChanged: (bool? value) {
            //           setState(() {
            //             _urgent = value!;
            //           });
            //           if (_urgent) {
            //             urgentval = '1';
            //           }
            //         },
            //       ),
            //       Text("Urgent"),
            //     ],
            //   ),
            // ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              width: MediaQuery.of(context).size.width,
              child: MaterialButton(
                onPressed: () async {
                  var myResponse = await http.post(
                    Uri.parse('${Endpoint.baseUrl}/task/addTask'),
                    body: {
                      'taskName': taskName.text,
                      'taskDesc': taskDesc.text,
                      'taskPIC': _pic.toString(),
                      'taskDeadline': selectedDate.toString(),
                      'taskUrgent': '0',
                      'userID': _sessionId,
                    },
                  );
                  print(myResponse.body);
                  setState(() {
                    taskName.clear();
                    taskDesc.clear();
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Sukses Tambah Tugas'),
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
          ],
        ),
      ),
    );
  }
}
