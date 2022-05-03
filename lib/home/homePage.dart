import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:project_food/home/components/newRecipeTab.dart';
import 'package:project_food/home/components/categoriesTab.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return Scaffold(
      // BOTTOM NAV BAR
      bottomNavigationBar: Container(
        // color: Colors.grey[300],
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              FlutterIcons.home_outline_mco,
              color: Colors.blue,
            ),
            Icon(
              FlutterIcons.account_group_outline_mco,
            ),
            Icon(
              FlutterIcons.heart_outlined_ent,
            ),
            Icon(
              FlutterIcons.account_outline_mco,
            ),
          ],
        ),
      ),
    );
  }
}
