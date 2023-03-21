import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:task_management/views/navbarpage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final nipController = TextEditingController();
  final passwordController = TextEditingController();
  late bool obscureText;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    obscureText = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        body: Container(
          padding: const EdgeInsets.all(10),
          // decoration: const BoxDecoration(
          //   color: Colors.white,
          // ),
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                // elevation: 12,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 30,
                      ),
                      const Image(
                        image: AssetImage('assets/images/SD_Musada.jpg'),
                        width: 180.0,
                        height: 180.0,
                      ),
                      // const Text(
                      //   'LOGIN',
                      //   style: TextStyle(
                      //       fontSize: 28,
                      //       color: Colors.black54,
                      //       fontFamily: "Avenir",
                      //       fontWeight: FontWeight.bold,
                      //       fontStyle: FontStyle.normal),
                      // ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: <Widget>[
                              Material(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  elevation: 2,
                                  child: AspectRatio(
                                      aspectRatio: 7 / 1,
                                      child: Center(
                                          child: TextFormField(
                                        decoration: const InputDecoration(
                                            hintText: 'Email',
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.all(8)),
                                        controller: nipController,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                      )))),
                              Container(
                                  margin: const EdgeInsets.only(top: 16),
                                  child: Material(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                      elevation: 2,
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: AspectRatio(
                                                aspectRatio: 7 / 1,
                                                child: Center(
                                                    child: TextFormField(
                                                  decoration:
                                                      const InputDecoration(
                                                          hintText: 'Password',
                                                          border:
                                                              InputBorder.none,
                                                          contentPadding:
                                                              EdgeInsets.all(
                                                                  8)),
                                                  controller:
                                                      passwordController,
                                                  obscureText: obscureText,
                                                ))),
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              Icons.remove_red_eye,
                                              color: !obscureText
                                                  ? Colors.black
                                                      .withOpacity(0.3)
                                                  : Colors.black,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                obscureText = !obscureText;
                                              });
                                            },
                                          )
                                        ],
                                      ))),
                              Container(
                                  margin: const EdgeInsets.only(top: 30),
                                  width: MediaQuery.of(context).size.width,
                                  child: MaterialButton(
                                    onPressed: () {
                                      loginValidation(context);
                                    },
                                    child: const Text("Login",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16)),
                                    // color: const Color(0xFFF58634),
                                    color: Colors.lightBlueAccent,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50))),
                                    padding: const EdgeInsets.all(16),
                                  )),
                            ],
                          )),
                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 40),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // InkWell(
                            //   onTap: () {},
                            //   child: const Text(
                            //     'Sign Up',
                            //     style: TextStyle(
                            //         fontSize: 15,
                            //         color: Colors.black87,
                            //         fontFamily: "Avenir",
                            //         fontWeight: FontWeight.w500,
                            //         fontStyle: FontStyle.normal),
                            //   ),
                            // ),
                            // const SizedBox(
                            //   height: 10,
                            // ),
                            InkWell(
                              onTap: () {},
                              child: const Text(
                                'Lupa Password?',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black87,
                                    fontFamily: "Avenir",
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      callback();
    });
  }

  void loginValidation(BuildContext context) async {
    bool isLoginValid = true;
    FocusScope.of(context).requestFocus(FocusNode());

    if (nipController.text.isEmpty) {
      isLoginValid = false;
      _onWidgetDidBuild(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('NIP Tidak Boleh Kosong'),
            backgroundColor: Colors.red,
          ),
        );
      });
    }

    if (passwordController.text.isEmpty) {
      isLoginValid = false;
      _onWidgetDidBuild(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password Tidak Boleh Kosong'),
            backgroundColor: Colors.red,
          ),
        );
      });
    }
    if (isLoginValid) {
      // fetchLogin(context, nipController.text, passwordController.text);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const NavbarPage()));
    }
  }
// fetchLogin(BuildContext context, String email, String password) async {
//     final prefs = await SharedPreferences.getInstance();
//     showLoaderDialog(context);
//     try {
//       Response response;
//       var dio = Dio();
//       response = await dio.post(
//         'https://reqres.in/api/login',
//         data: {
//           'email': email,
//           'password': password
//         },
//         options: Options(contentType: Headers.jsonContentType),
//       );

//       if(response.statusCode == 200){
//         //berhasil
//         hideLoaderDialog(context);
//         //setSharedPreference
//         String prefEmail = email;
//         String prefToken = response.data['token'];
//         await prefs.setString('email', prefEmail);
//         await prefs.setString('token', prefToken);
//         //Messsage
//         _onWidgetDidBuild(() {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('Login Berhasil'),
//               backgroundColor: Colors.green,
//             ),
//           );
//         });
//         //homePage
//         Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginHomePage()));
//       }
//     }on DioError catch (e) {
//       hideLoaderDialog(context);
//       if(e.response?.statusCode == 400){
//         //gagal
//         String errorMessage = e.response?.data['error'];
//         _onWidgetDidBuild(() {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(errorMessage),
//               backgroundColor: Colors.red,
//             ),
//           );
//         });
//       }else{
//         // print(e.message);
//       }
//     }
//   }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  hideLoaderDialog(BuildContext context) {
    return Navigator.pop(context);
  }
}
