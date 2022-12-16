
import 'package:get/get.dart';
import 'package:localmusicapp/model/mapper/SongMapper.dart';
import 'package:localmusicapp/util/SqfliteUtil.dart';
import 'package:sqflite/sqflite.dart';

/// 歌曲选择列表控制器
class ChooseSongController extends GetxController{

  List<ChooseSong> chooseList = [];

  Database? _database;

  @override
  void onInit() {
    _database = SqfliteUtil.db;

    fetchAllSong();
    super.onInit();
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
    List<ChooseSong> map = maps.map((e) => ChooseSong.fromJson(e)).toList();

    chooseList.clear();
    chooseList.addAll(map);
    update();
  }

  checkOrCancel(int songId){
    ChooseSong song = chooseList.firstWhere((element) => element.songId == songId);
    if(song.check){
      song.check = false;
    }else {
      song.check = true;
    }
    update();
  }

}

class ChooseSong {

  int? songId;
  String? songTitle;
  bool check = false;

  ChooseSong.fromJson(Map<dynamic, dynamic> json)
      : songId = json["id"],
        songTitle = json["songTitle"];

  @override
  String toString() {
    return 'ChooseSong{songId: $songId, songTitle: $songTitle, check: $check}';
  }
}