import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localmusicapp/components/MusicProgressIndicator.dart';
import 'package:localmusicapp/config/ConstValues.dart';
import 'package:localmusicapp/controller/PlayController.dart';
import 'package:localmusicapp/util/TimeUtil.dart';

class PlayDetailPage extends StatefulWidget {
  const PlayDetailPage({Key? key}) : super(key: key);

  @override
  State<PlayDetailPage> createState() => _PlayDetailPageState();
}

class _PlayDetailPageState extends State<PlayDetailPage> {
  PageController? _pageController;

  @override
  void initState() {
    _pageController = PageController(
      initialPage: 1,
      keepPage: true,
    );

    super.initState();
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  // 歌词 封面
  Widget _lyricsAndAlbum() {
    return Expanded(
      flex: 7,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: PageView(
          scrollDirection: Axis.horizontal,
          controller: _pageController,
          children: [
            Container(
              color: Colors.blue,
              child: Text("歌词"),
            ),
            Container(
              color: Colors.yellow,
              child: Text("封面"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _someButtons() {
    return Expanded(
        flex: 1,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                  onPressed: () {},
                  child: Icon(Icons.control_point),
                )),
                Expanded(
                    child: ElevatedButton(
                  onPressed: () {},
                  child: Icon(Icons.alarm),
                )),
                Expanded(
                    child: ElevatedButton(
                  onPressed: () {},
                  child: Icon(Icons.playlist_play),
                )),
              ],
            )));
  }

  // 进度条
  Widget _progressBar() {
    return Expanded(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                  child: GetBuilder<PlayController>(
                    id: ConstValues.ProgressBarPositionId,
                    builder: (controller) {
                      return Text(TimeUtil.formatTime(
                          controller.position.inMilliseconds));
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: GetBuilder<PlayController>(
                  id: ConstValues.ProgressBarPositionId,
                  builder: (controller) {
                    return musicProgressIndicator(
                        position: controller.position.inMilliseconds,
                        duration: controller.duration.inMilliseconds);
                  },
                ),
              ),
              Expanded(
                  child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                child: GetBuilder<PlayController>(
                  id: ConstValues.ProgressBarDurationId,
                  builder: (controller) {
                    return Text(TimeUtil.formatTime(
                        controller.duration.inMilliseconds));
                  },
                ),
              )),
            ],
          ),
        ));
  }

  // 播放控制按钮
  Widget _playButtons() {
    return Expanded(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: Row(
            children: [
              Expanded(
                child: GetBuilder<PlayController>(
                  id: ConstValues.PlayModeId,
                  builder: (controller) {
                    Icon myIcon;
                    if (controller.mode == PlayMode.random) {
                      myIcon = const Icon(Icons.shuffle);
                    } else if (controller.mode == PlayMode.sequence) {
                      myIcon = const Icon(Icons.low_priority);
                    } else {
                      myIcon = const Icon(Icons.repeat_one);
                    }
                    return IconButton(
                        onPressed: () {
                          controller.changePlayMode();
                        },
                        icon: myIcon);
                  },
                ),
              ),
              Expanded(
                child: GetBuilder<PlayController>(
                  builder: (controller) {
                    return IconButton(
                        iconSize: 30,
                        onPressed: () {
                          controller.previousSong();
                        },
                        icon: const Icon(Icons.first_page));
                  },
                ),
              ),
              Expanded(
                  child: GetBuilder<PlayController>(
                id: ConstValues.PlayButtonId,
                builder: (controller) {
                  return IconButton(
                      iconSize: 30,
                      onPressed: () {
                        controller.playOrPause();
                      },
                      icon: Icon(controller.playerState == PlayerState.playing
                          ? Icons.pause
                          : Icons.play_arrow));
                },
              )),
              Expanded(
                child: GetBuilder<PlayController>(
                  builder: (controller) {
                    return IconButton(
                        iconSize: 30,
                        onPressed: () {
                          controller.nextSong();
                        },
                        icon: const Icon(Icons.last_page));
                  },
                ),
              ),
              Expanded(
                child: IconButton(
                    iconSize: 30,
                    onPressed: () {},
                    icon: const Icon(Icons.more_horiz)),
              ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(ConstValues.PageName_PlayDetail),
      ),
      body: Flex(
        direction: Axis.vertical,
        children: [
          _lyricsAndAlbum(),
          _someButtons(),
          _progressBar(),
          _playButtons(),
        ],
      ),
    );
  }
}
