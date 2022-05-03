import 'package:flutter/material.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import 'categoriesTab.dart';
import 'newRecipeTab.dart';

class HomeFragment extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
            labelColor: Colors.redAccent,
            indicator: DotIndicator(
              color: Colors.redAccent,
              distanceFromCenter: 16,
              radius: 3,
              paintingStyle: PaintingStyle.fill,
            ),
            unselectedLabelColor: Colors.black.withOpacity(0.3),
            labelStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
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
    );
  }
}
