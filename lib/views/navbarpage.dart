import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/controllers/auth_controller.dart';
import 'package:task_management/views/home/homepage.dart';
import 'package:task_management/views/home/homepage_kadiv.dart';
import 'package:task_management/views/profile/profilepage.dart';
import 'package:task_management/views/project/projectpage.dart';
import 'package:task_management/views/task/tasklistpage.dart';

class NavbarPage extends StatefulWidget {
  const NavbarPage({super.key});

  @override
  State<NavbarPage> createState() => _NavbarPageState();
}

class _NavbarPageState extends State<NavbarPage> {
  final AuthController authController = Get.find<AuthController>();
  int _selectedTabIndex = 0;
  // var dashPage;

  void _onNavBarTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
      // if(authController.currentUser.value?.positionId == 1) {
      //   dashPage = HomePage();
      // }else{
      //   dashPage = HomePageKadiv();
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    final _listPage = <Widget>[
      HomePage(),
      // if (authController.currentUser.value?.positionId == 1)
      //   HomePage()
      // else
      //   HomePageKadiv(),
      ProjectPage(),
      TaskListPage(),
      ProfilePage(),
    ];

    final _bottomNavBarItems = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Beranda',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.task),
        label: 'Projek',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.add_task),
        label: 'Tugas',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.account_circle),
        label: 'Profil',
      ),
    ];

    final _bottomNavBar = BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.blue,
      items: _bottomNavBarItems,
      currentIndex: _selectedTabIndex,
      unselectedItemColor: Colors.white54,
      selectedItemColor: Colors.white,
      onTap: _onNavBarTapped,
    );

    return Scaffold(
      body: Center(
        child: _listPage[_selectedTabIndex],
      ),
      bottomNavigationBar: _bottomNavBar,
    );
  }
}
