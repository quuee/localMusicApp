
class SongMapper {
  static const String tableName = "t_song";
  static const String id = "id";
  static const String songTitle = "songTitle";
  static const String songFileUrl = "songFileUrl";
  static const String singer = "singer";
  static const String album = "album";
  static String createSql = '''
            drop table if exists $tableName;
            create table if not exists $tableName ( 
              $id integer primary key autoincrement, 
              $songTitle text not null,
              $singer text not null,
              $songFileUrl text not null,
              $album text null
            );
            ''';
  static String createSql2 = "create table t_song ("
      "id integer primary key autoincrement,"
      "songTitle text not null,"
      "songFileUrl text not null,"
      "singer text null,"
      "album text null);";
}