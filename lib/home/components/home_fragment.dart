import 'package:flutter/material.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import 'categoriesTab.dart';
import 'newRecipeTab.dart';

class HomeFragment extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: height * 0.3,
                    width: width,
                    decoration: BoxDecoration(
                        image:DecorationImage(
                            image: AssetImage("assets/images/img1.jpg"),
                            fit: BoxFit.cover
                        )
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Colors.black.withOpacity(0.0),
                            Colors.black.withOpacity(0.0),
                            Colors.black.withOpacity(0.1),
                            Colors.black.withOpacity(0.5),
                            Colors.black.withOpacity(1.0),
                          ],
                              begin: Alignment.topRight,end:Alignment.bottomLeft
                          )
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 90,
                    left: 20,
                    child: RichText(
                      text: TextSpan(
                          text: "Welcome",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 20,
                          ),
                          children: [
                            TextSpan(
                                text: "\nTutorial Cook",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 24,
                                )
                            )
                          ]
                      ),
                    ),),
                ],
              ),
              Transform.translate(
                offset: Offset(0.0, -(height * 0.32 - height * 0.26)),
                child: Container(
                  width: width,
                  // height: 400,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )
                  ),
                  child:DefaultTabController(
                    length: 2,
                    child: Column(
                      children: <Widget>[
                        TabBar(
                          labelColor: Colors.redAccent,
                          unselectedLabelStyle: TextStyle(
                              fontWeight: FontWeight.normal,fontSize: 14
                          ),

                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorColor: Colors.transparent,
                          tabs: <Widget>[
                            Tab(
                              text: "Món mới".toUpperCase(),
                            ),
                            Tab(
                              text: "Danh mục".toUpperCase(),
                            ),
                          ],
                          indicator: DotIndicator(
                            color: Colors.redAccent,
                            distanceFromCenter: 16,
                            radius: 3,
                            paintingStyle: PaintingStyle.fill,
                          ),

                          unselectedLabelColor: Colors.black,
                          labelStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                          labelPadding: EdgeInsets.symmetric(
                            horizontal: 24,
                          ),
                        ),
                        SizedBox(height: 5,),
                        Padding(
                          padding: const EdgeInsets.only(left: 20,right: 20),
                          child: TextField(
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 3),
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(left: 15,right: 15),
                                  child: Icon(
                                    Icons.search,
                                    size: 30,
                                  ),
                                ),
                                hintText: "Search Cook",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                      width: 1.0,
                                      color: Colors.grey[400],
                                    )
                                )
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                          height: height * 0.6,
                          child: TabBarView(
                            children: <Widget>[
                              NewRecipe(),
                              CategoriesPage(),
                            ],
                          ),
                        )
                      ],
                    ),
                  ) ,
                ),
              )
            ],
          ),
        )
    );
  }
}
