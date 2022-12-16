
class SheetSongMapper{

  static const String tableName = "t_sheet_song";
  static const String id = "id";
  static const String sheetId = "sheetId";
  static const String songId = "songId";
  static const String sequence = "sequence";

  static String createSql = '''
            drop table if exists $tableName;
            create table if not exists $tableName ( 
              $id integer primary key autoincrement, 
              $sheetId integer not null,
              $songId integer not null,
              $sequence integer default 1
            );''';

  static String createSql2 = "create table t_sheet_song ("
      "id integer primary key autoincrement,"
      "sheetId integer not null,"
      "songId integer not null,"
      "sequence integer default 1);";
}