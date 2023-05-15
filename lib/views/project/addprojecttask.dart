import 'dart:convert';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../model/utils.dart';

class AddProjectTask extends StatefulWidget {
  const AddProjectTask({super.key});

  @override
  State<AddProjectTask> createState() => _AddProjectTaskState();
}

class _AddProjectTaskState extends State<AddProjectTask> {
  String _sessionId = '';
  List _data = [];
  List _dataProject = [];
  int _pic = 1;
  int _project = 1;
  // bool _urgent = false;
  // late String urgentval;

  TextEditingController pTaskName = TextEditingController();
  TextEditingController pTaskDesc = TextEditingController();
  DateTime? selectedDate;

  @override
  void initState() {
    SessionManager.getSession().then((value) {
      setState(() {
        _sessionId = value.split('-')[0];
      });
    });
    super.initState();
    fetchDataProject();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('${Utils.baseUrl}/employee/'));
    if (response.statusCode == 200) {
      setState(() {
        _data = json.decode(response.body);
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Future<void> fetchDataProject() async {
    final response = await http.get(Uri.parse('${Utils.baseUrl}/project/'));
    if (response.statusCode == 200) {
      setState(() {
        _dataProject = json.decode(response.body);
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Tugas Proyek"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Container(
              child: DropdownButton(
                items: _dataProject.map((e) {
                  return DropdownMenuItem(
                    child: Text(e["project_name"]),
                    value: e["project_id"],
                  );
                }).toList(),
                hint: Text("Pilih Proyek"),
                value: _project,
                onChanged: (v) {
                  _project = v as int;
                  setState(() {});
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: TextField(
                controller: pTaskName,
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
                controller: pTaskDesc,
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
                hint: Text("Pilih PIC"),
                items: _data.map((e) {
                  return DropdownMenuItem(
                    child: Text(e["employee_name"]),
                    value: e["employee_id"],
                  );
                }).toList(),
                value: _pic,
                onChanged: (v) {
                  _pic = v as int;
                  setState(() {});
                },
              ),
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
                    Uri.parse('${Utils.baseUrl}/project/addProjTask'),
                    body: {
                      'projTaskName': pTaskName.text,
                      'projTaskDesc': pTaskDesc.text,
                      'projID': _project.toString(),
                      'projTaskPIC': _pic.toString(),
                      'projTaskDeadline': selectedDate.toString(),
                      'projTaskUrgent': '0',
                      'userID': _sessionId,
                    },
                  );
                  print(myResponse.body);
                  setState(() {
                    pTaskName.clear();
                    pTaskDesc.clear();
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Sukses Tambah Tugas Proyek'),
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
