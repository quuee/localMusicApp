


import 'package:flutter/material.dart';
import 'package:localmusicapp/components/SingleSong.dart';

/// 歌单添加歌曲选择页面
class ChooseSongPage extends StatelessWidget {
  const ChooseSongPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("选择歌曲"),

      ),
      body: ListView(
        children: [
          Row(
            children: [
              const Padding(
                  padding: EdgeInsets.all(6.0),
                  child: Icon(Icons.music_note,size: 40,)
              ),
              Expanded(child: Text("歌曲")),
              const Icon(Icons.check_box_outline_blank)
            ],
          ),
        ],
      )
    );
  }
}
