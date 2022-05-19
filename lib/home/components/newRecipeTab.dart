import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
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

    recipeList = await dbHelper.getRecipeList(3);
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
            Padding(
                padding: const EdgeInsets.only(
                  bottom: 12.0,
                )
            ),
            Container(
              child: Ads(),
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
                return Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: ListView.builder(
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
                ));
              }),
            Container(
              child: Ads(),
            ),
            SizedBox(
              height: 20,
            ),
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
  DBHelper dbHelper;
  Color likeColor;

  @override
  void initState() {
    dbHelper = DBHelper();
    likeColor = widget.recipe.liked == 1 ? Colors.red : Colors.black;
    super.initState();
  }

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
                      height: 220,
                      width: 420,
                  ),
                ),
              ),
            ),
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
                          dbHelper.likeRecipe(widget.recipe.id, widget.recipe.liked);
                          likeColor = likeColor == Colors.red ? Colors.black : Colors.red;
                        });
                      },
                      child: Icon(
                        FlutterIcons.heart_circle_mco,
                        color: likeColor,
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
class Ads extends StatefulWidget {

  @override
  State<Ads> createState() => _AdsState();
}

class _AdsState extends State<Ads> {
  final BannerAd myBanner = BannerAd(
    adUnitId: Platform.isAndroid ?'ca-app-pub-3940256099942544/6300978111':'ca-app-pub-3940256099942544/2934735716',
    size: AdSize.banner,
    request: AdRequest(),
    listener: AdListener(
      onAdLoaded: (Ad ad) => print('Ad loaded.'),
      // Called when an ad request failed.
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        ad.dispose();
        print('Ad failed to load: $error');
      },
      // Called when an ad opens an overlay that covers the screen.
      onAdOpened: (Ad ad) => print('Ad opened.'),
      // Called when an ad removes an overlay that covers the screen.
      onAdClosed: (Ad ad) => print('Ad closed.'),
      // Called when an ad is in the process of leaving the application.
      onApplicationExit: (Ad ad) => print('Left application.'),

    ),
  );

  @override
  void initState() {
    super.initState();
    myBanner.load();
    // Load ads.
  }
  @override
  Widget build(BuildContext context) {
    return  Stack(
        children: [
          Positioned(child: Container(
            width: 320,
            height: 60,
            child: AdWidget(ad: myBanner,),
          ))
        ],
      );
  }
}
