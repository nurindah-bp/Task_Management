import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  flex: 0,
                  child: Icon(Icons.account_circle,
                      size: 60, color: Colors.blueAccent),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsets.only(
                        top: 20, left: 10, right: 20, bottom: 20),
                    padding: const EdgeInsets.all(12),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff0693e3)),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      'Hi! Nur Indah',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        height: 1.2125,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 0,
                  child: Icon(
                    Icons.notifications_active,
                    size: 30,
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    // padding: EdgeInsets.all(50),
                    width: MediaQuery.of(context).size.width,
                    height: 160,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Resume Prokrastinasi Tugas Pegawai",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 160,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Tingkat Prokrastinasi Pegawai",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 160,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Tingkat Produktifitas Pegawai",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
