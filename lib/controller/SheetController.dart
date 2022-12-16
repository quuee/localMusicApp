import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:localmusicapp/model/mapper/SheetMapper.dart';
import 'package:localmusicapp/model/SheetModel.dart';
import 'package:localmusicapp/util/SqfliteUtil.dart';
import 'package:sqflite/sqflite.dart';

/// 歌单控制器
class SheetController extends GetxController {
  Database? _database;
  List<SheetModel> sheetList = [];

  @override
  void onInit() {
    Get.log("onInit");
    // 从数据库中获取歌单信息
    _database = SqfliteUtil.db;

    fetchAllSheet();
    super.onInit();
  }

  @override
  void onReady() {
    Get.log("onReady");
    super.onReady();
  }

  @override
  void onClose() {
    Get.log("onClose");
    super.onClose();
  }

  void addSheet(String sheetName) async {
    SheetModel sheet = SheetModel(null,sheetName,1, "");
    sheet.id = await _database!.insert(SheetMapper.tableName, sheet.toJson());
    sheetList.add(sheet);
    update();
  }

  Future<void> fetchAllSheet() async {
    List<Map<String, dynamic>> maps = await _database!.query(
      SheetMapper.tableName,
      columns: [
        SheetMapper.id,
        SheetMapper.sheetName,
        SheetMapper.sequence,
        SheetMapper.imageUrl
      ],
      // where: "$_sheetName like concat(%,?,%)",
      // whereArgs: [sheetName],
    );
    List<SheetModel> map = maps.map((e) => SheetModel.fromJson(e)).toList();
    Get.log("fetchAllSheet -> 查询到：${map.length}条");
    sheetList.addAll(map);
    update();
  }

  Future<void> refreshSheet() async {
    sheetList.clear();
    await fetchAllSheet();

  }
}
