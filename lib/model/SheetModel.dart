
/// 歌单实体类
class SheetModel {

  int? id;
  String? sheetName;
  int? sequence;
  String? imageUrl;

  SheetModel(
    this.id,
    this.sheetName,
    this.sequence,
    this.imageUrl,
  );

  SheetModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        sheetName = json["sheetName"],
        sequence = json["sequence"],
        imageUrl = json["imageUrl"];

  Map<String, dynamic> toJson() => {
    "id": id,
    "sheetName": sheetName,
    "sequence": sequence,
    "imageUrl": imageUrl,
  };
}