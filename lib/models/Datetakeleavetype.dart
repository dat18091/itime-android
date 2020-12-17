
import 'dart:convert';

List<Datetakeleavetype> datetakeleavetypesFromJson(String str) => List<Datetakeleavetype>.from(json.decode(str).map((x) => Datetakeleavetype.fromJson(x)));

String datetakeleavetypeToJson(List<Datetakeleavetype> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Datetakeleavetype {
  Datetakeleavetype({
    this.id,
    this.name,
    this.status,
    this.note,
    this.maCongTy,
    this.createdAt,
    this.updatedAt,
  });

  String id;
  String name;
  String status;
  String note;
  String maCongTy;
  DateTime createdAt;
  DateTime updatedAt;

  factory Datetakeleavetype.fromJson(Map<String, dynamic> json) => Datetakeleavetype(
    id: json["id"],
    name: json["name"],
    status: json["status"],
    note: json["note"],
    maCongTy: json["ma_cong_ty"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "status": status,
    "note": note,
    "ma_cong_ty": maCongTy,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
