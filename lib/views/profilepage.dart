import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management/views/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final nipController = TextEditingController();
  final oldpasswordController = TextEditingController();
  final newpasswordController = TextEditingController();
  late bool obscureText;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  String _sessionValue = '';

  Future<void> _getSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _sessionValue = prefs.getString('employee_name') ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    obscureText = true;
    _getSession();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil"),
      ),
      key: scaffoldKey,
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Center(
              child: Center(
                child: Icon(
                  Icons.account_circle_outlined,
                  size: 200,
                  color: Colors.blueAccent,
                ),
              ),
            ),
            Material(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              elevation: 2,
              child: AspectRatio(
                aspectRatio: 7 / 1,
                child: Center(
                  // child: TextFormField(
                  //   decoration: const InputDecoration(
                  //       hintText: 'Nomor Induk Pegawai',
                  //       border: InputBorder.none,
                  //       contentPadding: EdgeInsets.all(8)),
                  //   controller: nipController,
                  //   keyboardType: TextInputType.number,
                  // ),
                  child: Text(
                    '$_sessionValue',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 1.2125,
                      color: Color(0xff000000),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Material(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              elevation: 2,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: AspectRatio(
                        aspectRatio: 7 / 1,
                        child: Center(
                            child: TextFormField(
                          decoration: const InputDecoration(
                              hintText: 'Password Lama',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(8)),
                          controller: oldpasswordController,
                          obscureText: obscureText,
                        ))),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: !obscureText
                          ? Colors.black.withOpacity(0.3)
                          : Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Material(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              elevation: 2,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: AspectRatio(
                        aspectRatio: 7 / 1,
                        child: Center(
                            child: TextFormField(
                          decoration: const InputDecoration(
                              hintText: 'Password Lama',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(8)),
                          controller: newpasswordController,
                          obscureText: obscureText,
                        ))),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: !obscureText
                          ? Colors.black.withOpacity(0.3)
                          : Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              width: MediaQuery.of(context).size.width,
              child: MaterialButton(
                onPressed: () {
                  loginValidation(context);
                },
                child: const Text("Ubah Password",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16)),
                // color: const Color(0xFFF58634),
                color: Colors.lightBlueAccent,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                padding: const EdgeInsets.all(16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              width: MediaQuery.of(context).size.width,
              child: MaterialButton(
                onPressed: () async {
                  // loginValidation(context);
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.remove('user_id');
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const LoginPage()));
                },
                child: const Text("Keluar",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16)),
                // color: const Color(0xFFF58634),
                color: Colors.lightBlueAccent,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                padding: const EdgeInsets.all(16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void loginValidation(BuildContext context) {}
}
