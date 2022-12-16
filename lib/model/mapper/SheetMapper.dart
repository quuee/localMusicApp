

class SheetMapper {

  static const String tableName = "t_sheet";
  static const String id = "id";
  static const String sheetName = "sheetName";
  static const String sequence = "sequence";
  static const String imageUrl = "imageUrl";

  // 不能创建表
  static String createSql = '''
            drop table if exists $tableName;
            create table if not exists $tableName ( 
              $id integer primary key autoincrement, 
              $sheetName text not null,
              $sequence integer default 1,
              $imageUrl text
            );
            ''';

  static String createSql2 = "create table t_sheet ("
      "id integer primary key autoincrement, "
      "sheetName text not null,"
      "sequence integer default 1,"
      "imageUrl text null);";



  // static Future insert(SheetModel sheet) async {
  //   _database = SqfliteUtil.db;
  //   sheet.id = await _database!.insert(_tableName, sheet.toJson());
  // }
  //
  // static Future insertList(List<SheetModel> playList) async {
  //   _database = SqfliteUtil.db;
  //   Batch batch = _database!.batch();
  //   for (var l in playList) {
  //     batch.insert(_tableName, l.toJson());
  //   }
  //
  //   return await batch.commit();
  // }
  //
  // static Future<SheetModel?> query(int id) async {
  //   _database = SqfliteUtil.db;
  //   List<Map<String,dynamic>> maps = await _database!.query(
  //     _tableName,
  //     columns: [_id, _sheetName, _sequence,_imageUrl],
  //     where: "$_id=?",
  //     whereArgs: [id],
  //     limit: 1,
  //   );
  //   if (maps.length == 1) {
  //     return SheetModel.fromJson(maps.first);
  //   } else {
  //     return null;
  //   }
  // }
  //
  // static Future<List<SheetModel>> queryList() async {
  //   _database = SqfliteUtil.db;
  //   List<Map<String,dynamic>> maps = await _database!.query(
  //     _tableName,
  //     columns: [_id, _sheetName, _sequence,_imageUrl],
  //     // where: "$_sheetName like concat(%,?,%)",
  //     // whereArgs: [sheetName],
  //   );
  //   List<SheetModel> map = maps.map((e) => SheetModel.fromJson(e)).toList();
  //   return map;
  // }
  //
  // static Future delete(int id) async {
  //   _database = SqfliteUtil.db;
  //   return await _database!.delete(
  //     _tableName,
  //     where: '$_id=?',
  //     whereArgs: [id],
  //   );
  // }
  //
  // static Future update(SheetModel sheet) async {
  //   _database = SqfliteUtil.db;
  //   return await _database!.update(_tableName, sheet.toJson(),
  //       where: '$_id=?', whereArgs: [sheet.id]);
  // }
}