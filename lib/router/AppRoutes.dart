import 'package:get/get.dart';
import 'package:localmusicapp/pages/all_song/AllSongPage.dart';
import 'package:localmusicapp/pages/play_detail_page/PlayDetailPage.dart';
import 'package:localmusicapp/pages/play_list/ChooseSongPage.dart';
import 'package:localmusicapp/pages/play_list/PlayListPage.dart';
import 'package:localmusicapp/pages/scan_page/ScanPage.dart';
import 'package:localmusicapp/pages/sheet/SheetPage.dart';

class AppRouter {
  static const AllSong = "/all_song";
  static const Scan = "/scan";
  static const Sheet = "/sheet";
  static const PlayList = "/play_list";
  static const PlayDetail = "/play_detail";
  static const ChooseSong = "/choose_song";

  static final routes = <GetPage>[
    GetPage(name: AllSong, page: () => AllSongPage()),
    GetPage(name: Scan, page: () => ScanPage()),
    GetPage(name: Sheet, page: () => SheetPage()),
    GetPage(name: PlayList, page: () => PlayListPage()),
    GetPage(name: PlayDetail, page: () => PlayDetailPage()),
    GetPage(name: ChooseSong, page: () => ChooseSongPage()),
  ];
}
