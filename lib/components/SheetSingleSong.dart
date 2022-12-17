
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localmusicapp/controller/PlayController.dart';
import 'package:localmusicapp/controller/SongListController.dart';

class SheetSingleSong extends StatelessWidget {

  const SheetSingleSong(this.songName,this.songId,{Key? key}) : super(key: key);

  final String songName;
  final int songId;

  Row _item(){
    return Row(
      children: [
        const Padding(
            padding: EdgeInsets.all(6.0),
            child: Icon(Icons.music_note,size: 40,)
        ),
        Expanded(child: Text(songName)),
        IconButton(onPressed: (){

          // TODO 应该先弹出菜单按钮
        }, icon: Icon(Icons.more_vert))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.log("点击播放歌曲");
        SongListController songListController = Get.find<SongListController>();
        PlayController playController = Get.find<PlayController>();
        playController.changePlayList(songListController.songList);
        playController.play(songId);
      },

      child: Dismissible(
        key: Key(songId.toString()),
        background: Container(color: Colors.red,),
        direction: DismissDirection.endToStart,
        onDismissed: (direction){
          // Get.log("onDismissed -> $direction");
          SongListController songListController = Get.find<SongListController>();
          songListController.deleteSongFromSheet(songId);
        },
        child: _item(),
      ),
    );

  }
}
