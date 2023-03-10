
class SheetSongModel {

  int? id;
  int? sheetId;
  int? songId;
  int? sequence;

  SheetSongModel(
    this.id,
    this.sheetId,
    this.songId,
    this.sequence,
  );

  SheetSongModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        sheetId = json["sheetId"],
        songId = json["songId"],
        sequence = json["sequence"];

  Map<String, dynamic> toJson() => {
    "id": id,
    "sheetId": sheetId,
    "songId": songId,
    "sequence": sequence,
  };
}