
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localmusicapp/controller/PlayController.dart';
import 'package:localmusicapp/controller/SongListController.dart';

class SingleSong extends StatelessWidget {

  const SingleSong(this.songName,this.songId,{Key? key}) : super(key: key);

  final String songName;
  final int songId;

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
      child: Row(
        children: [
          const Padding(
              padding: EdgeInsets.all(6.0),
              child: Icon(Icons.music_note,size: 40,)
          ),
          Expanded(child: Text(songName)),
          const Icon(Icons.more_vert)
        ],
      ),
    );

  }
}
