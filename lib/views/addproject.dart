import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AddProject extends StatefulWidget {
  const AddProject({super.key});

  @override
  State<AddProject> createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProject> {
  List<dynamic> _data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:3000/pegawai'));
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
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
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
            Container(
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  labelText: 'Lampiran',
                  hintText: 'Lampiran',
                ),
                autofocus: false,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: new DropdownButton(
                  items: _data.map((item) {
                    return new DropdownMenuItem(
                      child: new Text(item[
                          'nama_pegawai']), //error!(type 'String' is not a subtype of type 'int' of 'index')
                      value: item['id_pegawai'].toString(),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      _data.first = value!;
                    });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
