import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localmusicapp/config/ConstValues.dart';
import 'package:localmusicapp/controller/PlayController.dart';
import 'package:localmusicapp/router/AppRoutes.dart';

class BottomPlayBar extends StatelessWidget {
  const BottomPlayBar({Key? key}) : super(key: key);

  // 歌曲封面
  Widget _songAlbum() {
    return Expanded(
        flex: 1,
        child: GetBuilder<PlayController>(
          builder: (_) {
            return const Icon(
              Icons.music_note,
              size: 30,
            );
          },
        ));
  }

  // 歌曲名
  Widget _songTitle() {
    return Expanded(
        flex: 4,
        child: GetBuilder<PlayController>(
          id: ConstValues.SongTitleId,
          builder: (controller) {
            return Text(controller.playList.isEmpty
                ? ""
                : controller.playList[controller.currentSongIndex].songTitle!);
          },
        ));
  }

  // 播放按钮
  Widget _playButton() {
    return Expanded(
      flex: 1,
      child: GetBuilder<PlayController>(
        id: ConstValues.PlayButtonId,
        builder: (_) {
          return IconButton(
              iconSize: 40,
              onPressed: () {
                _.playOrPause();
              },
              icon: Icon(_.playerState == PlayerState.playing
                  ? Icons.pause
                  : Icons.play_arrow));
        },
      ),
    );
  }

  // 下一首按钮
  Widget _nextSongButton() {
    return Expanded(
      flex: 1,
      child: GetBuilder<PlayController>(
        builder: (_) {
          return IconButton(
              // iconSize: 25,
              onPressed: () {
                _.nextSong();
              },
              icon: const Icon(
                Icons.skip_next,
              ));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.withOpacity(0.2), //边框颜色
          width: 1,
        ),
        color: Colors.white38,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5.0,
            spreadRadius: 0.1,
          )
        ],
      ),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(AppRouter.PlayDetail);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _songAlbum(),
            _songTitle(),
            _playButton(),
            _nextSongButton(),
          ],
        ),
      ),
    );
  }
}
