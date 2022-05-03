import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:project_food/home/components/home_fragment.dart';

import 'components/favorite_fragment.dart';
import 'components/history_fragment.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;
  List<Widget> screen = [
    HomeFragment(),
    FavoritePage(),
    HistoryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // BOTTOM NAV BAR
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.black,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        onTap: (index){
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(FlutterIcons.home_outline_mco),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(FlutterIcons.heart_outlined_ent),
            label: 'Yêu thích',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Lịch sử',
          ),
        ],
      ),
      body: SafeArea(
          bottom: false,
          child: screen[selectedIndex]
      ),
    );
  }
}