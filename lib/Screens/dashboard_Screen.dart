import 'package:flutter/material.dart';
import 'package:hairsalon_application/Screens/home_screen.dart';
import 'package:hairsalon_application/Screens/profile_screen.dart';
import 'package:hairsalon_application/Screens/style_screen.dart';
import 'package:provider/provider.dart';

class DashBoardScreen extends StatefulWidget {
  static final String id = 'DashBoardScreen';

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  int _selectedIndex = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  var titles=["Home","Style","Profile"];

  final List<Widget> _pages = [
    HomeScreen(),
    StyleScreen(),
    ProfileScreen(),
  ];


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.black,
      //   title: Text(
      //       _selectedIndex == 0 ? '' : titles[_selectedIndex], style: TextStyle(color: Colors.white),),
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.notifications, color: Colors.white,),
      //       onPressed: () {
      //         // Navigator.pushNamed(context, NotificationScreen.id);
      //       },
      //     ),
      //   ],
      // ),

      body: _pages[_selectedIndex],

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, blurRadius: 15, spreadRadius: 1),
            ]
        ),
        child: BottomNavigationBar(
          key: _bottomNavigationKey,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera_enhance),
              label: 'Style',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            )
          ],
          currentIndex: _selectedIndex,
          unselectedItemColor: Colors.black26,
          selectedItemColor: Colors.black,
          onTap: _onItemTapped,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
