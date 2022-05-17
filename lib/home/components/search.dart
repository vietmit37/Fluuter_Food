import 'package:flutter/material.dart';
import 'package:project_food/model/DBHelper.dart';
import 'package:project_food/model/Recipe.dart';
import 'package:project_food/recipe/recipePage.dart';

import 'newRecipeTab.dart';

class SearchPage extends StatefulWidget {
  String searchKeyword;

  SearchPage({Key key, this.searchKeyword}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  DBHelper dbHelper;
  List<Recipe> recipeList;

  Future<List<Recipe>> _searchRecipes() async {
    recipeList = await dbHelper.searchRecipes(widget.searchKeyword);
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
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios, color: Colors.black,),
        ),
        title: TextField(
          controller: TextEditingController()..text =
            widget.searchKeyword != "@#!" ? widget.searchKeyword : "",
          autofocus: true,
          onSubmitted: (value) {
            if (value == '') {
              return;
            }
            setState(() {
              widget.searchKeyword = value;
            });
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),

            FutureBuilder<List<Recipe>> (
                future: _searchRecipes(),
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
                            child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: RecipeCard(recipe: recipeList[index])
                            ),
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
