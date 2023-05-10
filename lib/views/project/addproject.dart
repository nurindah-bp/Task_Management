import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:date_field/date_field.dart';
import '../../model/utils.dart';

class AddProject extends StatefulWidget {
  const AddProject({super.key});

  @override
  State<AddProject> createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProject> {
  List _data = [];
  int _value = 1;

  TextEditingController pName = TextEditingController();
  TextEditingController pDesc = TextEditingController();
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Proyek"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Container(
              child: TextField(
                controller: pName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  labelText: 'Nama Proyek',
                  hintText: 'Nama Proyek',
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
                controller: pDesc,
                maxLines: null,
                expands: true,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  labelText: 'Detail Proyek',
                  hintText: 'Detail Proyek',
                ),
                autofocus: false,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            // Container(
            //   child: TextField(
            //     decoration: InputDecoration(
            //       border: OutlineInputBorder(
            //           borderRadius: BorderRadius.all(Radius.circular(10))),
            //       labelText: 'Lampiran',
            //       hintText: 'Lampiran',
            //     ),
            //     autofocus: false,
            //   ),
            // ),
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
                  value: _value,
                  onChanged: (v) {
                    _value = v as int;
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
            Container(
              margin: const EdgeInsets.only(top: 30),
              width: MediaQuery.of(context).size.width,
              child: MaterialButton(
                onPressed: () async {
                  var myResponse = await http.post(
                    Uri.parse('${Utils.baseUrl}/project/addProj'),
                    body: {
                      'projName': pName.text,
                      'projDesc': pDesc.text,
                      'projPIC': _value.toString(),
                      'projDeadline': selectedDate.toString(),
                      'userID': '1',
                    },
                  );
                  print(myResponse.body);
                  setState(() {
                    pName.clear();
                    pDesc.clear();
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Sukses Tambah Proyek'),
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
