import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:project_food/model/DBHelper.dart';
import 'package:project_food/model/Recipe.dart';
import 'package:project_food/recipe/recipePage.dart';

class FavoritePage extends StatefulWidget {

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  DBHelper dbHelper;
  List<Recipe> recipeList;
  String dropdownValue = 'Sắp xếp A-Z';

  Future<List<Recipe>> _getLikedRecipes(String sortValue) async {
    recipeList = await dbHelper.getLikedRecipes();

    switch(sortValue) {
      case ("Sắp xếp theo danh mục"):
        {
          recipeList.sort((recipeA, recipeB) =>
              recipeA.categoryName.compareTo(recipeB.categoryName));
          break;
        }
      case ("Sắp xếp theo thời gian nấu"):
        {
          recipeList.sort((recipeA, recipeB) =>
              recipeA.time.compareTo(recipeB.time));
          break;
        }
      default:
        recipeList.sort((recipeA, recipeB) => recipeA.name.compareTo(recipeB.name));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    dbHelper = DBHelper();
    // dbHelper.copyDB();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text('Món ăn yêu thích', style: TextStyle(color: Colors.black,), textAlign: TextAlign.center,),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),

            Container(
                width: 220,
                child: DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Padding(
                      child: Icon(Icons.arrow_downward, size: 18.5,),
                      padding: EdgeInsets.fromLTRB(35, 0, 0, 0),
                  ),
                  elevation: 16,
                  style: const TextStyle(color: Colors.black),
                  underline: Container(
                    height: 1.5,
                    color: Colors.black,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      _getLikedRecipes(newValue);
                      dropdownValue = newValue;
                    });
                  },
                  items: <String>['Sắp xếp A-Z', 'Sắp xếp theo danh mục', 'Sắp xếp theo thời gian nấu']
                      .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                )
            ),

            SizedBox(
              height: 16,
            ),

            FutureBuilder<List<Recipe>> (
                future: _getLikedRecipes(dropdownValue),
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

                  if (recipeList.length < 1) {
                    return Column(
                      children: [
                        Center(
                            child: Image.asset('assets/images/price_tag.png',
                              height: 250,
                              width: 150,
                              color: Colors.black12,
                              alignment: Alignment.bottomCenter,
                            )
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text('Danh sách yêu thích trống', style: TextStyle(color: Colors.black54),)
                      ],
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
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => RecipeDetails(recipe: recipeList[index]))
                                ),
                            child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: FavoriteRecipeCard(recipe: recipeList[index])
                            ),
                          )
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

class FavoriteRecipeCard extends StatefulWidget {
  final Recipe recipe;
  FavoriteRecipeCard({
    @required this.recipe,
  });

  @override
  _FavoriteRecipeCardState createState() => _FavoriteRecipeCardState();
}

class _FavoriteRecipeCardState extends State<FavoriteRecipeCard> {
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  flex: 1,
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: MemoryImage(widget.recipe.image),
                      )
                    ],
                  )
              ),
              Flexible(
                flex: 1,
                child: Container(
                    width: 120,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: Text(
                              widget.recipe.name,
                              style: TextStyle(fontSize: 15.5),
                              )
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          widget.recipe.categoryName,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    )
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
