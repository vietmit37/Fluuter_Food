import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:project_food/recipe/recipePage.dart';

import '../../model/DBHelper.dart';
import '../../model/Recipe.dart';

class NewRecipe extends StatefulWidget {
  @override
  State<NewRecipe> createState() => _NewRecipeState();
}

class _NewRecipeState extends State<NewRecipe> {
  DBHelper dbHelper;
  List<Recipe> recipeList;

  Future<List<Recipe>> getRecipeList() async {
    // Dòng dưới để test loading
    // await Future.delayed(Duration(seconds: 2));

    recipeList = await dbHelper.getRecipeList(5);
  }

  @override
  void initState() {
    dbHelper = DBHelper();
    dbHelper.copyDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            FutureBuilder<List<Recipe>>(
              future: getRecipeList(),
              builder: (BuildContext context, AsyncSnapshot<List<Recipe>> snapshot) {
                while (recipeList == null) {
                  return Center(
                      heightFactor: 6.5,
                      child: SizedBox(
                        width: 60,
                        height: 60,
                        child: CircularProgressIndicator(),
                    )
                  );
                }
                return ListView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: recipeList.length,
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
                                        recipe: recipeList[index],
                                      ),
                                )),
                        child: RecipeCard(
                          recipe: recipeList[index],
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
}

class RecipeCard extends StatefulWidget {
  final Recipe recipe;
  RecipeCard({
    @required this.recipe,
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
                  tag: widget.recipe.image,
                  child: Image.memory(
                      widget.recipe.image,
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
                      widget.recipe.name,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      widget.recipe.categoryName,
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
                      widget.recipe.time.toString() + '\'',
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
