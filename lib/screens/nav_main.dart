import 'package:flutter/material.dart';
import 'package:infixedu/config/app_config.dart';
import 'package:infixedu/screens/SettingsScreen.dart';
import 'package:infixedu/screens/SplashScreen.dart';
import 'package:infixedu/screens/policy.dart';
import 'package:infixedu/screens/student/Profile.dart';
import 'package:infixedu/utils/widget/ScaleRoute.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    // Home(),
    Splash(),
    Profile(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
            icon: Container(
                height: MediaQuery.of(context).size.width * 1 / 16,
                width: MediaQuery.of(context).size.width * 1 / 16,
                child: Image.asset("assets/images/policy.png")),
            label: "Home"),
        BottomNavigationBarItem(
            icon: Container(
                height: MediaQuery.of(context).size.width * 1 / 16,
                width: MediaQuery.of(context).size.width * 1 / 16,
                child: Image.asset("assets/images/profile.png")),
            label: "Profile"),
        BottomNavigationBarItem(
            icon: Container(
                height: MediaQuery.of(context).size.width * 1 / 16,
                width: MediaQuery.of(context).size.width * 1 / 16,
                child: Image.asset("assets/images/settings.png")),
            label: "Settings"),
      ],
      onTap: (index) {
        print("Index val -->" + index.toString());
        switch (index) {
          case 0:
            Navigator.push(context, ScaleRoute(page: Policy()));
            break;
          case 1:
            Navigator.push(context, ScaleRoute(page: Profile()));
            break;
          case 2:
            Navigator.push(context, ScaleRoute(page: SettingScreen()));
            break;
        }
      },
    );
    // body: _widgetOptions.elementAt(_selectedIndex),
  }
}
