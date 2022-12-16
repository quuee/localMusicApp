import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localmusicapp/controller/ChooseSongController.dart';
import 'package:localmusicapp/controller/SongListController.dart';

/// 歌单添加歌曲选择页面
class ChooseSongPage extends StatelessWidget {
  const ChooseSongPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get.find<ChooseSongController>().fetchAllSong();
    return Scaffold(
      appBar: AppBar(
        title: const Text("选择歌曲"),
      ),
      body: GetBuilder<ChooseSongController>(
        builder: (controller) {
          return ListView.builder(
              itemCount: controller.chooseList.length,
              itemBuilder: (context, index) {
                ChooseSong chooseSong = controller.chooseList[index];
                return Row(
                  children: [
                    const Padding(
                        padding: EdgeInsets.all(6.0),
                        child: Icon(
                          Icons.music_note,
                          size: 40,
                        )),
                    Expanded(child: Text(chooseSong.songTitle ?? "")),
                    IconButton(
                        onPressed: () {
                          controller.checkOrCancel(chooseSong.songId!);
                        },
                        icon: Icon(chooseSong.check
                            ? Icons.check_box_outlined
                            : Icons.check_box_outline_blank))
                  ],
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ChooseSongController chooseSongController = Get.find<ChooseSongController>();

          Get.find<SongListController>().songIntoSheet(chooseSongController.chooseList);

          Get.back();
        },
        child: const Icon(Icons.done),
      ),
    );
  }
}
