import 'package:hive/hive.dart';

part 'photo_model.g.dart';

@HiveType(typeId: 0)
class Photo extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String url;

  @HiveField(2)
  String description;

  @HiveField(3)
  String location;

  @HiveField(4)
  String createdBy;

  @HiveField(5)
  DateTime takenAt;

  @HiveField(6)
  DateTime createdAt;

  Photo({
    required this.id,
    required this.url,
    required this.description,
    required this.location,
    required this.createdBy,
    required this.takenAt,
    required this.createdAt,
  });

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
    id: json['id'],
    url: json['url'],
    description: json['description'],
    location: json['location'],
    createdBy: json['createdBy'],
    takenAt: DateTime.parse(json["takenAt"]),
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "url": url,
    "description": description,
    "location": location,
    "createdBy": createdBy,
    "takenAt": takenAt,
    "createdAt": createdAt,
  };
}
