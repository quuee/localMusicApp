
import 'package:flutter/material.dart';
import 'package:localmusicapp/model/mapper/SheetMapper.dart';
import 'package:localmusicapp/model/mapper/SheetSongMapper.dart';
import 'package:localmusicapp/model/mapper/SongMapper.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteUtil {

  static SqfliteUtil instance = SqfliteUtil._();

  SqfliteUtil._();

  static const _version = 1;
  static const _databaseName = "song.db";

  static Database? db;

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = "$databasesPath/$_databaseName";
    debugPrint("数据库路径:$path");
    db = await openDatabase(
      path,
      version: _version,
      singleInstance: true,
      onConfigure: (Database db) async {
        debugPrint("数据库创建前、降级前、升级前调用");
      },
      onDowngrade: _onDowngrade,
      onUpgrade: _onUpgrade,
      onCreate: _onCreate,
      onOpen: (Database db) async {
        debugPrint("打开时调用");
      },
    );
  }
  Future _onCreate(Database db, int version) async {
    debugPrint("创建时调用");
    await db.execute(SheetMapper.createSql2);
    await db.execute(SongMapper.createSql2);
    await db.execute(SheetSongMapper.createSql2);
  }
  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    debugPrint("升级时调用");
  }
  Future _onDowngrade(Database db, int version, int newVersion) async {
    debugPrint("降级时调用");
  }
}