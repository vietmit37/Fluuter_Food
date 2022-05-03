import 'package:flutter/material.dart';
import 'package:project_food/home/components/recipeList.dart';
import 'package:project_food/model/Category.dart';
import 'package:project_food/model/DBHelper.dart';

class CategoriesPage extends StatefulWidget {

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  DBHelper dbHelper;
  List<Category> categoryList;

  Future<List<Category>> _getCategoryList() async {
    categoryList = await dbHelper.getCategoryList();
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
    // super.build(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            FutureBuilder<List<Category>> (
                future: _getCategoryList(),
                builder: (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
                  while (categoryList == null) {
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
                      margin: EdgeInsets.only(bottom: 90),
                      child:ListView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: categoryList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                            child: InkWell(
                              child: Container(
                                height: 170,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(categoryList[index].name.toUpperCase(),
                                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 2.5),)
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  image: new DecorationImage(
                                    fit: BoxFit.fitWidth,
                                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.8), BlendMode.dstATop),
                                    image: AssetImage('assets/images/categories/' + categoryList[index].image),
                              ),
                          ),
                            ),
                              onTap: () {
                                Navigator.push(context,
                                  MaterialPageRoute(
                                    builder: (context) => RecipeListPage(categoryName: categoryList[index].name),
                                  ),
                                );
                              },
                          )
                          );
                        },
                      )
                  );
                })
          ],
        ),
      ),
    );
  }
}