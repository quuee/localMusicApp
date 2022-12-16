import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:localmusicapp/model/SheetMapper.dart';
import 'package:localmusicapp/model/SheetModel.dart';
import 'package:localmusicapp/util/SqfliteUtil.dart';
import 'package:sqflite/sqflite.dart';

class SheetController extends GetxController {
  Database? _database;
  List<SheetModel> sheetList = [];

  @override
  void onInit() {
    debugPrint("onInit");
    // 从数据库中获取歌单信息
    _database = SqfliteUtil.db;

    fetchAllSheet();
    super.onInit();
  }

  @override
  void onReady() {
    debugPrint("onReady");
    super.onReady();
  }

  @override
  void onClose() {
    debugPrint("onClose");
    super.onClose();
  }

  void addSheet(String sheetName) async {
    SheetModel sheet = SheetModel(id:null,sheetName: sheetName,sequence: 1,imageUrl: "");
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
    debugPrint("fetchAllSheet -> 查询到：${map.length}条");
    sheetList.addAll(map);
    update();
  }

  Future<void> refreshSheet() async {
    sheetList.clear();
    await fetchAllSheet();

  }
}
