import 'package:flutter/material.dart';
import 'package:project_food/home/components/newRecipeTab.dart';
import 'package:project_food/model/DBHelper.dart';
import 'package:project_food/model/Recipe.dart';
import 'package:project_food/recipe/recipePage.dart';

class RecipeListPage extends StatefulWidget {
  final String categoryName;

  const RecipeListPage({Key key, this.categoryName}) : super(key: key);

  @override
  State<RecipeListPage> createState() => _RecipeListPageState();
}

class _RecipeListPageState extends State<RecipeListPage> {
  DBHelper dbHelper;
  List<Recipe> recipeList;

  Future<List<Recipe>> _getRecipesByCate() async {
    recipeList = await dbHelper.getRecipesByCate(widget.categoryName);
  }

  @override
  void initState() {
    // TODO: implement initState
    dbHelper = DBHelper();
    dbHelper.copyDB();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios, color: Colors.black,),
        ),
        title: Text(widget.categoryName, style: TextStyle(color: Colors.black),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            FutureBuilder<List<Recipe>> (
                future: _getRecipesByCate(),
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
                            Navigator.push(context,
                              MaterialPageRoute(builder: (context) => RecipeDetails(recipe: recipeList[index]))
                            ),
                            child: RecipeCard(recipe: recipeList[index]),
                      ));
                    },
                  );
                })
          ],
        ),
      ),
    );
  }
}