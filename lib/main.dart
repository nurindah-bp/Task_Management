import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/bindings/app_binding.dart';
import 'package:task_management/views/auth/login_page.dart';

void main() {

  // inisialisasi dependency injection getx
  AppBinding().dependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Task Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}
