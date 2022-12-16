
import 'package:get/get.dart';
import 'package:localmusicapp/controller/PlayController.dart';
import 'package:localmusicapp/controller/SheetController.dart';
import 'package:localmusicapp/controller/SongListController.dart';

class AllControllerBingding extends Bindings {

  @override
  void dependencies() {

    Get.lazyPut<SheetController>(() => SheetController());
    Get.lazyPut<PlayController>(() => PlayController());
    Get.lazyPut<SongListController>(() => SongListController());
  }



}