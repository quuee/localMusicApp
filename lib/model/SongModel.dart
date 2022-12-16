
class SongModel{

  int? id;
  String? songTitle;
  String? songFileUrl;
  String? singer;
  String? album;

  SongModel(this.id, this.songTitle, this.songFileUrl,this.singer, this.album);

  SongModel.fromJson(Map<dynamic, dynamic> json)
      : id = json["id"],
        songTitle = json["songTitle"],
        songFileUrl = json["songFileUrl"],
        singer = json["singer"],
        album = json["album"];

  Map<String, dynamic> toJson() => {
    "id": id,
    "songTitle": songTitle,
    "songFileUrl": songFileUrl,
    "singer": singer,
    "album": album,
  };

  @override
  String toString() {
    return 'SongModel{id: $id, songTitle: $songTitle, songFileUrl: $songFileUrl, singer: $singer, album: $album}';
  }
}