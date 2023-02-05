import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localmusicapp/components/BottomPlayBar.dart';
import 'package:localmusicapp/components/DrawerMenu.dart';
import 'package:localmusicapp/components/SingleSong.dart';
import 'package:localmusicapp/config/ConstValues.dart';
import 'package:localmusicapp/controller/SongListController.dart';
import 'package:localmusicapp/notification/notification_service.dart';

class AllSongPage extends StatefulWidget {
  const AllSongPage({Key? key}) : super(key: key);

  @override
  State<AllSongPage> createState() => _AllSongPageState();
}

class _AllSongPageState extends State<AllSongPage> {
  @override
  Widget build(BuildContext context) {
    SongListController songListController = Get.find<SongListController>();
    songListController.fetchAllSong();


    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   NotificationService().showNotifications();
    // });

    return Scaffold(
      appBar: AppBar(
        title: const Text(ConstValues.PageName_AllPage),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      drawer: const DrawerMenu(),
      body: Column(
        children: [
          GetBuilder<SongListController>(
              id: ConstValues.AllSongPageId,
              builder: (_) {
                return Expanded(
                    child: ListView.builder(
                        itemCount: _.songList.length,
                        itemBuilder: (context, index) {
                          String songTitle =
                              _.songList.elementAt(index).songTitle ??
                                  ConstValues.unkown;
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
