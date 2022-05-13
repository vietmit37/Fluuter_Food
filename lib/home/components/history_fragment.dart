import 'package:flutter/material.dart';
import 'package:project_food/model/DBHelper.dart';
import 'package:project_food/model/History.dart';

class HistoryPage extends StatefulWidget {

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  DBHelper dbHelper;
  List<History> historyList;

  Future<List<History>> _getHistory() async {
    historyList = await dbHelper.getHistory();
  }

  @override
  void initState() {
    // TODO: implement initState
    dbHelper = DBHelper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text('Lịch sử xem', style: TextStyle(color: Colors.black,), textAlign: TextAlign.center,),
      ),

      body: SingleChildScrollView(
      child: Column(
      children: [
      SizedBox(
        height: 10,
      ),

      FutureBuilder<List<History>> (
          future: _getHistory(),
          builder: (BuildContext context, AsyncSnapshot<List<History>> snapshot) {
            while (historyList == null) {
              return Center(
                  heightFactor: 6.5,
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(),
                  )
              );
            }

            if (historyList.length < 1) {
              return Column(
                children: [
                  Center(
                      child: Image.asset('assets/images/price_tag.png',
                        height: 310,
                        width: 150,
                        color: Colors.black12,
                        alignment: Alignment.bottomCenter,
                      )
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Lịch sử trống', style: TextStyle(color: Colors.black54),)
                ],
              );
            }

            return ListView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: historyList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    child: InkWell(
                      onTap: () => print(historyList[index].recipeID),
                      child: Text(historyList[index].recipeID.toString()),
                    )
                );
              },
            );
          })
        ],
      ),),
    );
  }
}
