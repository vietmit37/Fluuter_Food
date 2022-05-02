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
      body: SafeArea(
        bottom: false,
        child: DefaultTabController(
          length: 2,
          initialIndex: 0,
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              TabBar(
                isScrollable: true,
                indicatorColor: Colors.red,
                tabs: [
                  Tab(
                    text: "Món mới".toUpperCase(),
                  ),
                  Tab(
                    text: "Danh mục".toUpperCase(),
                  ),
                ],
                labelColor: Colors.black,
                indicator: DotIndicator(
                  color: Colors.black,
                  distanceFromCenter: 16,
                  radius: 3,
                  paintingStyle: PaintingStyle.fill,
                ),
                unselectedLabelColor: Colors.black.withOpacity(0.3),
                labelStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                labelPadding: EdgeInsets.symmetric(
                  horizontal: 24,
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    NewRecipe(),
                    CategoriesPage(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
