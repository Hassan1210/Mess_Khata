//import 'package:mess_khata/Time_Table/time_table.dart';
import 'package:mess_khata/History/history_modle.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:mess_khata/Time_Table/time_modle.dart';
// ignore_for_file: prefer_const_constructors
import 'package:intl/intl.dart';

class Dbhelper {
  final String _dbName = "MessKhata.db";
  int dbVersion = 1;

  static Database? _database;
  Dbhelper._privateConstructor();
  static final Dbhelper intance = Dbhelper._privateConstructor();

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await inializeDataBase();
    return _database;
  }

  inializeDataBase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${ModleTimeTable.table} (
      ${ModleTimeTable.columnID} INTEGER PRIMARY KEY,
      ${ModleTimeTable.columnDAY} TEXT NOT NULL,
      ${ModleTimeTable.columnLUNCH} TEXT NOT NULL,
      ${ModleTimeTable.columnDINNER} TEXT NOT NULL,
      ${ModleTimeTable.columnLUNCHRs} INTEGER NOT NULL,
      ${ModleTimeTable.columnDINNERRs} INTEGER NOT NULL
      
      )
      ''');
    await db.execute('''
      CREATE TABLE ${ModleHistory.table} (
      ${ModleHistory.columnDAY} TEXT NOT NULL,
      ${ModleHistory.columnLUNCH} INTEGER NOT NULL,
      ${ModleHistory.columnDINNER} INTEGER NOT NULL,
      ${ModleHistory.columnLUNCHRs} INTEGER NOT NULL,
      ${ModleHistory.columnDINNERRs} INTEGER NOT NULL
      )
      ''');
  }

  // CRUD FUNCTIONS

  Future<int> insert(ModleTimeTable obj) async {
    Database? db = await intance.database;
    return db!.insert(ModleTimeTable.table, obj.toMap());
  }

  Future<List<Map<String, dynamic>>> readTimeTable() async {
    Database? db = await intance.database;
    return db!.query(ModleTimeTable.table);
  }

  Future<int> updateTimeTable(ModleTimeTable obj) async {
    Database? db = await intance.database;
    Map<String, dynamic> row = {
      ModleTimeTable.columnLUNCH: obj.lunch,
      ModleTimeTable.columnLUNCHRs: obj.lunchRs,
      ModleTimeTable.columnDINNER: obj.dinner,
      ModleTimeTable.columnDINNERRs: obj.dinnerRs,
    };
    return db!.update(ModleTimeTable.table, row,
        where: "${ModleTimeTable.columnID} = ?", whereArgs: [obj.id]);
  }

  Future<int> updateLunch(ModleHistory obj) async {
    print("Update");
    String s = DateFormat('yyyy-MM-dd')
        .format(DateTime.now());
    Database? db = await intance.database;
    Map<String, dynamic> row = {
      ModleHistory.columnLUNCHRs: 100,
      ModleHistory.columnLUNCH : 1,
    };
    return db!.update(ModleHistory.table, row,
        where: " ${ModleHistory.columnDAY} > ?", whereArgs: ['$s 00:00:00.000000']);
  }

  Future<int> updateDinner(ModleHistory obj) async {
    print("hello");
    String s = DateFormat('yyyy-MM-dd')
        .format(DateTime.now());
    Database? db = await intance.database;
    Map<String, dynamic> row = {
      ModleHistory.columnDINNERRs: obj.dinnerRs,
      ModleHistory.columnDINNER :obj.dinner,
    };
    return db!.update(ModleHistory.table, row,
        where: " ${ModleHistory.columnDAY} > ?", whereArgs: ['$s 00:00:00.000000']);
  }

  Future<ModleTimeTable> getMealName(DateTime time) async {
    Database? db = await intance.database;
    var maps = await db!.query(ModleTimeTable.table,
        columns: [
          ModleTimeTable.columnDINNER,
          ModleTimeTable.columnLUNCH,
          ModleTimeTable.columnLUNCHRs,
          ModleTimeTable.columnDINNERRs
        ],
        where: '${ModleTimeTable.columnDAY} = ?',
        whereArgs: [DateFormat.EEEE().format(time).toString()]);
    var myitem = [];
    ModleTimeTable _modleTimeTable = ModleTimeTable();
    maps.forEach((row) {
      myitem.add(row.toString());
      _modleTimeTable.dinner = row[ModleTimeTable.columnDINNER].toString();
      _modleTimeTable.lunch = row[ModleTimeTable.columnLUNCH].toString();
      _modleTimeTable.lunchRs =
          int.parse(row[ModleTimeTable.columnLUNCHRs].toString());
      _modleTimeTable.dinnerRs =
          int.parse(row[ModleTimeTable.columnDINNERRs].toString());
    });
    return _modleTimeTable;
  }

  Future<ModleHistory>getStatus(DateTime time)async{

    Database? db = await intance.database;
    String s = DateFormat('yyyy-MM-dd')
        .format(DateTime.parse(time.toString()));
    var maps = await db!.query(ModleHistory.table,
        columns: [
          ModleHistory.columnDINNER,
          ModleHistory.columnLUNCH,
        ],
        where: '${ModleHistory.columnDAY} >= ? AND ${ModleHistory.columnDAY} <= ?',
        whereArgs: ['$s 00:00:00.000000', '$s 23:59:00.000000']);
    ModleHistory _modleTimeTable = ModleHistory();
    var myitem = [];
    maps.forEach((row) {
      myitem.add(row.toString());
      _modleTimeTable.lunch =
          int.parse(row[ModleTimeTable.columnLUNCH].toString());
      _modleTimeTable.dinner =
          int.parse(row[ModleTimeTable.columnDINNER].toString());
    });
    return _modleTimeTable;

  }


  Future<bool>checkStatus(DateTime time)async{

    Database? db = await intance.database;
    String s = DateFormat('yyyy-MM-dd')
        .format(DateTime.parse(time.toString()));
    var maps = await db!.query(ModleHistory.table,
        where: '${ModleHistory.columnDAY} >= ? AND ${ModleHistory.columnDAY} <= ?',
        whereArgs: ['$s 00:00:00.000000', '$s 23:59:00.000000']);
    ModleHistory _modleTimeTable = ModleHistory();
    if(maps.isEmpty)
      {
        print("hello");
        return true;
      }
    else{
      print("world123");
      return false;
    }
  }


   Future<int>getBill(DateTime? startDate, DateTime? endDate) async {
    String s = DateFormat('yyyy-MM-dd')
        .format(DateTime.parse(endDate.toString()));

    int sum = 0;
    Database? db = await intance.database;
    var maps = await db!.query(ModleHistory.table,
        columns: [
          ModleHistory.columnLUNCHRs,
          ModleHistory.columnDINNERRs,
        ],
        where:
        '${ModleHistory.columnDAY} >= ? AND ${ModleHistory.columnDAY} <= ?',
        whereArgs: [startDate.toString(), '$s 23:59:00.000000']);
    var myitem = [];
    maps.forEach(
      (row) {
        myitem.add(row.toString());
        sum = sum +
            int.parse(row[ModleTimeTable.columnDINNERRs].toString()) +
            int.parse(row[ModleTimeTable.columnLUNCHRs].toString());
      },
    );
    return sum;
  }

  Future<int> insertmeal(ModleHistory obj) async {
    Database? db = await intance.database;
    return db!.insert(ModleHistory.table, obj.toMap());
  }

  getto() async {
    String s = DateFormat('yyyy-MM-dd')
        .format(DateTime.parse(DateTime.now().toString()));
    print(s);
    Database? db = await intance.database;
    var maps = await db!.query(ModleHistory.table,
        columns: [
          ModleHistory.columnDAY,
          ModleHistory.columnLUNCHRs,
          ModleHistory.columnDINNERRs
        ],
        where:
            '${ModleHistory.columnDAY} >= ? AND ${ModleHistory.columnDAY} <= ?',
        whereArgs: ['$s 00:00:00.000000', '$s 23:59:00.000000']);
    maps.forEach((row) {
      print(row);
    });
  }

  Future<List<ModleHistory>> readHistory(
      DateTime? startDate, DateTime? endDate) async {
    String s =
        DateFormat('yyyy-MM-dd').format(DateTime.parse(endDate.toString()));

    Database? db = await intance.database;
    var maps = await db!.query(ModleHistory.table,
        columns: [
          ModleHistory.columnDAY,
          ModleHistory.columnLUNCHRs,
          ModleHistory.columnDINNERRs,
        ],
        where:
            '${ModleHistory.columnDAY} >= ? AND ${ModleHistory.columnDAY} <= ?',
        whereArgs: [startDate.toString(), '$s 23:59:00.000000']);
    List<ModleHistory> list = [];
    if (maps.isNotEmpty) {
      for (int i = 0; i < maps.length; i++) {
        list.add(ModleHistory.fromMap(maps[i]));
      }
    }
    return list;
  }
}
