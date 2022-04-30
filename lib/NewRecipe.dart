import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:project_food/Screens/RecipeDetails.dart';

import 'model/DBHelper.dart';
import 'model/MonAn.dart';

class NewRecipe extends StatefulWidget {
  @override
  State<NewRecipe> createState() => _NewRecipeState();
}

class _NewRecipeState extends State<NewRecipe> with AutomaticKeepAliveClientMixin<NewRecipe>   {
  DBHelper dbHelper;
  List<MonAn> lstMonAn;

  Future<List<MonAn>> _getListMonAn() async {
    lstMonAn = await dbHelper.getListMonAn(5);
  }

  @override
  void initState() {
    dbHelper = DBHelper();
    dbHelper.copyDB();
    _getListMonAn();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            FutureBuilder<List<MonAn>>(
              future: _getListMonAn(),
              builder: (BuildContext context, AsyncSnapshot<List<MonAn>> snapshot) {
                  return ListView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: lstMonAn.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                        child: InkWell(
                          onTap: () =>
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        RecipeDetails(
                                          recipeModel: lstMonAn[index],
                                        ),
                                  )),
                          child: RecipeCard(
                            recipeModel: lstMonAn[index],
                          ),
                        ),
                      );
                    },
                  );
              })
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class RecipeCard extends StatefulWidget {
  final MonAn recipeModel;
  RecipeCard({
    @required this.recipeModel,
  });

  @override
  _RecipeCardState createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  bool loved = false;
  bool saved = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Hero(
                  tag: widget.recipeModel.hinhAnh,
                  child: Image.memory(
                      widget.recipeModel.hinhAnh,
                      fit: BoxFit.fill,
                      height: 250,
                      width: 450,
                  ),
                ),
              ),
            ),
            // Positioned(
            //   top: 20,
            //   right: 40,
            //   child: InkWell(
            //     onTap: () {
            //       setState(() {
            //         saved = !saved;
            //       });
            //     },
            //     // child: Icon(
            //     //   saved
            //     //       ? FlutterIcons.bookmark_check_mco
            //     //       : FlutterIcons.bookmark_outline_mco,
            //     //   color: Colors.white,
            //     //   size: 38,
            //     // ),
            //   ),
            // ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.recipeModel.tenMon,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      widget.recipeModel.danhMuc,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ),
              // Spacer(),
              Flexible(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      FlutterIcons.timer_mco,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      widget.recipeModel.thoiGian.toString() + '\'',
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        setState(() {
                          loved = !loved;
                        });
                      },
                      child: Icon(
                        FlutterIcons.heart_circle_mco,
                        color: loved ? Colors.red : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
