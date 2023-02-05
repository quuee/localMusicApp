import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:localmusicapp/components/DrawerMenu.dart';
import 'package:localmusicapp/config/ConstValues.dart';
import 'package:localmusicapp/controller/SongListController.dart';
import 'package:localmusicapp/model/SongModel.dart';
import 'package:localmusicapp/notification/notification_service.dart';
import 'package:permission_handler/permission_handler.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  MethodChannel methodChannel = const MethodChannel('getMusicMethodChannel');

  @override
  void initState() {
    //申请权限
    requestPermission();

    super.initState();
  }

  void _getMusic() async {
    final List<dynamic> result =
        await methodChannel.invokeMethod("getAllMusic");
    SongListController songListController = Get.find<SongListController>();
    List<SongModel> songList = [];
    for (var element in result) {
      // debugPrint("android返回的数据: $element");
      SongModel songModel = SongModel.fromJson(element);
      Get.log("转换后的数据：${songModel.toString()}");
      songList.add(songModel);
    }
    songListController.addSongList(songList);
  }

  Future<void> requestPermission() async {
    PermissionStatus permissionStatus = await Permission.storage.request();

    if (permissionStatus.isDenied) {
      // 退出当前Navigator.pop(context);

      // 退出程序
      SystemNavigator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(ConstValues.PageName_Scan),
        ),
        drawer: const DrawerMenu(),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    _getMusic();
                    //扫描完成后提示完成
                    Get.defaultDialog(
                      content: Text("扫描完成"),
                    );
                  },
                  child: Text("扫描歌曲")),
              ElevatedButton(
                  onPressed: () {
                    NotificationService().showNotifications();
                  },
                  child: Text("测试通知"))
            ],
          ),
        ));
  }
}
