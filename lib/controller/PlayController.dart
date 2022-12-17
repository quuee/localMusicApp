import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:localmusicapp/config/ConstValues.dart';
import 'package:localmusicapp/model/SongModel.dart';

// 这个控制器只管播放（循环、随机） 暂停，和数据库交互交给其他控制器
// 这个播放需要后台播放， TODO GetService 是不是可以驻守后台播放?
class PlayController extends GetxController {
  late AudioPlayer _player;
  PlayerState playerState = PlayerState.stopped;

  List<SongModel> playList = [];

  int currentSongIndex = 0;

  PlayMode mode = PlayMode.sequence;

  Duration duration = const Duration();

  Duration position = const Duration();

  @override
  void onInit() {
    _player = AudioPlayer();

    // 监听播放总时长
    _player.onDurationChanged.listen((Duration d) {
      duration = d;
      update([ConstValues.ProgressBarDurationId]);
    });

    // 监听播放进度
    _player.onPositionChanged.listen((Duration p) {
      position = p;
      update([ConstValues.ProgressBarPositionId]);
    });

    // 监听播放状态改变
    _player.onPlayerStateChanged.listen((PlayerState state) {
      debugPrint("$state");
      playerState = state;
      update([ConstValues.PlayButtonId]);
    });

    // 监听时间段跳转
    _player.onSeekComplete.listen((event) {});

    // 监听播放完成
    _player.onPlayerComplete.listen((event) {
      if (mode == PlayMode.sequence) {
        Get.log("顺序播放：$currentSongIndex");
        nextSong();
      }
      if (mode == PlayMode.random) {
        int nextInt = Random().nextInt(playList.length);
        Get.log("随机播放：$nextInt");
        currentSongIndex = nextInt;
        play(playList[currentSongIndex].id!);
      }
      if (mode == PlayMode.single) {
        Get.log("单曲播放：$currentSongIndex");
        play(playList[currentSongIndex].id!);
      }
    });

    super.onInit();
  }

  Future<void> play(int songId) async {
    currentSongIndex = 0;
    Get.log("PlayController -> play songId:$songId");
    for (var element in playList) {
      if (element.id == songId) {
        break;
      } else {
        currentSongIndex++;
      }
    }
    Get.log("PlayController -> play currentSongIndex:$currentSongIndex");
    SongModel song = playList[currentSongIndex];
    bool blank = GetUtils.isBlank(song.songFileUrl)!;
    if (!blank) {
      await _player.play(DeviceFileSource(song.songFileUrl!),mode: PlayerMode.mediaPlayer);

      update([ConstValues.SongTitleId]);
    }
  }

  /// 播放或暂停
  void playOrPause() {
    if (playerState == PlayerState.playing) {
      _player.pause();
    } else {
      _player.resume();
    }
  }

  /// 下一首
  void nextSong() {
    if (currentSongIndex >= playList.length - 1) {
      currentSongIndex = 0;
    } else {
      currentSongIndex++;
    }
    SongModel song = playList[currentSongIndex];
    bool blank = GetUtils.isBlank(song.songFileUrl)!;
    if (!blank) {
      _player.play(DeviceFileSource(song.songFileUrl!),mode: PlayerMode.mediaPlayer);
      update([ConstValues.SongTitleId]);
    }
  }

  /// 上一首
  void previousSong() {
    if (currentSongIndex <= 0) {
      currentSongIndex = playList.length - 1;
    } else {
      currentSongIndex--;
    }
    SongModel song = playList[currentSongIndex];
    bool blank = GetUtils.isBlank(song.songFileUrl)!;
    if (!blank) {
      _player.play(DeviceFileSource(song.songFileUrl!),mode: PlayerMode.mediaPlayer);
      update([ConstValues.SongTitleId]);
    }
  }

  void changePlayList(List<SongModel> songList) {
    playList.clear();
    playList.addAll(songList);
  }

  void changePlayMode() {
    if (mode == PlayMode.sequence) {
      mode = PlayMode.random;
    } else if (mode == PlayMode.random) {
      mode = PlayMode.single;
    } else {
      mode = PlayMode.sequence;
    }
    Get.log("播放模式：$mode");
    update([ConstValues.PlayModeId]);
  }
}

enum PlayMode {
  /// 随机
  random,

  /// 顺序
  sequence,

  /// 单曲
  single,
}
