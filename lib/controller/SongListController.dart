import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localmusicapp/model/SongMapper.dart';
import 'package:localmusicapp/model/SongModel.dart';
import 'package:localmusicapp/util/SqfliteUtil.dart';
import 'package:sqflite/sqflite.dart';

class SongListController extends GetxController {
  List<SongModel> songList = [];

  Database? _database;

  @override
  void onInit() {
    _database = SqfliteUtil.db;

    super.onInit();
  }

  void addSongList(List<SongModel> newSongList) async {
    songList.clear();
    // await _database!.delete(SongMapper.tableName);
    Batch batch = _database!.batch();
    for (SongModel element in newSongList) {
      debugPrint(
          "SongListController -> addSongList -> songList.length:${element.toString()}");
      batch.insert(SongMapper.tableName, element.toJson());
    }
    await batch.commit();
    songList.addAll(newSongList);
    update();
  }

  Future<void> fetchAllSong() async {
    List<Map<String, dynamic>> maps = await _database!.query(
      SongMapper.tableName,
      columns: [
        SongMapper.id,
        SongMapper.songTitle,
        SongMapper.singer,
        SongMapper.songFileUrl,
        SongMapper.album
      ],
    );
    List<SongModel> map = maps.map((e) => SongModel.fromJson(e)).toList();
    debugPrint("fetchAllSong -> 查询到：${map.length}条");
    songList.clear();
    songList.addAll(map);
    update();
  }

  Future<void> fetchSongBySheet(int? sheetId) async {
    String whereSql = "";
    List<Object?>? whereArgs = [];
    if (sheetId != null && sheetId > 0) {
      whereSql += "${SongMapper.id}=?";
      whereArgs.add(sheetId);
    }
    List<Map<String, dynamic>> maps = await _database!.query(
      SongMapper.tableName,
      columns: [
        SongMapper.id,
        SongMapper.songTitle,
        SongMapper.singer,
        SongMapper.songFileUrl,
        SongMapper.album
      ],
      where: whereSql,
      whereArgs: whereArgs,
    );
    List<SongModel> map = maps.map((e) => SongModel.fromJson(e)).toList();
    debugPrint("fetchSongBySheet -> 查询到：${map.length}条");
    songList.clear();
    songList.addAll(map);
    update();
  }
}
