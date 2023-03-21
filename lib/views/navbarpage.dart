import 'package:flutter/material.dart';
import 'package:task_management/views/homepage.dart';
import 'package:task_management/views/login_page.dart';
import 'package:task_management/views/projectpage.dart';

class NavbarPage extends StatefulWidget {
  const NavbarPage({super.key});

  @override
  State<NavbarPage> createState() => _NavbarPageState();
}

class _NavbarPageState extends State<NavbarPage> {
  int _selectedTabIndex = 0;

  void _onNavBarTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _listPage = <Widget>[
      HomePage(),
      ProjectPage(),
      const Text('Tugas'),
      const Text('Profil')
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
      appBar: AppBar(
        title: const Text('Task Management'),
      ),
      body: Center(
        child: _listPage[_selectedTabIndex],
      ),
      bottomNavigationBar: _bottomNavBar,
    );
    // return Scaffold(
    //   bottomNavigationBar: NavigationBar(
    //     onDestinationSelected: (int index) {
    //       setState(() {
    //         currentPageIndex = index;
    //       });
    //     },
    //     selectedIndex: currentPageIndex,
    //     destinations: const <Widget>[
    //       NavigationDestination(
    //         icon: Icon(Icons.home),
    //         label: 'Beranda',
    //       ),
    //       NavigationDestination(
    //         icon: Icon(Icons.task),
    //         label: 'Projek',
    //       ),
    //       NavigationDestination(
    //         icon: Icon(Icons.add_task),
    //         label: 'Tugas',
    //       ),
    //       NavigationDestination(
    //         // selectedIcon: Icon(Icons.bookmark),
    //         icon: Icon(Icons.account_circle),
    //         label: 'Profil',
    //       ),
    //     ],
    //   ),
    //   body: <Widget>[
    //     Container(
    //       color: Colors.red,
    //       alignment: Alignment.center,
    //       child: const Text('Berisi Dashborad'),
    //     ),
    //     Container(
    //       color: Colors.green,
    //       alignment: Alignment.center,
    //       child: const Text('Berisi List Proyek'),
    //     ),
    //     Container(
    //       color: Colors.blue,
    //       alignment: Alignment.center,
    //       child: const Text('Berisi List Tugas'),
    //     ),
    //     Container(
    //       color: Colors.grey,
    //       alignment: Alignment.center,
    //       child: const Text('Berisi Informasi User'),
    //     ),
    //   ][currentPageIndex],
    // );
  }
}
