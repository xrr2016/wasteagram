import '../exports.dart';

class WasteItem {
  WasteItem({
    required this.photo,
    required this.location,
    required this.waste,
    required this.date,
  });

  final String photo;
  final String location;
  final int waste;
  final Timestamp date;

  WasteItem copyWith({
    required String photo,
    required String location,
    required int waste,
    required Timestamp date,
  }) =>
      WasteItem(
        photo: photo,
        location: location,
        waste: waste,
        date: date,
      );

  factory WasteItem.fromRawJson(String str) =>
      WasteItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WasteItem.fromJson(Map<String, dynamic> json) => WasteItem(
        photo: json["photo"],
        location: json["location"],
        waste: json["waste"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "photo": photo,
        "location": location,
        "waste": waste,
        "date": date,
      };
}
