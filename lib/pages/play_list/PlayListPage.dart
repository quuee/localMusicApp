import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localmusicapp/components/BottomPlayBar.dart';
import 'package:localmusicapp/components/SingleSong.dart';
import 'package:localmusicapp/config/ConstValues.dart';
import 'package:localmusicapp/controller/SongListController.dart';
import 'package:localmusicapp/pages/play_list/PlayListPopupMenu.dart';

class PlayListPage extends StatefulWidget {
  const PlayListPage({Key? key}) : super(key: key);

  @override
  State<PlayListPage> createState() => _PlayListPageState();
}

class _PlayListPageState extends State<PlayListPage> {
  @override
  Widget build(BuildContext context) {

    final args = Get.arguments as Map;
    SongListController songListController = Get.find<SongListController>();
    songListController.setSheetId = args["sheetId"];
    songListController.fetchSongBySheet();

    // TODO 歌单添加歌曲后 返回没有歌曲

    return Scaffold(
      appBar: AppBar(
        title: const Text(ConstValues.PageName_Sheet),
        // 添加歌曲、编辑歌单信息、排序、删除歌单
        actions: [
          playListPopupMenu(context)
        ],
      ),
      body: Column(
        children: [
          GetBuilder<SongListController>(builder: (_) {
            return Expanded(
                child: ListView.builder(
                    itemCount: _.songList.length,
                    itemBuilder: (context, index) {
                      String songTitle =
                          _.songList.elementAt(index).songTitle ?? ConstValues.unkown;
                      int songId = _.songList.elementAt(index).id ?? 0;
                      return SingleSong(songTitle, songId);
                    }));
          }),
          BottomPlayBar()
        ],
      ),
    );
  }
}
