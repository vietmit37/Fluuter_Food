import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'MonAn.dart';

class DBHelper {
  copyDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "MonAnDB.db");

    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      ByteData data = await rootBundle.load(join("assets", "MonAnDB.db"));
      List<int> bytes = data.buffer.asUint8List(
          data.offsetInBytes, data.lengthInBytes);

      await new File(path).writeAsBytes(bytes);
    }
  }

  openDB() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String databasePath = join(appDocDir.path, 'MonAnDB.db');
    return await openDatabase(databasePath);
  }

  Future<List<MonAn>> getListMonAn(int limit) async {
    List<MonAn> data = new List<MonAn>();
    Database db = await openDB();
    // var list = await db.rawQuery('SELECT * FROM Students');
    var list = await db.query('MonAn', limit: limit);
    for (var item in list.toList()){
      data.add(MonAn(
          maMon: item['maMon'], tenMon: item['tenMon'],
          danhMuc: item['danhMuc'], nguyenLieu: item['nguyenLieu'],
          cachNau: item['cachNau'], yeuThich: item['yeuThich'],
          hinhAnh: item['hinhAnh'], thoiGian: item['thoiGian']
      ));
    }
    db.close();
    return data;
  }
}