import 'package:flutter/material.dart';
import 'package:project_food/home/components/search.dart';
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
                    height: height * 0.29,
                    width: width,
                    decoration: BoxDecoration(
                        image:DecorationImage(
                            image: AssetImage("assets/images/bg_2.jpg"),
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
                    left: 30,
                    child: RichText(
                      text: TextSpan(
                          text: "Xin chào !",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 24,
                          ),
                          children: [
                            TextSpan(
                                text: "\nVietCook",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 30,
                                ),
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
                          labelColor: Colors.orange,
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
                            color: Colors.orange,
                            distanceFromCenter: 16,
                            radius: 3,
                            paintingStyle: PaintingStyle.fill,
                          ),

                          unselectedLabelColor: Colors.black,
                          labelStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          labelPadding: EdgeInsets.symmetric(
                            horizontal: 24,
                          ),
                        ),
                        SizedBox(height: 5,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            autofocus: false,
                            onSubmitted: (value) {
                              Navigator.push(context,
                                MaterialPageRoute(
                                  builder: (context) => SearchPage(searchKeyword: value),
                                ),
                              );
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 3),
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  child: Icon(
                                    Icons.search,
                                    size: 30,
                                  ),
                                ),
                                hintText: "Tìm kiếm",
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
