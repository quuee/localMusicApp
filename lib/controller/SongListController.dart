import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localmusicapp/config/ConstValues.dart';
import 'package:localmusicapp/controller/ChooseSongController.dart';
import 'package:localmusicapp/model/SheetSongModel.dart';
import 'package:localmusicapp/model/mapper/SheetSongMapper.dart';
import 'package:localmusicapp/model/mapper/SongMapper.dart';
import 'package:localmusicapp/model/SongModel.dart';
import 'package:localmusicapp/util/SqfliteUtil.dart';
import 'package:sqflite/sqflite.dart';

/// 所有歌曲列表控制器
class SongListController extends GetxController {
  List<SongModel> songList = [];

  Database? _database;

  /// 歌单id
  int? _sheetId;

  set setSheetId(int sheetId) => _sheetId = sheetId;

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
          "SongListController -> addSongList -> model:${element.toString()}");
      batch.insert(SongMapper.tableName, element.toJson());
    }
    await batch.commit();
    songList.addAll(newSongList);

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
    Get.log("fetchAllSong -> 查询到：${map.length}条");
    songList.clear();
    songList.addAll(map);
    update([ConstValues.AllSongPageId]);
  }

  /// 从歌单中查询歌曲
  Future<void> fetchSongBySheet() async {
    List<Object?>? whereArgs = [];
    if (_sheetId != null) {
      whereArgs.add(_sheetId);
    }
    String querySql = "select "
        "tss.id tssid,"
        "tss.sheetId,"
        "tss.songId id,"
        "ts.songTitle,"
        "ts.songFileUrl,"
        "ts.singer,"
        "ts.album "
        "from t_sheet_song tss "
        "inner join t_song ts on tss.songId = ts.id "
        "where tss.sheetId=? "
        "order by tss.sequence asc";

    List<Map<String, dynamic>> maps =
        await _database!.rawQuery(querySql, whereArgs);

    List<SongModel> map = maps.map((e) => SongModel.fromJson(e)).toList();
    Get.log("fetchSongBySheet -> 查询到：${map.length}条");
    songList.clear();
    songList.addAll(map);
    update([ConstValues.PlayListPageId]);
  }

  /// 建立歌曲 歌单关系
  Future<void> songIntoSheet(List<ChooseSong> songList) async {
    Batch batch = _database!.batch();
    int seq = 1;
    for (ChooseSong element in songList) {
      Get.log(
          "SongListController -> songIntoSheet -> model:${element.toString()}");
      if (element.check) {
        SheetSongModel sheetSongModel =
            SheetSongModel(null, _sheetId, element.songId, seq++);
        batch.insert(SheetSongMapper.tableName, sheetSongModel.toJson());
      }
    }
    await batch.commit();
  }

  /// 从歌单中删除歌曲（从数据库歌单歌曲关系表中删除，不会将本地歌曲文件删除）
  Future<void> deleteSongFromSheet(int songId) async {
    await _database!.delete(SheetSongMapper.tableName,
        where: "${SheetSongMapper.songId} = ?",
        whereArgs: [songId]);
    // update([ConstValues.PlayListPageId]);
  }
}
