import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localmusicapp/controller/SongListController.dart';

class SingleSheet extends StatelessWidget {
  const SingleSheet(this.sheetName, this.sheetId, {Key? key}) : super(key: key);

  final String sheetName;
  final int sheetId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.log("点击歌单到歌曲列表");
        Get.toNamed("/play_list", arguments: {"sheetId": sheetId});
      },
      child: Row(
        children: [
          const Icon(
            Icons.format_list_bulleted_sharp,
            size: 35,
          ),
          Expanded(
              child: Text(
            sheetName,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 20),
          )),
          const Icon(Icons.more_vert)
        ],
      ),
    );
  }
}
